require 'cucumber/rake/task'

task :default => [:spec, :features]

task :watch do |t|
  sh 'watchr', 'spec/support/autotest.watchr'
end

task :spec do |t|
  sh 'node_modules/.bin/cappuccino', '--coffee', '--color', '--verbose', 'spec'
end

Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = %w{--format pretty spec}
end