require 'rubygems'
require 'bundler'
require 'yard'
require 'rake/testtask'

Bundler::GemHelper.install_tasks

desc 'Run tests'
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList['test/**/*_test.rb']
end

task default: 'test'

YARD::Rake::YardocTask.new(:doc) do |t|
  t.files   = ['lib/**/*.rb', '-', 'README.md']
  t.options = ['no-private']
end
