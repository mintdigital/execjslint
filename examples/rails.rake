require 'jslint'

task :jslint do
  t0 = Time.now
  errors = []
  num = 0
  exclude = %w[ jquery-1.4.4.js jquery-1.4.4.min.js ].
    map {|js| 'public/javascripts/' << js }

  (Dir['public/javascripts/**/*.js'] - exclude).map do |f|
    num += 1
    result = JSLint.run(File.open(f))
    errors << result.error_messages.map {|e| "#{f}:#{e}"} if !result.valid?
  end
  begin
    if errors.any?
      puts *errors
      raise 'JSLint failed.'
    end
  ensure
    puts "Ran #{num} JSLint tests in #{Time.now.to_f - t0.to_f} seconds"
  end
end
