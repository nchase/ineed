class Request
  include Mongoid::Document

  field :text, type: String
  field :allow_callback, type: Boolean
  field :job_date, type: DateTime
  field :expires_at, type: DateTime

  belongs_to :requester
  has_many :responses

end
