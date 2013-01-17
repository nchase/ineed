class Request
  include Mongoid::Document

  field :text, type: String
  field :allow_callback, type: Boolean
  field :job_date, type: Date
  field :expires_at, type: Date

  belongs_to :requester
  has_many :responses

end
