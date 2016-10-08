require_relative './bootstrap.rb'
require 'rake/testtask'

Rake::TestTask.new() do |t|
  t.libs << FileList['app/**']
  t.test_files = FileList['test/**/test*.rb']
end
