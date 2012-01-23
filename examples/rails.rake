require 'jslint'

task :jslint do
  Dir['{app,lib,public}/javascripts/**/*.js'].each do |f|
    begin
      JSLint.test(File.open(f))
    rescue JSLint::LintError => e
      e.errors.compact.each {|err| puts "#{f}:#{err['line']}: #{err['reason']}" }
      raise
    end
  end
end
