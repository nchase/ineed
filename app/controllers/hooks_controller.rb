class HooksController < ApplicationController
  def call
    puts params.inspect
    requester = Requester.find_or_create_by(name: 'User', phone: params['Caller'])
    c = Call.create call_sid: params['CallSid'], from: requester.phone, requester: requester
    response = Twilio::TwiML::Response.new do |r|
      r.Say 'What do you need?', voice: 'woman'
      r.Record timeout: 4, transcribe: true, transcribeCallback: "http://ineedvp.heroku.com/call/transcribed?requester_id=#{requester.id}&call_id=#{call.id}", action: "http://ineedvp.heroku.com/call/after_record"
    end

    render text: response
  end

  def after_record
    response = Twilio::TwiML::Response.new do |r|
      r.Say "Thanks. I'll call you back when we find something.", voice: 'woman'
      r.Hangup
    end

    render text: response
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
    requester = Requester.find params['requester_id']
    Request.create requester: requester, text: text, allow_callback: true, expires_at: 5.minutes.from_now, job_date: 2.hours.from_now
  end

  def sms
#    render text: @
  end
end
