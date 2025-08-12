class CreateLinks < ActiveRecord::Migration[7.0]
  def change
    create_table :links, id: false do |t|
      t.primary_key :id
      t.string :run_id, null: false
      t.string :test_id, null: false
      t.string :status
      t.datetime :completed_at
    end

    add_foreign_key :links, :runs, column: :run_id, primary_key: :id
    add_foreign_key :links, :tests, column: :test_id, primary_key: :id
    add_index :links, [:run_id, :test_id]
  end
end