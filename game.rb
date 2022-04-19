# frozen_string_literal: true

# This is the class for the game
class Game
  attr_accessor :word, :turns_left, :winner, :solved_guess, :wrong_guess

  def initialize
    @word = File.readlines('word_list.txt').sample.strip
    @turns_left = 8
    @winner = false
  end

  # The game loops until there are no turns left or until the player wins
  def play_game
    until @turns_left.negative? || @winner == true
      guess = input_guess
    end
  end

  # This prompts the player to make their next guess
  def input_guess
    print "\nWhat's the next letter? "

    until (guess = gets.chomp.downcase).match?(/^[a-z]{1}$/)
      print "\nYou can only guess one letter at a time. Please try again: "
    end

    guess
  end
end
