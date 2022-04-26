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

  # Creates and returns the hash of saved game files located in the saved_files directory
  def game_file_list
    game_files = Dir.glob('./save_files/*yaml').map { |fname| File.basename(fname).split('.')[0] }
    game_file_list = {}
    game_files.each_with_index { |fname, index| game_file_list[index + 1] = fname }

    # Returns a hash of saved game files
    game_file_list
  end

  # Prompts player to select the game file to resume game instance
  # The prompt also allows the player to enter 'back' to return to the main menu
  def load_game_instructions
    print 'SAVED FILES:'
    game_file_list.each { |file| print "\n[#{file[0]}] #{file[1]}" }
    print "\n\nSelect the game file you'd like to load, or 'back' to return to the main menu: "
    option = gets.chomp

    until option.to_i.between?(1, game_file_list.length) || option.match?(/^back$/)
      print "\nInvalid option. Select the game file you'd like to load, or 'back' to return to the main menu: "
      option = gets.chomp
    end

    option
  end

  def load_game_menu
    Stylable.clear_screen
    option = load_game_instructions
    game_intro if option.match?(/^back$/)
    load_game("./save_files/#{game_file_list[option.to_i]}.yaml") if option.to_i.between?(1, game_file_list.length)
  end
end
