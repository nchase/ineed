class Call
  include Mongoid::Document

  field :call_sid, type: String
  field :from, type: String
  field :transcription_sid, type: String

  belongs_to :requester
end
