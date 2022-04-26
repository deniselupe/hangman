# Hangman

This is my version of Hangman which can be played on the terminal. You can play the live version [here](https://replit.com/@deniselupe/hangman).

# Rules
- The player has 8 turns to spell the secret word
- The secret word is between 8 to 12 characters long
- Entering guesses that were previously used will not count as a turn

# Features
- Displays progress to inform players how close they are to spelling the secret word
- Displays number of turns left to spell the secret word
- Displays a list of letters previously guessed that were incorrect
- Allows players to save their progress and name their save file
- Allows players to quit their game instance without saving progress
- Allows players to load their save file and resume their game instance

# Thoughts
The purpose of this project was to exercise my knowledge on Files and Serialization and get experience with:
- The File class to read, write, create, and delete files
- The Dir class to locate specific files within my project's file tree
- The YAML module to serialize my game instances
