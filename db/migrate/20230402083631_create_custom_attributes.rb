class CreateCustomAttributes < ActiveRecord::Migration[7.0]
  def change
    create_table :custom_attributes do |t|
      t.references :targetable, polymorphic: true, index: true, null: true
      t.string :name
      t.boolean :required_create, default: false
      t.boolean :required_update, default: false
      t.string :value

      t.timestamps
    end
  end
end
