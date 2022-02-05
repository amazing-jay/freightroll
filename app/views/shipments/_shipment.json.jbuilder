json.extract! shipment, :id, :user_id, :name, :company_name, :reference_number, :created_at, :updated_at
json.url shipment_url(shipment, format: :json)
