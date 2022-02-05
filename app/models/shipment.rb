class Shipment < ApplicationRecord
  belongs_to :user

  validates_presence_of :name, :company_name, :reference_number

  after_create do
    SendShipmentConfirmationJob.perform_later self
  end
end
