class CreateAddressCities < ActiveRecord::Migration[7.0]
  def change
    create_table :address_cities do |t|
      t.string :name
      t.string :code
      t.belongs_to :province

      t.timestamps
    end
  end
end
