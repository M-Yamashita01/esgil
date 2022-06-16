# frozen_string_literal: true

module Esgil
  class CommitFinder
    def initialize(from_branch:, to_branch:)
      if from_branch.empty?
        raise ArgumentError.new('Set the from_branch.')
      end

      @git = Git.open(Dir.pwd)

      if !branch_exists?(branch: from_branch)
        raise ArgumentError.new("branch does not exist. branch: #{from_branch}")
      elsif !branch_exists?(branch: to_branch)
        raise ArgumentError.new("branch does not exist. branch: #{to_branch}")
      end

      @from_branch = from_branch
      @to_branch = to_branch
    end

    def find(message:)
      target_messages = []
      @git.log.between(@from_branch, @to_branch).each do |commit|
        commit_message = commit.message
        target_message = commit_message[/#{message}/]
        if target_message
          target_messages << commit_message
        end
      end

      target_messages
    end

    private

    def branch_exists?(branch:)
      local_branch_exists?(branch: branch) || remote_branch_exists?(branch: branch)
    end

    def local_branch_exists?(branch:)
      @git.branches.local.any? do |local_branch|
        local_branch.full == branch
      end
    end

    def remote_branch_exists?(branch:)
      @git.branches.remote.any? do |local_branch|
        local_branch.full == branch
      end
    end
  end
end
