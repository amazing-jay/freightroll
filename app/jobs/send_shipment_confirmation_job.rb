class SendShipmentConfirmationJob < ApplicationJob
  queue_as :default

  def perform(shipment)
    # Do something later
  end
end
