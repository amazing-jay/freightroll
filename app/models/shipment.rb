class Shipment < ApplicationRecord
  belongs_to :user

  after_create do
    SendShipmentConfirmationJob.perform_later self
  end
end
