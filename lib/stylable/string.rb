# frozen_string_literal: true

# This module provides the tools to create and style a board game for the CLI
module Stylable
  # This module monkey patches core class String by adding methods that manipulate text color
  module String
    def yellow
      "\e[93m#{self}\e[0m"
    end

    def blue
      "\e[94m#{self}\e[0m"
    end

    def purple
      "\e[95m#{self}\e[0m"
    end

    def green
      "\e[92m#{self}\e[0m"
    end

    def cyan
      "\e[96m#{self}\e[0m"
    end

    def red
      "\e[91m#{self}\e[0m"
    end

    def gray
      "\e[37m#{self}\e[0m"
    end

    def italic
      "\e[3m#{self}\e[23m"
    end

    def underline
      "\e[4m#{self}\e[24m"
    end
  end
end
