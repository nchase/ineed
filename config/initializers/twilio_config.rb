require 'twilio-ruby'

TWILIO_SID='ACdbc13fd8e1a4fd41747e6f068e1989c7'
TWILIO_TOKEN='e1259d9aade88b5cc7bc682f381288d7'
TWILIO_FROM_NUMBER='+12408216249'

def twilio_client
  $twilio_client ||= Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
end