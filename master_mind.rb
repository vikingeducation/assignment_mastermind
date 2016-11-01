# set up game and board (human as codebreaker) -- mastermind makes a board and players

# start game -- mastermind
# set up code -- player
# each turn: -- mastermind
  # render board -- board
  # get player guess -- player
  # give feedback -- board
  # check for game over -- board
    # check for victory -- board
    # check for loss -- board
    # new turn if game not over -- mastermind
# output results -- mastermind??
# play again? -- mastermind
 

class Mastermind
	CHOICES = %w(A B C D E F)

	def initialize
		@board = Board.new
		@code_maker = ComputerPlayer.new(@board)
		@code_breaker = HumanPlayer.new(@board)
	end

	def play
    Renderer.welcome
    Renderer.player_message
		@code_maker.get_code
    puts @board.code.join # For debugging
		loop do
			@board.render
			@code_breaker.get_choice
			if game_over?
				end_game
				break 
			end 
		end
	end 

	def game_over?
		victory? || loss?
	end

	def victory?
		@board.code_guessed?
	end

	def loss?
		@board.full?
	end

  def end_game
    @board.render
    victory? ? Renderer.victory_message : Renderer.loss_message
  end
end













