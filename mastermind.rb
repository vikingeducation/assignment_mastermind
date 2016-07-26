## CODEBREAKER
# The game board is rendered between turns
# => class: Board, Public-Action: render

# The player only gets 12 turns to crack the code
# => Class: MasterMind, Public-Action: play(while or until)

# The player wins if the code is correctly guessed by the last turn
# => Class: MasterMind, Private-Action: player_win?

# The rendered board displays the number of "close" pegs (correct color, wrong position)
# => class: Board, Private-Action: close_feedback

# The rendered board displays the number of "exact" pegs, e.g. those which exactly match the color and position of the computer's code
# => class: Board, Private-Action: exact_feedback

# The player loses after the 12th turn if the code hasn't been broken
# => class: MasterMind, Private-Action: player_lose?

# When losing, the code is displayed to the player
# => class: Board, Private-Action: show_hidden_code

## CODEMAKER
# The game now asks whether the player wants to be the "codebreaker" or "codemaker" upon startup
# => class: Player, Public-Action: pick_character

# The codemaker player is prompted to enter a code
# => class: Player, Public-Action: initialize_code

# Once the code is entered, the computer AI "plays" the game, rendering the board between turns and displaying the final result (win/loss)
# => class: ComputerAi, Public-Action: autoplay

require_relative 'board'
require_relative 'computer'
require_relative 'player'
require 'pry'


class MasterMind

  def initialize
    @player   = Player.new
    @board    = Board.new
    @computer = ComputerAi.new
  end

  def play
    welcome
    # binding.pry
    if @player.pick_codebreaker?
      playing(@computer, @player)
    else
      playing(@player, @computer)
    end
  end

  # Attention! Following methods are private.
  private

  def welcome
    puts "Welcome to the CLI version MasterMind"
    puts "It is a very challenging game, so be prepared and have fun."
  end

  def playing(maker, coder)
    code = maker.initialize_code
    12.times do |i|
      # binding.pry
      guess = coder.make_guess @board
      @board.display guess, i
      if game_over? guess, code
        puts "Congradulations! You win!"
        break
      end
      @board.feedback code, guess
      puts "There is #{@board.feedback_result[:black]} exact guess and #{@board.feedback_result[:white]} close result"
      puts ""
    end
    show_hidden_code code
  end

  private

  def game_over? code, guess
    code == guess
  end

  def show_hidden_code code
    puts "The hidden code is #{code}"
  end

end

new_game = MasterMind.new
new_game.play
