class ProvidersController < ApplicationController
  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.create params[:provider]
    redirect_to @provider
  end

  def show
    @provider = Provider.find params[:id]
  end

  def index
    @providers = Provider.all
  end
end
