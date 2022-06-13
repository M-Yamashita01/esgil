# frozen_string_literal: true

require_relative '../../lib/esgil/commit_finder'

RSpec.describe Esgil::CommitFinder do
  describe '#find' do
    let(:from_branch) { 'develop' }
    let(:to_branch) { 'staging' }
    let(:message) { 'test' }

    subject { described_class.new(from_branch: from_branch, to_branch: to_branch).find(message: message) }

    it 'get messages contains message' do
      messages = subject
      messages.all? do |target_message|
        target_message.contains?(message)
      end
    end
  end
end
