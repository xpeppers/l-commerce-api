namespace :user  do
  desc "create an user"
  task :create, [:id] => :environment do |t, args|
    user = User.create(email: 'fakeemail@provider.com', provider_user_id: args.id)
    puts "Created user with id: #{user.id}"
  end
end
