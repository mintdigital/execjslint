begin
  require 'jslint/testtask'

  JSLint::TestTask.new do |t|
    t.file_list = Dir['{app,lib}/assets/javascripts/**/*.js']
    t.options = {
      browser: true,
      nomen: true,
      plusplus: true,
      sloppy: true,
      white: true
    }
  end
  Rake::Task[:test].enhance(['jslint'])
rescue LoadError
  # JSLint not loaded (eg, in production). Oh well.
end
