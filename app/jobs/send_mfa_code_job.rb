class SendMfaCodeJob < ApplicationJob
  queue_as :default

  def perform(phone)
    # Do something later
  end
end
