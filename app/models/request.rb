class Request
  include Mongoid::Document
  include Mongoid::Timestamps
  include ActionView::Helpers::DateHelper

  field :text, type: String
  field :allow_callback, type: Boolean
  field :job_date, type: DateTime
  field :expires_at, type: DateTime

  belongs_to :requester
  has_many :responses

  after_create :create_pending_responses


  def create_pending_responses
    keywords = []
    text.split(/[^a-z]/i).each do |word|
      if word.length > 3
        keywords << word.downcase
      end
    end

    providers = Provider.find_by_keywords keywords
    puts "Creating #{providers.length} responses"
    providers.each do |p|
      Response.create request: self, provider: p, status: 'pending'
    end
  end

  def first_accepted_response
    responses.where(status: 'answered', accepted: true).sort(created_at: 1).first
  end

  def to_short_string
    "#{text} on #{job_date}"
  end

  def print_job_date
    time_ago_in_words(self.job_date) + ' ago'
  rescue
    'some time ago'
  end

  def pretty_text
    "&ldquo" + self.text + "&rdquo;"
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
