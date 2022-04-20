# frozen_string_literal: true

require_relative 'display'

# This is the class for the game
class Game
  attr_accessor :word, :turns_left, :winner, :remaining_letters, :solved_guess, :wrong_guess, :display

  include Display

  def initialize
    @word = File.readlines('word_list.txt').sample.strip
    @turns_left = 8
    @winner = false
    @remaining_letters = ('a'..'z').to_a
    @solved_guess = []
    @wrong_guess = []
    @display = []
  end

  # The game loops until there are no turns left or until the player wins
  def play_game
    until @turns_left.zero? || @winner == true
      display_output
      print "You have #{@turns_left} guesses left."
      guess = input_guess
      eval_guess(guess)
      @turns_left -= 1
      winner_check
    end
  end

  # This prompts the player to make their next guess
  def input_guess
    print "\nWhat's the next letter? "

    until (guess = gets.chomp.downcase).match?(/^[a-z]{1}$/) && @remaining_letters.include?(guess)
      print "\nYou can only guess one letter at a time. Previous guesses are not allowed. Please try again: "
    end

    @remaining_letters.delete_at(@remaining_letters.index(guess))
    guess
  end

  # Evaluates a guess to determine if it's correct or not, and also updates @display value
  def eval_guess(guess)
    @display = []
    temp_word = @word.split('').map { |char| char }

    # If the guess is correct, the letter gets placed in @solved_guess, otherwise it goes in @wrong_guess
    temp_word.any? { |char| char == guess } ? @solved_guess.push(guess) : @wrong_guess.push(guess)

    # Updates the display to let the player know how much many letters they've guessed correctly so far
    temp_word.each do |char|
      solved_guess.any? { |letter| letter == char } ? @display.push(char) : @display.push('_')
    end

    display_output
  end

  # Display progress and incorrect guesses made so far
  def display_output
    Display.clear_screen

    unless @display.empty?
      puts "\n-----------------------------"
      puts "\nProgress:"
      puts "\n#{@display.join(' ')}"
      puts "\n\nIncorrect Guesses:"
      puts "\n#{@wrong_guess.join(', ')}"
      puts "\n-----------------------------"
    end
  end

  # Evaluates if the player wins or losses
  def winner_check
    @winner = true unless @display.include?('_')

    if @winner == false && @turns_left.zero?
      puts "\nYou are out of turns. You lose!"
      puts "Secret Word: #{@word}"
    elsif @winner == true
      puts "\nYou guessed the secret word! You win!"
    end
  end
end
