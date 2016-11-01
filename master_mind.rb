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
		@code_maker = ComputerPlayer.new
		@code_breaker = HumanPlayer.new
	end

	def play
		@board.code = @code_maker.make_code
		loop do
			@board.render
			@code_breaker.get_choice
			break if game_over?
		end
	end 

	def game_over?
		victory? || loss?
	end

	def victory?
		@board.victory?
	end

	def loss?
		@board.loss?
	end
end














