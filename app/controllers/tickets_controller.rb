class TicketsController < ApplicationController
  def create
    @form = TicketApi.new(form_params)

    if @form.save
      render status: 200
    else
      render status: 422, json: { errors: [ @form.errors ] }
    end
  end

  private

  def form_params
    params.permit(:user_id, :title, :tags)
  end
end
