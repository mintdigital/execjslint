ExecJSLint
==========

ExecJSLint is a thin Ruby wrapper that uses ExecJS to execute [Douglas Crockford's JSLint][jslint].

Install
-------

```
$ gem install execjslint
```

Usage
-----

```ruby
js = File.open('path/to/my.js')
results = JSLint.run(js)
if result.problems.any?
  puts "You suck at JavaScript!"
  puts results.problems
else
  puts "GREAT SUCCESS!"
end
```

If you're looking to use this in a Rails app, take a look at
[examples/jslint.rake][rake].

Requirements
------------

You'll need one of the [supported ExecJS runtimes][execjs-runtimes]. OS X
comes with JavaScriptCore by default, so you likely don't need to install
anything.

JSLint Options
--------------

Right now, `ExecJSLint` does not support setting global JSLint options, so you'll
have to include them in a `/*jslint */` comment at the top of each file.
`jslint.js` will automatically parse and apply options specified like this. A
full list of options is available on [jslint.com][jslint-options].

Using an Alternate jslint.js
----------------------------

ExecJSLint depends on the `jslint-source` gem, which is a ruby packaging
of the official [jslint.js][jslintjs]. By default, ExecJSLint depends on the
latest version of the `jslint-source` gem. As there are no official releases
of JSLint, `jslint-source` is versioned according to [the date at the top of
jslint.js][jslint-date] (eg, `2012.01.23`). rubygems.org has a [full list of
`jslint-source` gem versions][source-versions].

To override this, you can specify an explicit dependency on `jslint-source`,
for example, using bundler:

```
gem 'execjslint'
gem 'jslint-source', '2011.01.23'
```

You can also explicitly specify a local copy of `jslint.js` to use by setting
the `JSLINT_PATH` env variable.

```
$ JSLINT_PATH=../lib/jslint.js rake jslint
```

Similar Projects
----------------

ExecJSLint is meant to be as simple as possible. If it doesn't fit your needs,
you may want to try one of these projects:

* [geraud/jslint][geraud] - rubygem that provides a standalone `jslint` script
  that can be run from the command line. Supports Rhino and Node JavaScript
  engines.

* [psionides/jslint\_on\_rails][on-rails] - rubygem meant for integrating JSLint into a
  Rails application. Uses Rhino JavaScript engine.

* [rondevera/jslintmate][jslintmate] - TextMate plugin for running JSLint. Uses JSC.

[jslint]: <http://jslint.com/>
[rake]: <https://github.com/mintdigital/jslint/blob/master/examples/jslint.rake>
[execjs-runtimes]: <https://github.com/sstephenson/execjs/blob/master/README.md>
[jslintjs]: <https://github.com/douglascrockford/JSLint/blob/master/jslint.js>
[jslint-date]: <https://github.com/douglascrockford/JSLint/blob/master/jslint.js#L2>
[jslint-options]: <http://www.jslint.com/lint.html#options>
[source-versions]: <http://rubygems.org/gems/jslint-source/versions>
[geraud]: <https://github.com/geraud/jslint>
[on-rails]: <https://github.com/psionides/jslint_on_rails>
[jslintmate]: <https://github.com/rondevera/jslintmate>
