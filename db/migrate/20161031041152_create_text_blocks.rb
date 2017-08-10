class CreateTextBlocks < ActiveRecord::Migration[5.0]
  def change
    create_table :text_blocks do |t|
      t.references :image
      t.string :text
      t.integer :x1
      t.integer :x2
      t.integer :y1
      t.integer :y2

      t.timestamps
    end
  end
end
