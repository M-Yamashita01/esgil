# frozen_string_literal: true

require_relative '../../lib/esgil/options'

RSpec.describe Esgil::Options do
  describe '.parse' do
    subject { described_class.parse(command_line_args: command_line_args)}

    context 'when all arguments exist' do
      let(:command_line_args) { ['--from', 'from_test', '--to', 'to_test', '--message', 'test_message'] }

      it 'gets instance variable in Esgil::Option class' do
        options = subject
        expect(options.from_branch).to eq('from_test')
        expect(options.to_branch).to eq('to_test')
        expect(options.message).to eq('test_message')
      end
    end

    context 'when short arguments exist' do
      let(:command_line_args) { ['-f', 'from_test', '-t', 'to_test', '-m', 'test_message'] }

      it 'gets instance variable in Esgil::Option class' do
        options = subject
        expect(options.from_branch).to eq('from_test')
        expect(options.to_branch).to eq('to_test')
        expect(options.message).to eq('test_message')
      end
    end

    context 'when some arguments exist' do
      let(:command_line_args) { ['--from', 'from_test', '--to', 'to_test'] }

      it 'gets ArgumentsError exception' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end

    context 'when illegal options exist' do
      let(:command_line_args) { ['--test'] }

      it 'gets OptionParser::InvalidOption exception' do
        expect { subject }.to raise_error(OptionParser::InvalidOption)
      end
    end

    context 'when unnecessary options exist' do
      let(:command_line_args) { ['--from', 'from_test', '--to', 'to_test', '--message', 'test_message', 'sample'] }

      it 'gets ArgumentsError exception' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
