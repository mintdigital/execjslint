require 'rspec'
require 'jslint'

describe 'JSLint.context' do
  subject { JSLint.context }
  it 'returns an ExecJS context with JSLINT defined' do
    subject.eval('typeof JSLINT').should == 'function'
  end

  it 'returns an ExecJS context with JSLINTR helper defined' do
    subject.eval('typeof JSLINTR').should == 'function'
  end
end

describe 'JSLint.test' do
  it 'raises nothing when successful' do
    JSLint.test('')
  end

  it 'raises LintError with errors when JSLint fails' do
    -> { JSLint.test('function one() { return 1; }') }.
      should raise_error(JSLint::LintError) do |e|
        e.errors[0]['raw'].should == "Missing 'use strict' statement."
      end
  end

  it 'respects passed options' do
    JSLint.test('function one() { return 1; }', sloppy: true)
  end
end
