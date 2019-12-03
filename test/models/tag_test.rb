require 'test_helper'

class TagTest < ActiveSupport::TestCase
  test 'valid tag' do
    tag = Tag.new(name: "help")
    assert tag.valid?
  end

  test 'invalid without name' do
    tag = Tag.new(name: nil)
    refute tag.valid?, 'tag is not valid without a name'
    assert_not_nil tag.errors[:user_id], 'no validation error for name present'
  end

  test 'has many tickets' do
    tag = Tag.create(name: "problem")
    ticket1 = Ticket.create(user_id: 2, title: 'ticket1')
    ticket2 = Ticket.create(user_id: 2, title: 'ticket2')
    ticket3 = Ticket.create(user_id: 2, title: 'ticket3')
    
    tag.add_ticket(ticket1)
    tag.add_ticket(ticket2)
    tag.add_ticket(ticket3)
    assert tag.tickets.count == 3, "count is wrong"
  end

  test 'name will downcase on creation' do
    tag = Tag.create(name: "BIG HERE")
    assert tag.name == "big here", 'should be downcased'    
  end
end
