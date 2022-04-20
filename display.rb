# frozen_string_literal: true

# This module provides display features for the game
module Display
  def self.clear_screen
    print "\e[2J\e[H"
  end
end
