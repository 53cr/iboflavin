# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require(File.join(File.dirname(__FILE__), 'config', 'boot'))

require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'

#metric_fu
require(File.join(RAILS_ROOT, 'vendor', 'gems', 'jscruggs-metric_fu-1.1.5', 'lib', 'metric_fu'))

# plugin stuff
desc 'Default: run unit tests.'
task :default => :test

desc 'Test the core plugin.'
Rake::TestTask.new(:test) do |t|
  t.libs << 'lib'
  t.libs << 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = true
end

desc 'Generate documentation for the core plugin.'
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'Core'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

require 'tasks/rails'

begin
  require 'vlad'
  Vlad.load :app => 'passenger', :scm => 'git'

  class Vlad::Git

  set :source, Vlad::Git.new
  set :git_cmd, "git"

  ##
  # Returns the command that will check out +revision+ from the
  # repository into directory +destination+.  +revision+ can be any
  # SHA1 or equivalent (e.g. branch, tag, etc...)

  def checkout(revision, destination)
    destination = File.join(destination, 'repo')
    revision = 'HEAD' if revision =~ /head/i
    [ "rm -rf #{destination}",
      "#{git_cmd} clone #{repository} #{destination}",
      "cd #{destination}",
      "#{git_cmd} checkout -f -b deployed-#{revision} #{revision}",
      "git submodule init",
      "git submodule update",
      "echo updating db",
      "cd -",
    ].join(" && ")
  end

  ##
  # Returns the command that will export +revision+ from the current directory
  # into the directory +destination+.
  # Expects to be run from +scm_path+ after Vlad::Git#checkout

  def export(revision, destination)
    revision = 'HEAD' if revision =~ /head/i
    revision = "deployed-#{revision}"

    #"#{git_cmd} archive --format=tar #{revision} | (cd #{destination} && tar xf -)",

    [ "mkdir -p #{destination}",
      "cd repo",
      "cp -R . #{destination}",
      "cd -",
      "cd .."
    ].join(" && ")
  end

  ##
  # Returns a command that maps human-friendly revision identifier +revision+
  # into a git SHA1.

  def revision(revision)
    revision = 'HEAD' if revision =~ /head/i
    "`#{git_cmd} rev-parse #{revision}`"
  end
end
rescue LoadError
end


