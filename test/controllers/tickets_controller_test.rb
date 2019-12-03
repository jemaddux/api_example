require 'test_helper'

class TicketsControllerTest < ActionDispatch::IntegrationTest
  test 'create' do
    ticket_count = Ticket.count
    post '/tickets/create', params: {"user_id" => 1, "title" => "hmmmm"}
    assert_response :success
    assert Ticket.count == ticket_count + 1
  end
end
