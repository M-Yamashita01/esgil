# frozen_string_literal: true

require 'optparse'

module Esgil
  class Options
    attr_reader :from_branch
    attr_reader :to_branch
    attr_reader :message

    def self.parse(command_line_args:)
      option_parser = define_options
      left_arguments = option_parser.parse(command_line_args)
      if !left_arguments.empty?
        raise ArgumentError.new("invalid option: #{left_arguments.join(',')}")
      end

      if !all_options_exist?
        raise ArgumentError.new('from_branch, to_branch and message options are required.')
      end

      Esgil::Options.new(from_branch: @options[:from_branch], to_branch: @options[:to_branch], message: @options[:message])
    end

    private

    def self.define_options
      @options = {}

      option_parser = OptionParser.new
      option_parser.on('--from FROM_BRANCH') { |v| @options[:from_branch] = v }
      option_parser.on('--to FROM_BRANCH') { |v| @options[:to_branch] = v }
      option_parser.on('--message MESSAGE') { |v| @options[:message] = v }
    end

    def self.all_options_exist?
      @options.has_key?(:from_branch) && @options.has_key?(:to_branch) && @options.has_key?(:message)
    end

    def initialize(from_branch:, to_branch:, message:)
      @from_branch = from_branch
      @to_branch = to_branch
      @message = message
    end
  end
end
