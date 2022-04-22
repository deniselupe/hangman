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

  def save_instructions
    display_output
    print "\nEnter the name of you save file: "
    gets.chomp
  end

  def load_game_instructions
    game_files = Dir.glob('../save_files/*yaml').map { |fname| File.basename(fname).split('.')[0] }
    game_file_list = {}
    game_files.each_with_index { |fname, index| game_file_list[index + 1] = fname }

    Stylable.clear_screen
    puts 'SAVED GAME FILES:'
    game_file_list.each { |file| print "\n[#{file[0]}] #{file[1]}" }

    print "\n\nPlease select the game file you'd like to load: "

    until (option = gets.chomp.to_i).between?(1, game_files.length)
      Stylable.clear_screen
      puts 'SAVED GAME FILES:'
      game_file_list.each { |file| print "\n[#{file[0]}] #{file[1]}" }
      print "\n\nInvalid option. Please select the game file you'd like to load: "
    end

    "../save_files/#{game_file_list[option]}.yaml"
  end
end
