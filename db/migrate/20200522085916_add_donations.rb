class AddDonations < ActiveRecord::Migration[6.0]
  def change
    create_table(:donations) do |t|
      t.references :person, index: true, null: false
      t.string :description, limit: 1023
      t.decimal :amount, precision: 12, scale: 2
      t.date :issued_at
    end
  end
end
