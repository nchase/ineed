class RequestsController < ApplicationController
  def new
    @request = Request.new
  end

  def create
    @request = Request.create params[:request]
    redirect_to @request
  end

  def show
    @request = Request.find params[:id]
  end
end
