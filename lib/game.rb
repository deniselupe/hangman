# frozen_string_literal: true

require_relative 'stylable'
require_relative 'instructions'
require_relative 'storage'

# Activating Monkey Patch so that CLI can have colored text
String.include Stylable::String

# This is the class for the game
class Game
  attr_reader :guess, :save_fname

  include Instructions
  include Storage

  def initialize
    @word = File.readlines('./lib/word_list.txt').sample.strip
    @turns_left = 8
    @winner = false
    @remaining_letters = ('a'..'z').to_a
    @solved_guess = []
    @wrong_guess = []
    @display = Array.new(@word.length, '_')
    game_intro
  end

  private

  # Introduces game and asks player to start new game or load existing game
  def game_intro
    introduction
    print "\nSelect Game Option: "

    until (option = gets.chomp).match?(/^[1-2]{1}$/)
      introduction
      print "\nNot a valid option. Please select a valid game option: "
    end

    play_game if option == '1'
    load_game if option == '2'
  end

  # The game loops until there are no turns left or until the player wins
  def play_game
    until @turns_left.zero? || @winner == true
      guess_prompt
      input_guess
      break if @guess.match?(/^(save|exit)$/)

      eval_guess(guess)
      @turns_left -= 1
      winner_check
    end

    puts "\nQuitting game without saving progress. Goodbye!" if @guess.match?(/^exit$/)
    save_progress if @guess.match?(/^save$/)
  end

  # This ensures we get a qualified guess, 'save' to save progress, or 'exit' to quit game
  def input_guess
    loop do
      guess_prompt
      @guess = gets.chomp.downcase

      if @guess.match?(/^[a-z]{1}$/) && @remaining_letters.include?(@guess)
        @remaining_letters.delete_at(@remaining_letters.index(guess))
        break
      elsif @guess.match?(/^(save|exit)$/)
        break
      end
    end
  end

  # Evaluates a guess to determine if it's correct or not, and also updates @display value
  def eval_guess(guess)
    @display = []
    temp_word = @word.split('').map { |char| char }

    # If the guess is correct, the letter gets placed in @solved_guess, otherwise it goes in @wrong_guess
    temp_word.any? { |char| char == guess } ? @solved_guess.push(guess) : @wrong_guess.push(guess)

    # Updates the display to let the player know how much many letters they've guessed correctly so far
    temp_word.each do |char|
      @solved_guess.any? { |letter| letter == char } ? @display.push(char) : @display.push('_')
    end
  end

  # Evaluates if the player wins or losses
  def winner_check
    display_output
    @winner = true unless @display.include?('_')

    if @winner == false && @turns_left.zero?
      print "\nYou are out of turns. You lose!"
      print "\nSecret Word: #{@word}"
      delete_save_file
    elsif @winner == true
      print "\nYou guessed the secret word! You win!"
      delete_save_file
    end
  end
end
