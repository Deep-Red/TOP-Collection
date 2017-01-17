class CreateEvents < ActiveRecord::Migration[5.0]

  def change
    create_table :events do |t|
      t.references :creator

      t.datetime :date

      t.timestamps
      
    end
  end
end
