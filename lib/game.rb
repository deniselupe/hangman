# frozen_string_literal: true

require_relative 'stylable'

# Activating Monkey Patch so that CLI can have colored text
String.include Stylable::String

# This is the class for the game
class Game
  attr_accessor :word, :turns_left, :winner, :remaining_letters, :solved_guess, :wrong_guess, :display

  def initialize
    @word = File.readlines('word_list.txt').sample.strip
    @turns_left = 8
    @winner = false
    @remaining_letters = ('a'..'z').to_a
    @solved_guess = []
    @wrong_guess = []
    @display = Array.new(word.length, '_')
  end

  # The game loops until there are no turns left or until the player wins
  def play_game
    until @turns_left.zero? || @winner == true
      display_output
      guess = input_guess
      eval_guess(guess)
      @turns_left -= 1
      winner_check
    end
  end

  # This prompts the player to make their next guess
  def input_guess
    print "\nGuessing Rules: \n\tYou can only guess one letter at a time. \n\tPrevious guesses are not allowed."
    print "\n\nEnter a guess, 'save' to save your progress, or 'exit' to quit game: "

    until (guess = gets.chomp.downcase).match?(/^[a-z]{1}$/) && @remaining_letters.include?(guess)
      display_output
      print "\nGuessing Rules: \n\tYou can only guess one letter at a time. \n\tPrevious guesses are not allowed."
      print "\n\nEnter a guess, 'save' to save your progress, or 'exit' to quit game: "
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
  end

  # Display progress and incorrect guesses made so far
  def display_output
    Stylable.clear_screen

    puts 'HANGMAN'
    puts "\n-----------------------------"
    puts "\nProgress:               Turns Left: #{@turns_left}"
    puts "\n#{@display.join(' ')}"
    puts "\n\nIncorrect Guesses:"
    puts "\n#{@wrong_guess.join(', ')}"
    puts "\n-----------------------------"
  end

  # Evaluates if the player wins or losses
  def winner_check
    display_output
    @winner = true unless @display.include?('_')

    if @winner == false && @turns_left.zero?
      print "\nYou are out of turns. You lose!"
      print "\nSecret Word: #{@word}"
    elsif @winner == true
      print "\nYou guessed the secret word! You win!"
    end
  end
end
