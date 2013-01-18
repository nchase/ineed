class Request
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String
  field :allow_callback, type: Boolean
  field :job_date, type: DateTime
  field :expires_at, type: DateTime

  belongs_to :requester
  has_many :responses

  def to_short_string
    "#{text} on #{job_date}"
  end

  def on_new_response(response)
    fully_collected = false

    if expires_at > Time.now
      # Expire all others
      responses.each do |r|
        
      end
      fully_collected = true
    end

    unless fully_collected
      # Check to see if we have all of the responses
      fully_collected = false if responses.find { |r| r.status == 'pending' }
    end

    if fully_collected
      # Message user
      
    end
  end

end
