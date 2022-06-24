# frozen_string_literal: true

require_relative '../../lib/esgil/commit_finder'
require_relative '../../lib/esgil/commit_messages'

RSpec.describe Esgil::CommitFinder do
  describe '#find' do
    let(:from_branch) { 'develop' }
    let(:to_branch) { 'staging' }
    let(:message) { 'test' }

    let(:commit) { Git::Object::Commit.new(nil, nil) }
    let(:commit2) { Git::Object::Commit.new(nil, nil) }
    let(:commit3) { Git::Object::Commit.new(nil, nil) }
    let(:commit_message) { 'test message' }
    let(:commit_message2) { 'sample test message' }
    let(:commit_message3) { 'sample message' }
    let(:commits) { [commit, commit2, commit3] }

    subject { described_class.new(from_branch: from_branch, to_branch: to_branch).find(message: message) }

    before do
      # TODO Replace allow_any_instance_of with another mock codes.
      allow_any_instance_of(described_class).to receive(:branch_exists?).and_return(true)
      allow_any_instance_of(Git::Object::Commit).to receive(:check_commit).and_return(true)
      allow_any_instance_of(Git::Log).to receive(:between).and_return(commits)
      allow_any_instance_of(Git::Log).to receive(:each).and_return(commits)

      commit.instance_variable_set(:@message, commit_message)
      commit2.instance_variable_set(:@message, commit_message2)
      commit3.instance_variable_set(:@message, commit_message3)
    end

    it 'get messages contains message' do
      commit_messages = subject
      expect(commit_messages.messages).to contain_exactly('test', 'test')
    end
  end
end
