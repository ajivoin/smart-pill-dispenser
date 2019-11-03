module ApplicationHelper
    def text_to_take_pills(message)
        boot_twilio
        sms = @client.messages.create(
          from: Rails.application.secrets.twilio_number,
          to: '+12166306996',
          body: message
        )
        if sms.present?
            print("TAKE PILLS TEXT")
        end
    end

    def text_to_refill_pills(message)
        boot_twilio
        sms = @client.messages.create(
          from: Rails.application.secrets.twilio_number,
          to: '+15136209711',
          body: message
        )
        if sms.present?
            print("REFILL TEXT")
        end
    end

    private

    def boot_twilio
    account_sid = Rails.application.secrets.twilio_sid
    auth_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new account_sid, auth_token
    end
end
