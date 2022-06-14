# frozen_string_literal: true

module Esgil
  class CommitFinder
    def initialize(from_branch:, to_branch:)
      if from_branch.empty?
        raise ArgumentError.new('from_branch名を指定してください')
      end

      @git = Git.open(Dir.pwd)
      # TODO @gitを使用してfrom_branch、to_branchの存在確認をする
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
  end
end
