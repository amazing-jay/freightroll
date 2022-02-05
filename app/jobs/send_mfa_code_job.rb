class SendMfaCodeJob < ApplicationJob
  queue_as :default

  def perform(user)
    SendSMS.call(phone: user.phone, message: "#{user.mfa_code} is your FreightRoll verification code.")
  end

  # hack because rails 7 isn't playing well with sidekiq
  def self.perform_later(...)
    perform_now(...)
  end
end
