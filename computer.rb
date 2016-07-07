class Computer < Player

  def input_code(board)
    input = []
    board.pegs.times do |item|
      input << board.colors.sample
    end
    input 
  end

  def get_pegs
    pegs = (4..6).to_a.sample
    puts "You're playing with #{pegs} pegs."
    pegs
  end

  def get_colors
    colors = (2..8).to_a.sample
    puts "You're playing with #{colors} colors."
    colors
  end
end