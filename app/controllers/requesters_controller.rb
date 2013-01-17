class RequestersController < ApplicationController
  def new
    @requester = Requester.new
  end

  def create
    @requester = Requester.create params[:requester]
    redirect_to @requester
  end

  def show
    @requester = Requester.find params[:id]
  end
end
