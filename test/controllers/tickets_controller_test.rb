require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test 'create' do
    Tag.delete_all
    TicketTag.delete_all
    ticket_count = Ticket.count
    post '/tickets/create', params: {user_id: 1, title: "hmmmm"}
    assert Ticket.count == ticket_count + 1
  end

  test 'invalid create' do
    ticket_count = Ticket.count
    post '/tickets/create', params: {"title" => "hmmmm"}
    assert_response 422
    assert Ticket.count == ticket_count
  end
end
