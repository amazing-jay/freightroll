class CreateShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.string :company_name
      t.string :reference_number

      t.timestamps null: false
    end
  end
end
