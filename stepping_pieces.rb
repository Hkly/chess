class SteppingPiece < Piece
  def possible_moves
    # based on current stationed position
    pos_moves_arr = []

    move_deltas.each do |new_pos|
      x = @position[0] + new_pos[0]
      y = @position[1] + new_pos[1]
      pos_moves_arr << [x, y] if (0...8).include?(x) && (0...8).include?(y)
    end
    pos_moves_arr.select { |position| target_pos_empty?(position) }
  end
end
