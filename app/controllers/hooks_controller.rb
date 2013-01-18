class HooksController < ApplicationController
  def call
    requester = Requester.find_or_create_by(name: 'User', phone: params['Caller'])
    c = Call.create call_sid: params['CallSid'], from: requester.phone, requester: requester
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'What do you need?', voice: 'woman'
      r.Record timeout: 4, transcribe: true, playBeep: false, transcribeCallback: "http://ineedvp.heroku.com/call/transcribed", action: "http://ineedvp.heroku.com/call/after_record"
    end

    render text: response.text
  end

  def after_record
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Thanks. I'll call you back when we find something.", voice: 'woman'
      r.Hangup
    end

    render text: response.text
  end

  def transcribed
    sid = params['TranscriptionSid']
    text = params['TranscriptionText']
    status = params['TranscriptionStatus']
    url = params['TranscriptionUrl']
    recordingSid = params['RecordingSid']
    recordingUrl = params['RecordingUrl']

    params['call_id']

    puts "Transcribed: #{text}"

    c = Call.where(call_sid: params['CallSid']).first
    text = twilio_client.account.calls.get(c.call_sid).recordings.list[0].transcriptions.list[0].transcription_text
    request = Request.create requester: c.requester, text: text, allow_callback: true, expires_at: 5.minutes.from_now, job_date: 2.hours.from_now

    render nothing: true
  end

  def sms
    params['SmsSid']
    params['AccountSid']
    from = normalize_phone(params['From'])
    params['To']
    body = params['Body']

    provider = Provider.where(phone: from).first rescue nil
    unless provider.nil?
      response = provider.latest_response
      if response.nil?
        puts "ERROR: No responses for: #{provider}"
      else
        response.respond(body =~ /y|yes|yeah|accept/i) if response.status == 'pending'
      end
    end

    requester = Requester.where(phone: from).first rescue nil
    unless requester.nil?
      if body =~ /call/i
        latest_request = requester.latest_request
        earliest_response = request.first_accepted_response rescue nil
        if earliest_response
          requester.send_sms("Auto-dialing is coming soon!")
        else
          puts "ERROR: No earliest response for: #{requester.name} (#{from}) - #{latest_request}"
        end
      end
    end

    puts "ERROR: Unrecognized provider: #{from}" if requester.nil? && provider.nil?
    render nothing: true
  end


  private

  def normalize_phone(p)
    p.sub('+1', '')
  end
end
