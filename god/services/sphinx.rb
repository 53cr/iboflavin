God.watch do |w|
  port = 3312

  config_path = "#{RAILS_ROOT}/config/development.sphinx.conf"
  
  index_cmd = "indexer --config #{config_path} --all --rotate"
  
  w.pid_file = File.join(APP_ROOT, "shared/log/sphinx.#{port}.pid")
  w.name = "iboflavin-sphinx-#{port}"
  w.interval = 30.seconds
  w.start   = "searchd -c #{config_path}"
  w.stop    = "kill -TERM `cat #{w.pid_file}`"

  w.start_grace = 10.seconds
  w.restart_grace = 10.seconds
  
  w.behavior(:clean_pid_file)

  w.start_if do |start|
    start.condition(:process_running) do |c|
      c.interval = 5.seconds
      c.running = false
    end
  end
  
  w.restart_if do |restart|
    restart.condition(:memory_usage) do |c|
      c.above = 150.megabytes
      c.times = [3, 5] # 3 out of 5 intervals
    end
    
    restart.condition(:cpu_usage) do |c|
      c.above = 50.percent
      c.times = 5
    end
  end
  
  # lifecycle
  w.lifecycle do |on|
    on.condition(:flapping) do |c|
      c.to_state = [:start, :restart]
      c.times = 5
      c.within = 5.minute
      c.transition = :unmonitored
      c.retry_in = 10.minutes
      c.retry_times = 5
      c.retry_within = 2.hours
    end
  end
end
