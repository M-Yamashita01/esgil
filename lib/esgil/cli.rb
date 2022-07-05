# frozen_string_literal: true

require_relative 'commit_finder'
require_relative 'commit_messages'

module Esgil
  STATUS_SUCCESS = 0
  STATUS_ERROR = 1

  class Cli
    def run(args)
      from_branch = args[0]
      to_branch = args[1]
      message = args[2]

      commit_finder = CommitFinder.new(from_branch: from_branch, to_branch: to_branch)
      commit_messages = commit_finder.find(message: message)

      commit_messages.messages.each do |message|
        puts target_message
      end

      STATUS_SUCCESS
    rescue StandardError => err
      logger.error(err.message)
      logger.error(err.backtrace)
      STATUS_ERROR
    end
  end
end
