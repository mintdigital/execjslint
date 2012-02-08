require 'rspec'
require 'jslint'

describe JSLint do
  describe '.context' do
    subject { JSLint.context }

    it 'returns an ExecJS context with JSLINT defined' do
      subject.eval('typeof JSLINT').should == 'function'
    end

    it 'returns an ExecJS context with JSLINTR helper defined' do
      subject.eval('typeof JSLINTR').should == 'function'
    end
  end

  describe '.run' do
    let(:context) { double(call: [true,[]]) }
    before { JSLint.stub(context: context) }

    it 'lints a String of JS' do
      context.should_receive(:call).with('JSLINTR', 'foo', {})
      JSLint.run('foo')
    end

    it 'lints an IO-ish of JS' do
      ioish = Class.new { def self.read ; 'foo' ; end }
      context.should_receive(:call).with('JSLINTR', 'foo', {})
      JSLint.run(ioish)
    end

    it 'returns a Result object' do
      JSLint.run('').should be_an_instance_of JSLint::Result
    end

    it 'accepts JSLINT options' do
      context.should_receive(:call).with('JSLINTR', 'foo', {sloppy: true})
      JSLint.run('foo', sloppy: true)
    end
  end
end

describe JSLint::Result do
  let(:errors) {
    [{'line' => 1, 'character' => 1, 'reason' => 'FUBAR' }]
  }

  describe '#error_messages' do
    it 'returns the line/char number and reason for each error' do
      JSLint::Result.new(false, errors).error_messages.should ==
        [ "1:1: FUBAR" ]
    end
  end

  describe '#valid?' do
    it 'is true for problem free JS' do
      JSLint::Result.new(true,[]).valid?.should == true
    end

    it 'is false for troublesome JS' do
      JSLint::Result.new(false,errors).valid?.should == false
    end
  end
end

describe 'JSLint integration' do
  it 'knows valid JS' do
    js = 'function one() { "use strict"; return 1; }'
    JSLint.run(js).valid?.should == true
  end

  it 'knows invalid JS' do
    js = "function one() { return 1 }"
    JSLint.run(js).valid?.should == false
  end

  it 'respects inline jslint options' do
    js = "/*jslint  sloppy: true */\nfunction one() { return 1; }"
    JSLint.run(js).valid?.should == true
  end

  it 'respects passed jslint options' do
    js = "function one() { return 1; }"
    JSLint.run(js, sloppy: true).valid?.should == true
  end
end
