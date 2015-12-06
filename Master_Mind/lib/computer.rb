require './MasterMind'
require './player'
require './board'

class Computer

  attr_accessor :definite, :definitely_not
  attr_reader :exact_positions, :maybe

  def initialize(game, board)
    @mastermind = game
    @board = board
    @definite = []
    @definitely_not = []
    @maybe = []
    @exact_positions = {}
  end

  def assess_results(round)
    e_count_current = 0
    e_count_previous = 0
    @board.clue_board[round-1].each { |e| e_count_current += 1 if e == "E"}
    @board.clue_board[round-2].each { |e| e_count_previous += 1 if e == "E"}
    if round >= 2 && round <= 5
      if @board.clue_board[round-1].size > @board.clue_board[round-2].size
        @definite << @board.board[round-1][round-2]
        @definitely_not << @board.pegs[round-2]
        check_for_exacts(round, e_count_previous, e_count_current)
      elsif @board.clue_board[round-1].size < @board.clue_board[round-2].size
        @definite << @board.pegs[round-2]
        @definitely_not << @board.board[round-1][round-2]
        check_for_exacts(round, e_count_previous, e_count_current)
      elsif @board.clue_board[round-1] == @board.clue_board[round-2]
        # This is going to take some work
        @maybe << @board.board[round-1][round-2]
        @maybe << @board.pegs[round-2]
      else
        @definite << @board.board[round-1][round-2]
        @definite << @board.pegs[round-2]
        check_for_exacts(round, e_count_previous, e_count_current)
      end
    end
    if round > 5 && @maybe.size == 2

    end
  end

  # Dealing with maybes
  # First I guess you'd put all your definites in place.
  # Then you'd put your definites in.
  # Then you'd start subbing in one of the maybes at a time to figure out if it's supposed to be there. 

  def check_for_exacts(round, e_count_previous, e_count_current)
    if e_count_current - e_count_previous == 1
      @exact_positions[@board.board[round-1][round-2]] = round-2
    elsif e_count_previous - e_count_current == 1
      @exact_positions[@board.board[round-2][round-2]] = round-2
    end
  end

  def make_a_code
    pegs = %w[! @ # $ % ^ & *]
    master_code = []
    4.times {master_code << pegs.shuffle!.pop}
    master_code
  end

  def play_round(round)
    pegs = %w[! @ # $ % ^ & *]
    if round == 1
      @board.board[round-1] = %w[! @ # $]
    elsif round < 6
      new_array = @board.board[round-2]
      @board.board[round-1] = new_array.dup
      @board.board[round-1][round - 2] = @board.pegs[round + 2]
    end
    @board.assess_guess
    assess_results(round)
  end

end