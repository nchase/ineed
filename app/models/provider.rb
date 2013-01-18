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


  def self.find_by_keywords(keywords)
    Provider.in(specialties: keywords)
  end

  def latest_response
    responses.sort{|x,y| x.created_at <=> y.created_at}.first
  end

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

  def list_specialties
    self.specialties.to_a.to_sentence
  end
end
