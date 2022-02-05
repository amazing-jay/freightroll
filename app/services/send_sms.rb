require 'twilio-ruby'

class SendSMS
  include SimpleRubyService::ServiceObject
  attribute :phone, :message

  ACCOUNT_SID = Rails.application.credentials.twilio[:account_sid]
  AUTH_TOKEN = Rails.application.credentials.twilio[:auth_token]
  ORIGIN_PHONE = Rails.application.credentials.twilio[:origin_phone]

  protected

    def perform
      client.messages.create(
        from: ORIGIN_PHONE,
        to: "#+1#{phone}",
        body: message
      )
    end

    def client
      @client ||= Twilio::REST::Client.new ACCOUNT_SID, AUTH_TOKEN
    end
end
