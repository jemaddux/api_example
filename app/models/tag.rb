class Tag < ApplicationRecord
  has_many :ticket_tags
  has_many :tickets, :through => :ticket_tags
  validates :name, presence: true 

  def add_ticket(ticket)
    ticket_tag = TicketTag.find_or_create_by(ticket_id: ticket.id, tag_id: self.id)
    ticket_tag.save
  end
end