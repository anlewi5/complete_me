require "rake"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
  t.verbose = true
end

task default: :test

# https://ruby-doc.org/stdlib-2.0.0/libdoc/rake/rdoc/Rake/TestTask.html
