namespace :db do

  desc 'Bootstrap the database'
  task :bootstrap => :migrate do
    Bootstrap::Manager.load
    Bootstrap::Manager.execute_all
  end

  desc 'Reload the database'
  task :reload => [ :drop, :create, :migrate, :bootstrap ]

end
