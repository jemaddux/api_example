require 'test_helper'

class TicketTest < ActiveSupport::TestCase
  test 'valid ticket' do
    ticket = Ticket.new(user_id: 1, title: 'title here')
    assert ticket.valid?
  end

  test 'invalid without user_id' do
    ticket = Ticket.new(user_id: nil, title: 'title here')
    refute ticket.valid?, 'ticket is not valid without a user_id'
    assert_not_nil ticket.errors[:user_id], 'no validation error for user_id present'
  end

  test 'invalid without title' do
    ticket = Ticket.new(user_id: 1, title: nil)
    refute ticket.valid?, 'ticket is not valid without a title'
    assert_not_nil ticket.errors[:title], 'no validation error for title present'
  end
end
