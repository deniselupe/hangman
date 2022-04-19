# frozen_string_literal: true

# This is the class for the game
class Game
  attr_accessor :word, :turns_left, :winner, :solved_guess, :wrong_guess

  def initialize
    @word = File.readlines('word_list.txt').sample.strip
    @turns_left = 8
    @winner = false
  end
end
