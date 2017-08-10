class CreateImages < ActiveRecord::Migration[5.0]
  def change
    create_table :images do |t|
      t.string  :filename
      t.boolean :is_complete, default: false
      t.boolean :is_none, default: false

      t.timestamps
    end
  end
end
