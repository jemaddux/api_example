class TicketApi
  require "uri"
  require "net/http"
  require 'resolv-replace'
  require 'json'

  include ActiveModel::Model
  attr_accessor :user_id, :title, :tags
  WEBHOOK_URL = "https://webhook.site/2574393a-a810-40fc-b5c5-ee12873f0c64"

  def save
    ActiveRecord::Base.transaction do
      ticket = Ticket.create(user_id: user_id, title: title)
      if tags
        tags.each do |tag|
          ticket.add_tag(tag)
        end
      end
      add_errors(ticket.errors) if ticket.invalid?
      ticket.save!
      send_webhook if Tag.count > 0
    end
  rescue ActiveRecord::RecordInvalid => exception
    return false
  end

  private

  def send_webhook
    ### This should really be a background job in case it fails
    tag_id_array = TicketTag.pluck(:tag_id)
    tag_count = Hash.new(0)
    tag_id_array.each {|x| tag_count[x] += 1}
    tag_id = tag_count.sort_by { |k, v| v}.last[0]
    tag_name = Tag.find(tag_id).name
    params = {'highestTag' => tag_name}
    Net::HTTP.post_form(URI.parse(WEBHOOK_URL), params)
  end

  def add_errors(model_errors)
    model_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end
end