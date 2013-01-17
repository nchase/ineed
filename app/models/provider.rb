class Provider
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :phone, type: String
  field :address
  field :description, type: String
  field :specialties, type: Array

  has_many :responses

end
