require_relative 'player'
class Maker < Player
  def initialize
  end

  def get_code
    response = []
    4.times do
      response << LEGAL_COLORS.sample
    end
    response
  end

end
