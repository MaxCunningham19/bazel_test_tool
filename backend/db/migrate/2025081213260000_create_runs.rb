class CreateRuns < ActiveRecord::Migration[7.0]
  def change
    create_table :runs, id: false do |t|
      t.primary_key :id
      t.string :status
      t.integer :duration_seconds
      t.datetime :started_at
      t.datetime :completed_at

      t.timestamps
    end
  end
end