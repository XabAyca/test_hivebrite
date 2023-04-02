class CreateRegistrations < ActiveRecord::Migration[7.0]
  def change
    create_table :registrations do |t|
      t.integer :number
      t.references :user, index: true, foreignkey: true
      t.references :event, index: true, foreignkey: true

      t.timestamps
    end
  end
end
