class CreateRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :runs, id: false do |t|
      t.primary_key :id
      t.string :status, null: false
      t.datetime :started_at, null: false
      t.datetime :completed_at, null: false
      t.float :duration_seconds, null: false

      t.timestamps
    end
  end
end