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

end
