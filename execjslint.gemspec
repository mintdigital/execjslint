Gem::Specification.new do |s|
  s.name      = 'execjslint'
  s.version   = '0.10.1'
  s.date      = '2012-03-23'

  s.homepage    = "http://github.com/mintdigital/execjslint"
  s.summary     = "ExecJS JSLint Bridge"
  s.description = <<-EOS
    A bridge to run JSLint from Ruby via ExecJS.
  EOS

  s.files = [
    'lib/execjslint.rb',
    'lib/jslint.rb',
    'lib/jslint/testtask.rb',
    'LICENSE',
    'README.md'
  ]

  s.add_dependency 'rake', '>= 0.8.7'
  s.add_dependency 'jslint-source'
  s.add_dependency 'execjs'
  s.add_development_dependency 'rspec'

  s.authors = ['Dean Strelau']
  s.email   = 'dean@mintdigital.com'
end
