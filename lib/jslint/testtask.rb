require 'rake'
require 'jslint'

module JSLint
  class TestTask
    include Rake::DSL

    # Public: Gets/Sets the Array of JavaScript filenames as Strings, each of
    # which will be run through JSLINT. (default: Dir['**/*.js'])
    attr_accessor :file_list

    # Public: Gets/Sets the Hash of options that will be passed to each call
    # of JSLINT. See http://www.jslint.com/lint.html for allowed options.
    # (default: {})
    attr_accessor :options

    # Public: Define a new Rake task that runs JSLint tests over several
    # JavaScript files.
    #
    # name - the name of the defined Rake Task. (default: 'jslint')
    #
    # Yields itself for configuration if a block is given.
    def initialize(name=:jslint)
      @name = name
      @file_list = Dir['**/*.js']
      @options   = {}
      yield self if block_given?

      define_task
    end

    # Internal: Define the actual Rake task.
    def define_task
      desc "Run #{@name == :jslint ? '' : @name} JSLint tests"
      task @name do
        t0 = Time.now
        errors = []

        @file_list.each do |f|
          result = JSLint.run(File.open(f), @options)
          if result.valid?
            print '.'
          else
            errors << result.error_messages.map {|e| "#{f}:#{e}"}
            print 'F'
          end
        end

        puts
        puts
        if errors.any?
          puts *errors
          puts
        end
        puts "Finished in %.5f seconds" % [Time.now.to_f - t0.to_f]
        puts "%d files, %d errors"      % [@file_list.length, errors.length]
      end
    end

  end
end
