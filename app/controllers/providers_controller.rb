class ProvidersController < ApplicationController
  def new
    @provider = Provider.new
  end

  def create
    @provider = Provider.create params[:provider]
    redirect_to @provider
  end

  def edit
    @provider = Provider.find params[:id]
  end

  def update
    @provider = Provider.find params[:id]

    specialties = params[:provider][:specialties].split(',')

    params[:provider].delete(:specialties)

    @provider.update_attributes params[:provider]

    @provider.update_attribute :specialties, specialties

    redirect_to @provider
  end

  def show
    @provider = Provider.find params[:id]
  end

  def index
    @providers = Provider.all
  end
end
