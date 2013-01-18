class Response
  include Mongoid::Document
  include Mongoid::Timestamps

  field :text, type: String
  field :status, type: String # pending, answered, expired
  field :accepted, type: Boolean

  belongs_to :provider
  belongs_to :request

  after_create :publish

  # Notify the provider
  def publish
    provider.send_sms("New request: #{request.text}. Type 'Yes' or 'No'")
  end

  def respond(ans, text=nil)
    status = 'answered'
    accepted = ans

    if status == 'answered' && accepted
      request.on_new_response self
      if request.allow_callback
        # ask provider if they want to call right now
        provider.send_sms("Thanks! Reply 'Call' to call your new client.")
      end

      if request.responses.where(status: 'answered', accepted: true).count == 0
        # This is the first answer!
        provider.send_sms("Congrats! You are the first responder! Remember to tell your friends about INeed")
        request.requester.send_sms("#{provider.name} can help you! Reply 'Call' to call them.")
      end
    end

    save
  end

  def accept(text=nil)
    respond(true, text)
  end

  def reject(text=nil)
    respond(false, text)
  end

end
