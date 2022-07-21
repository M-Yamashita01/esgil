# frozen_string_literal: true

require_relative '../../lib/esgil/commit_messages'

RSpec.describe Esgil::CommitMessages do
  describe '#add' do
    subject(:add_message) { described_class.new(messages: []).add(message: message) }

    let(:message) { 'sample message' }

    it 'get instance of CommitMessage class' do
      commit_message = add_message
      expect(commit_message.class.name).to eq('Esgil::CommitMessages')
    end

    it 'include commit message' do
      commit_message = add_message
      expect(commit_message.messages.size).to eq(1)
      expect(commit_message.messages.first).to eq(message)
    end
  end

  describe '#get_specific_message' do
    subject(:get_specific_message) { described_class.new(messages: sample_messages).get_specific_messages(specific_message: specific_message) }

    let(:sample_message) { 'sample message' }
    let(:sample_message2) { 'example sample' }
    let(:sample_message3) { 'example test' }

    let(:sample_messages) { [sample_message, sample_message2, sample_message3] }

    context 'when we pass word as argument' do
      let(:specific_message) { 'sample' }

      it 'get messages with the word only' do
        commit_messages = get_specific_message
        expect(commit_messages.messages.size).to eq(2)
        puts commit_messages.messages.inspect
        commit_messages.messages.all? { |message| expect(message).to eq(specific_message) }
      end
    end

    context 'when we pass regular expression' do
      let(:specific_message) { 'example [a-z]*' }

      it 'get messages matched the regular expressions' do
        commit_messages = get_specific_message
        expect(commit_messages.messages.size).to eq(2)
        expect(commit_messages.messages).to contain_exactly(sample_message2, sample_message3)
      end
    end
  end

  describe '#uniq' do
    subject(:uniq_message) { described_class.new(messages: sample_messages).uniq }

    let(:sample_message) { 'sample message' }
    let(:sample_message2) { 'sample message' }
    let(:sample_message3) { 'example test' }

    let(:sample_messages) { [sample_message, sample_message2, sample_message3] }

    it 'get commit messages with unique messages' do
      commit_messages = uniq_message
      expect(commit_messages.messages.size).to eq(2)
      expect(commit_messages.messages).to contain_exactly(sample_message, sample_message3)
    end
  end
end
