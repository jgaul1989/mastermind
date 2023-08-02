# frozen_string_literal: true

# this class contains functionality for the mastermind code breaker
class CodeBreaker
  COLORS = %w[red green blue brown white black orange yellow].freeze

  attr_accessor :cur_guess, :num_guesses, :is_human, :matches

  def initialize
    @num_guesses = 12
    @cur_guess = []
    @is_human = false
    @matches = []
    @all_color_combinations = init_color_combinations
  end

  def computer_guess_algorithm
    4.times do |index|
      next if matches.include? index

      rand_color_index = rand(@all_color_combinations[index].length)
      rand_color = @all_color_combinations[index][rand_color_index]
      @cur_guess[index] = rand_color
      @all_color_combinations[index].delete(rand_color)
    end
  end

  private

  def init_color_combinations
    outer_list = []
    4.times do
      outer_list.push(COLORS.dup)
    end
    outer_list
  end
end
