class CreateFlights < ActiveRecord::Migration[5.0]
  def change
    create_table :flights do |t|
      t.references :origin, references: :airport
      t.references :destination, references: :airport
      t.datetime :start
      t.string :duration

      t.timestamps
    end
  end
end
