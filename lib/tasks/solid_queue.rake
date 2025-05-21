# lib/tasks/solid_queue.rake
namespace :solid_queue do
  desc "Create Solid Queue tables from db/queue_schema.rb"
  task load_schema: :environment do
    load Rails.root.join("db/queue_schema.rb")
    puts "✅ Solid Queue schema loaded."
  end
end
