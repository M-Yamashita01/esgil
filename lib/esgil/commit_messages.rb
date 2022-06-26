# frozen_string_literal: true

module Esgil
  class CommitMessages
    attr_reader :messages

    def initialize(messages:)
      @messages = messages || []
    end

    def add(message:)
      @messages << message
      Esgil::CommitMessages.new(messages: @messages)
    end

    def get_specific_messages(specific_message:)
      extracted_words = @messages.filter_map do |message|
        message[/#{specific_message}/]
      end

      Esgil::CommitMessages.new(messages: extracted_words)
    end

    def uniq
      unique_messages = @messages.uniq
      Esgil::CommitMessages.new(messages: unique_messages)
    end
  end
end
