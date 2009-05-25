namespace :tokyo do
  desc 'start tokyo stuff'
  task :start do
    system "ttserver -port 45001 arbitraryfilename.tch &"
  end
  
  desc 'stop tokyo stuff #hack'
  task :stop do
    system "sudo killall -9 ttserver"
  end

  desc 'install tokyo stuff'
  task :install do
    # build temp dir
    tmp = "/tmp/#{Time.now.to_i}"
    mkdir_p tmp

    cd tmp
    system 'git clone git://github.com/etrepum/tokyo-cabinet.git'
    cd 'tokyo-cabinet'
    system './configure && make && sudo make install'

    cd tmp
    system 'git clone git://github.com/etrepum/tokyo-tyrant.git'
    cd 'tokyo-tyrant'
    system './configure && make && sudo make install'
    system 'sudo gem install rufus-tokyo'

    #cleanup
    rm_rf tmp

    puts "Run Tyrant server like: ttserver -port 45001 data.tch"
    puts "iBoflavin uses 45001, data.tch will be created."
  end
end
