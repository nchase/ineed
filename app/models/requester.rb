class Requester
  include Mongoid::Document

  field :name, type: String
  field :email, type: String
  field :phone_number, type: String

  has_many :requests

end
