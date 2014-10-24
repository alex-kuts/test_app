class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.string :title
      t.text :value
      t.string :section
      t.string :type
      t.string :section_title
      t.integer :position, :default=>0
      
      
      t.timestamps
    end
  end
end
