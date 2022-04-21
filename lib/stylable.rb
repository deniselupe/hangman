# frozen_string_literal: true

require_relative 'stylable/string'

# This module provides the tools to create and style a board game for the CLI
module Stylable
  def self.clear_screen
    print "\e[2J\e[H"
  end
end
