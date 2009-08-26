namespace "mongo" do
  desc "Start MongoDB instance"
  task "start" do
    sh "mongod --dbpath ./db/mongodb > /dev/null &"
  end
  desc "Stop ALL MongoDB instances"
  task "stop" do
    sh "sudo killall -9 mongod"
  end
end
