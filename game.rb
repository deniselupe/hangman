# frozen_string_literal: true

# This is the class for the game
class Game
  attr_accessor :word, :turns_left, :winner, :remaining_letters, :solved_guess, :wrong_guess, :display

  def initialize
    @word = File.readlines('word_list.txt').sample.strip
    @turns_left = 7
    @winner = false
    @remaining_letters = ('a'..'z').to_a
    @solved_guess = []
    @wrong_guess = []
  end

  # The game loops until there are no turns left or until the player wins
  def play_game
    until @turns_left.negative? || @winner == true
      guess = input_guess
      eval_guess(guess)
      display_output
      puts "\nYou have #{@turns_left} guesses left."
      @turns_left -= 1
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
    temp_word.any? { |char| char == guess } ? @solved_guess.push(guess) : @wrong_guess.push(guess)

    temp_word.each do |char|
      solved_guess.any? { |letter| letter == char } ? @display.push(char) : @display.push('_')
    end
  end

  def display_output
    puts "\n-----------------------------"
    puts "\nProgress:"
    puts "\n#{@display.join(' ')}"
    puts "\n\nIncorrect Guesses:"
    puts "\n#{@wrong_guess.join(', ')}"
    puts "\n-----------------------------"
  end
end
