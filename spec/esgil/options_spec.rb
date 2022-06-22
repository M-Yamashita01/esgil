# frozen_string_literal: true

require_relative '../../lib/esgil/options'

RSpec.describe Esgil::Options do
  describe '.parse' do
    context 'when all arguments exist' do
      let(:command_line_args) { ['--from', 'from_test', '--to', 'to_test', '--message', 'test_message'] }

      subject { described_class.parse(command_line_args: command_line_args)}

      it 'gets instance variable in Esgil::Option class' do
        options = subject
        expect(options.from_branch).to eq('from_test')
        expect(options.to_branch).to eq('to_test')
        expect(options.message).to eq('test_message')
      end
    end

    context 'when some arguments exist' do
      let(:command_line_args) { ['--from', 'from_test', '--to', 'to_test'] }

      subject { described_class.parse(command_line_args: command_line_args)}

      it 'gets ArgumentsError exception' do
        expect { subject }.to raise_error(ArgumentError)
      end
    end
  end
end
