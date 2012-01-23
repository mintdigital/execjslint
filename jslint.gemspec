Gem::Specification.new do |s|
  s.name      = 'jslint'
  s.version   = '0.9.0'
  s.date      = '2012-01-23'

  s.homepage    = "http://github.com/mintdigital/jslint"
  s.summary     = "Ruby JSLint Bridge"
  s.description = <<-EOS
    A bridge to run JSLint from Ruby via ExecJS.
  EOS

  s.files = [
    'lib/jslint.rb',
    'LICENSE',
    'README.md'
  ]

  s.add_dependency 'jslint-source'
  s.add_dependency 'execjs'
  s.add_development_dependency 'rspec'

  s.authors = ['Dean Strelau']
  s.email   = 'dean@mintdigital.com'
end
