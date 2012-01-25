require 'execjs'
require 'jslint/source'

module JSLint
  # Internal: The ExecJS Context in which to run JSLINT().
  #
  # Provides a small helper function JSLINTR to return both the JSLINT()
  # return value and the JSLINT.errors object.
  def self.context
    ExecJS.compile(
      JSLint::Source.contents + "\n" +
      "function JSLINTR(source) { return [JSLINT(source),JSLINT.errors]; };"
    )
  end

  # Public: Run JSLint over some JavaScript source.
  #
  # source - some String-like or IO-like JavaScript source.
  def self.run(source)
    source = source.respond_to?(:read) ? source.read : source
    Result.new(*context.call("JSLINTR", source))
  end

  class Result
    def initialize(valid, errors)
      @valid = valid
      @errors = errors
    end

    # Public: Did the JavaScript source pass JSLint without errors?
    #
    # This is the return value of the JSLINT() function.
    #
    # Returns true iff JSLint found no errors.
    def valid?
      @valid
    end

    # Public: A nicely formatted list of errors with their line number.
    #
    # Returns an Array of Strings.
    def error_messages
      # @errors will have a 'nil' last element if JSLINT it hit a catastrophic
      # error before it finished looking at the whole file, so we 'compact'.
      @errors.compact.map {|e|
        "#{e['line']}:#{e['character']}: #{e['reason']}"
      }
    end
  end
end
