class Requester
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :phone_number, type: String

  has_many :requests
  has_one :call


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
