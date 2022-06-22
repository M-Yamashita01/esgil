# frozen_string_literal: true

class Options
  attr_reader :from_branch
  attr_reader :to_branch
  attr_reader :message

  def initialize(args:)
    if args[0] != '--from'
      raise ArgumentError.new('from option does not exist.')
    end

    @from_branch = args[1]

    if args[2] != '--to'
      raise ArgumentError.new('to option does not exist.')
    end

    @to_branch = args[3]

    if args[4] != '--message'
      raise ArgumentError.new('to option does not exist.')
    end

    @message = args[5]
  end
end
