begin
  require 'rspec/core/rake_task'

  RSpec::Core::RakeTask.new(:spec, :tag) do |t, args|
    t.rspec_opts = "--pattern spec/#{args[:tag]}/*_spec.rb"
  end

  task :default => :spec
rescue LoadError
  # no rspec available
end