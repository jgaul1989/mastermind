# frozen_string_literal: true

require_relative 'code_maker'
require_relative 'code_breaker'
require_relative 'game'

puts 'Do you want to be the code maker or code breaker? Type breaker or maker.'
game_mode = gets.chomp.downcase.strip

code_maker = CodeMaker.new
code_breaker = CodeBreaker.new

game_mode == 'breaker' ? code_breaker.is_human = true : code_maker.is_human = true
game = Game.new(code_breaker, code_maker)
game.play
