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

    twilio_client.account.sms.messages.create(
      :from => TWILIO_FROM_NUMBER,
      :to => @provider.real_phone,
      :body => 'Hello, World!'
    )
    @provider.real_phone
  end

  def index
    @providers = Provider.all
  end
end
