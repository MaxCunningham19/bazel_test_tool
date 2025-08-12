class CreateTests < ActiveRecord::Migration[7.0]
  def change
    create_table :tests, id: false do |t|
      t.primary_key :id
      t.string :name
      t.string :status 
      t.string :path

      t.timestamps
    end
  end
end