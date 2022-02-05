class SendShipmentConfirmationJob < ApplicationJob
  queue_as :default

  def perform(shipment)
    SendSMS.call(phone: shipment.user.phone, message: "Shipment confirmed: #{shipment.as_json}.")
  end

  # hack because rails 7 isn't playing well with sidekiq
  def self.perform_later(...)
    perform_now(...)
  end
end
