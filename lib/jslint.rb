require 'execjs'
require 'jslint/source'

module JSLint
  # Public: Error wrapper for invalid JavaScript and ExecJS errors.
  InvalidSource = Class.new(StandardError)

  # Public: Exception thrown when a JSLint error is found.
  class LintError < RuntimeError
    # Public: Returns the errors object from JSLint.
    attr_reader :errors

    def initialize(errors)
      @errors = errors
      super "#{errors.size} JSLint Error#{'s' unless errors.size == 1}"
    end
  end

  # Internal: Represents the result of a JSLint test.
  Result = Struct.new(:success, :errors)

  # Internal: The ExecJS context with JSLINT and JSLINTR functions.
  #
  # Returns an ExecJS::Context.
  def self.context
    @_context ||= ExecJS.compile(jslintr)
  end

  # Internal: The JavaScript test harness used to run JSLint.
  #
  # Returns the script as a String.
  def self.jslintr
    <<-JS
    #{JSLint::Source.contents}

    function JSLINTR(source,options) {
      return [JSLINT(source,options),JSLINT.errors];
    };
    JS
  end

  # Public: Run the given script through JSLint.
  #
  # Examples:
  #
  #   JSLint.test(open('public/javascripts/application.js'))
  #   #=> true
  #
  #   JSLint.test('function WTF();')
  #   #=> JSLint::InvalidSource
  #
  # Returns nothing.
  # Raises JSLint::LintError if an error is found.
  def self.test(io, options={})
    source = io.respond_to?(:read) ? io.read : io
    result = Result.new(*context.call("JSLINTR", source, options))
    raise LintError.new(result.errors) unless result.success
  end
end
