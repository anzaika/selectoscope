root = '/opt/app'
working_directory root
pid "#{root}/tmp/unicorn.pid"
stderr_path "#{root}/log/unicorn.log"
stdout_path "#{root}/log/unicorn.log"

if ENV["RAILS_ENV"] == "development"
  worker_processes 1
else
  worker_processes 4
end
preload_app true
timeout 1000

before_fork do |server, _worker|
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.connection.disconnect!
  # Quit the old unicorn process
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exist?(old_pid) && server.pid != old_pid
    puts "We've got an old pid and server pid is not the old pid"
    begin
      Process.kill('QUIT', File.read(old_pid).to_i)
      puts 'killing master process (good thing tm)'
    rescue Errno::ENOENT, Errno::ESRCH
      puts 'unicorn master already killed'
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  port = 5000 + worker.nr
  child_pid = server.config[:pid].sub('.pid', ".#{port}.pid")
  system("echo #{Process.pid} > #{child_pid}")
  defined?(ActiveRecord::Base) &&
    ActiveRecord::Base.establish_connection
end
