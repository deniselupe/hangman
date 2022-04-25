# frozen_string_literal: true

# This module provides instructions to the game and display text
module Instructions
  def introduction
    Stylable.clear_screen

    puts <<~INTRO
      HANGMAN

      You have eight turns to guess the secret word which is between
      five to twelve characters long.

      GAME MENU:
      [1] NEW GAME
      [2] LOAD GAME
    INTRO
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

  # The guessing prompt that players see every turn
  def guess_prompt
    display_output

    print "\nGuessing Rules: \n\tYou can only guess one letter at a time. \n\tPrevious guesses are not allowed."
    print "\n\nEnter a guess, 'save' to save your progress, or 'exit' to quit game: "
  end

  # Prompts the player for a file name for their saved game file
  def save_instructions
    display_output
    print "\nEnter the name of you save file: "
    gets.chomp
  end

  # Creates the hash that will list the saved game files for the player when loading existing game
  def game_file_list
    game_files = Dir.glob('./save_files/*yaml').map { |fname| File.basename(fname).split('.')[0] }
    game_file_list = {}
    game_files.each_with_index { |fname, index| game_file_list[index + 1] = fname }
    game_file_list
  end

  # Prompts player to select the game file to resume game instance
  def load_game_instructions
    saved_games = game_file_list
    Stylable.clear_screen
    puts 'SAVED GAME FILES:'
    saved_games.each { |file| print "\n[#{file[0]}] #{file[1]}" }
    print "\n\nPlease select the game file you'd like to load: "

    until (option = gets.chomp.to_i).between?(1, saved_games.length)
      print "\nInvalid option. Please select the game file you'd like to load: "
    end

    "./save_files/#{saved_games[option]}.yaml"
  end
end
