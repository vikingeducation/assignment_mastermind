class Board
  PEG_COLOURS = %w(B G O P R Y).freeze
  attr_accessor :peg_slots, :peg_assist, :assist_array, :pegs_target

  def initialize
    @pegs_target = []
    @peg_slots = build_empty_game_array('-')
    @peg_assist = {
      right_peg_NOT_place:  0,
      right_peg_AND_place:  0,
      assist_history: build_empty_game_array(0)
    }
  end

  def generate_target(player_type)
    unless player_type == 'CPU'
      4.times do |ind|
        pegs_target[ind] = PEG_COLOURS.sample
      end
    else
      Gui.player_created_code
      self.pegs_target = HumanPlayer.new("DEFAULT").choose
    end
    return
  end

  def render
    peg_slots.each_with_index do |row, ind|
      row.each do |slot|
        print slot + ' '
      end
      Gui.print_assist(peg_assist[:assist_history], ind)
      puts
    end
    puts
    nil
  end

  def validate_choice(choice)
    all_correct_peg = true
    choice.each do |peg|
      all_correct_peg = false unless PEG_COLOURS.include?(peg)
    end

    if all_correct_peg
      return true
    else
      Gui.redo_selection
      return false
    end
  end

  def generate_assist(turn)
    reset_assist
    assist_parse(turn)
    peg_assist[:assist_history][turn] = [peg_assist[:right_peg_NOT_place], peg_assist[:right_peg_AND_place]]
  end

  def reset_assist
    peg_assist[:right_peg_NOT_place] = 0
    peg_assist[:right_peg_AND_place] = 0
  end

  def assist_parse(turn)
    temp_guess = peg_slots[turn].dup
    temp_target = pegs_target.dup

    right_peg_in_place(temp_guess, temp_target)
    right_colors_choosen(temp_guess, temp_target)
  end

  def right_peg_in_place(temp_guess, temp_target)
    puts temp_guess.object_id
    index = 0
    while index < temp_guess.size
      if temp_guess[index] == temp_target[index]
        peg_assist[:right_peg_AND_place] += 1
        temp_guess.delete_at(index)
        temp_target.delete_at(index)
      else
        index += 1
      end
    end
    nil
  end

  def right_colors_choosen(temp_guess, temp_target)
    puts temp_guess.object_id
    temp_guess.each do |peg|
      if temp_target.include?(peg)
        peg_assist[:right_peg_NOT_place] += 1

        temp_target.delete_at(temp_target.index(peg))
      end
    end
  end

  def build_empty_game_array(empty_element, board_height=12, board_width=4)
    Array.new(board_height) { Array.new(board_width) { |i| i = empty_element } }
  end

end
