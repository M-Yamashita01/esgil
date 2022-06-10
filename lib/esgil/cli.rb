# frozen_string_literal: true

module Esgil
  STATUS_SUCCESS = 0
  STATUS_ERROR = 1

  class Cli
    def run(args)
      from_branch = ''
      if args[0] == '--from'
        from_branch = args[1]
      end

      g = Git.open(Dir.pwd)
      target_messages = []
      g.log.between(from_branch, g.current_branch).each do |commit|
        commit_message = commit.message
        target_message = commit_message[/TEST-\d{4,}/]
        if target_message
          target_messages << target_message
        end
      end

      target_messages.each do |target_message|
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
