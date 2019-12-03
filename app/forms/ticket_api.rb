class TicketApi
  include ActiveModel::Model
  attr_accessor :user_id, :title, :tags

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

      ### Send webhook from here
    end
  rescue ActiveRecord::RecordInvalid => exception
    return false
  end

  private

  def add_errors(model_errors)
    model_errors.each do |attribute, message|
      errors.add(attribute, message)
    end
  end
end