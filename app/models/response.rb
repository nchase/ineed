class Response
  include Mongoid::Document

  field :text, type: String
  field :status, type: String # pending, answered, expired
  field :answer, type: String # yes, no

  belongs_to :provider
  belongs_to :request

end
