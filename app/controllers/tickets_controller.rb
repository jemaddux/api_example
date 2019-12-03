class TicketsController < ApplicationController
  def create
    @form = TicketApi.new(form_params)

    if @form.save
      
    else
      
    end
  end

  private

  def form_params
    params.permit(:user_id, :title, :tags)
  end
end
