# frozen_string_literal: true

require 'yaml'
require_relative 'instructions'

# This module helps create, store, locate, and load game save files
module Storage
  def save_progress
    fname = "../save_files/#{save_instructions}.yaml"

    save_info = YAML.dump({
                            'word' => @word,
                            'turns_left' => @turns_left,
                            'winner' => @winner,
                            'remaining_letters' => @remaining_letters,
                            'solved_guess' => @solved_guess,
                            'wrong_guess' => @wrong_guess,
                            'display' => @display,
                            'guess' => @guess
                          })

    File.open(fname, 'w') { |file| file.puts save_info }
  end
end
