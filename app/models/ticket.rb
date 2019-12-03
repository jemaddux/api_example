class Ticket < ApplicationRecord
  has_many :ticket_tags
  has_many :tags, :through => :ticket_tags

  validates :user_id, presence: true 
  validates :title, presence: true 

  def add_tag(tag_name)
    tag = Tag.find_or_create_by(name: tag_name)
    tag.save
    ticket_tag = TicketTag.find_or_create_by(ticket_id: self.id, tag_id: tag.id)
    ticket_tag.save
  end
end
