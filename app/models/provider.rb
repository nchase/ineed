class Provider
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :description, type: String
  field :specialties, type: Array

  # Address
  field :street_address
  field :city, type: String
  field :state, type: String
  field :zip, type: String
  field :country, type: String

  has_many :responses


  def real_phone
    p = phone
    p = '1' + p unless p.start_with? '1'
    p = '+' + p unless p.start_with? '+'
    p
  end

  def send_sms(text)
    twilio_client.account.sms.messages.create(
      from: TWILIO_FROM_NUMBER,
      to: real_phone,
      body: text
    )
  end

end
