class CreateSolidQueueTables < ActiveRecord::Migration[8.0]
  def change
    create_table :solid_queue_processes do |t|
      t.string :queue_name, null: false
      t.string :name, null: false
      t.datetime :last_heartbeat_at, null: false
      t.timestamps
    end

    create_table :solid_queue_jobs do |t|
      t.string :queue_name, null: false
      t.string :job_class, null: false
      t.jsonb :arguments, default: [], null: false
      t.datetime :scheduled_at
      t.datetime :finished_at
      t.timestamps
    end

    create_table :solid_queue_locks do |t|
      t.references :job, null: false, foreign_key: { to_table: :solid_queue_jobs }
      t.string :type, null: false
      t.timestamps
    end
  end
end
