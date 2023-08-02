# frozen_string_literal: true

# this class contains functionality for the mastermind code maker
class CodeMaker
  COLORS = %w[red green blue brown white black orange yellow].freeze

  attr_accessor :code, :is_human

  def initialize
    @code = set_default_code
    @is_human = false
  end

  private

  def set_default_code
    temp = []
    4.times do
      temp.push(COLORS[rand(COLORS.length)])
    end
    temp
  end
end
