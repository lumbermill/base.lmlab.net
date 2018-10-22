namespace :recents do
  desc "Delete records older than 30 days"
  task :delete_30_days_old => :environment do
    puts "hello234"
    # File.write('hello.txt', 'Some glorious content')
    Recent.where(['created_at < ?', 30.days.ago]).destroy_all
    puts "after sql"
  end
end
