require 'faker'

namespace :db do
  desc "Fill database with sample data"
  
  # create a task db:populate, '=> :environment' ensures that the Rake task has access to the local Rails environment,
  # including the User model (and hence User.create!)
  # Call this task in command line with: rake db:populate
  task :populate => :environment do   
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Example User",
                         :email=> "example@railstutorial.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    
    99.times do |n|
      name = Faker::Name.name
      email = "example-#{n+1}@railstutorial.org"
      password = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
  end
end
