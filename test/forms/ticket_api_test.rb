require 'test_helper'

class TicketApiTest < ActiveSupport::TestCase
  test 'valid form' do
    Tag.delete_all
    TicketTag.delete_all
    ticket_api = TicketApi.new(user_id: 1, title: "test", tags: ["help","desk"])
    ticket_api.save
    assert ticket_api.valid?
    ticket = Ticket.last
    assert ticket.tags.count == 2, "count is wrong"
  end

  test 'invalid without user_id' do
    ticket_api = TicketApi.new(user_id: nil, title: "test", tags: nil)
    refute ticket_api.save
    assert_not_nil ticket_api.errors[:user_id]
  end

  test 'invalid without title' do
    ticket_api = TicketApi.new(user_id: 2, title: nil, tags: nil)
    refute ticket_api.save
    assert_not_nil ticket_api.errors[:title]
  end
end
