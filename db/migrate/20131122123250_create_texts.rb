class CreateTexts < ActiveRecord::Migration
  def change
    create_table :texts do |t|
      t.string :key
      t.string :title
      t.text :text
      t.string :meta_title
      t.text :meta_desc
      t.text :meta_key

      t.timestamps
    end
  end
end
