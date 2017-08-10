class CreateTmpImages < ActiveRecord::Migration[5.0]
  def change
    create_table :tmp_images do |t|
      t.string :filename
      t.integer :image_id

      t.timestamps
    end
  end
end
