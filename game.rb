# frozen_string_literal: true

# the interface for playing the game
class Game
  COLORS = %w[red green blue brown white black orange yellow].freeze

  def initialize(code_breaker, code_maker)
    @code_breaker = code_breaker
    @code_maker = code_maker
    @code_broken = false
  end

  def play
    @code_maker.code = select_colors if @code_maker.is_human
    puts "\nYour secret code is #{@code_maker.code}" if @code_maker.is_human
    start_game_loop
    print_game_results
  end

  private

  def select_colors
    valid_input = false
    until valid_input
      puts "\n**Set your secret code**" if @code_maker.is_human
      puts "\nChoose 4 colors from the following list #{COLORS}"
      puts 'Add a space between each color and no punctuation.'
      user_guess = gets.chomp.downcase.strip.split(' ')
      valid_input = user_guess.all? { |color| COLORS.include? color }
      puts 'Invalid color entered ' unless valid_input
    end
    user_guess
  end

  def start_game_loop
    until @code_broken || @code_breaker.num_guesses.zero?
      puts "\n#{@code_breaker.num_guesses} guesses remaining."
      @code_breaker.is_human ? @code_breaker.cur_guess = select_colors : @code_breaker.computer_guess_algorithm
      @code_breaker.num_guesses -= 1
      @code_broken = @code_breaker.cur_guess == @code_maker.code
      next if @code_broken

      find_matches
      sleep(3)
    end
  end

  def print_game_results
    if @code_broken
      puts "\nThe code was solved with #{@code_breaker.num_guesses} guesses remaining!"
    else
      puts "\nThe code was not solved!"
    end
    puts "The secret code was #{@code_maker.code}"
    puts "The final guess was #{@code_breaker.cur_guess}"
  end

  def find_matches
    match_list = []
    matches = 0
    partials = 0
    @code_breaker.cur_guess.each_with_index do |color, index|
      if @code_maker.code[index] == color
        matches += 1
        match_list.push(index)
      elsif @code_maker.code.include?(color)
        partials += 1
      end
    end
    @code_breaker.matches = match_list
    print_feedback(matches, partials)
  end

  def print_feedback(matches, partials)
    puts "\nThe guess was #{@code_breaker.cur_guess}"
    puts "Matches: #{matches}"
    puts "Partial matches: #{partials}"
  end
end
