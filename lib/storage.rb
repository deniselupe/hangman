# frozen_string_literal: true

require 'yaml'
require_relative 'instructions'

# This module helps create, store, locate, and load game save files
module Storage
  # This creates a files that stores the player's progress for their game instance
  def save_progress
    fname = @save_fname.nil? ? "./save_files/#{save_instructions}.yaml" : @save_fname

    save_info = YAML.dump({
                            'word' => @word,
                            'turns_left' => @turns_left,
                            'winner' => @winner,
                            'remaining_letters' => @remaining_letters,
                            'solved_guess' => @solved_guess,
                            'wrong_guess' => @wrong_guess,
                            'display' => @display,
                            'guess' => @guess,
                            'save_fname' => fname
                          })

    File.open(fname, 'w') { |file| file.puts save_info }
    puts "\nYour progress has been saved to file '#{File.basename(fname).split('.')[0]}'. Goodbye!"
  end

  # Player can locate and load their game save file to resume their game instance
  def load_game(fname)
    game_instance = YAML.load_file(fname)

    @word = game_instance['word']
    @turns_left = game_instance['turns_left']
    @winner = game_instance['winner']
    @remaining_letters = game_instance['remaining_letters']
    @solved_guess = game_instance['solved_guess']
    @wrong_guess = game_instance['wrong_guess']
    @display = game_instance['display']
    @guess = game_instance['guess']
    @save_fname = game_instance['save_fname']

    play_game
  end

  # Ensures that the saved game file gets deleted when the player reaches Game Over
  # This reduces clutter by ensuring only games still in progress are saved
  def delete_save_file
    File.delete(@save_fname) unless @save_fname.nil?
  end
end
