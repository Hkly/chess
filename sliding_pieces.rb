class SlidingPiece < Piece
  def possible_moves
    moves = []
    move_deltas.each do |move_delta|
      row = @position.first + move_delta.first
      col = @position.last + move_delta.last
      (2..8).step do |incrementer|
        break unless @board.on_board?(row, col)
        if @board.empty?([row, col])
          moves << [row, col]
          row = (move_delta.first * incrementer) + @position.first
          col = (move_delta.last * incrementer) + @position.last
        elsif @board.capturable?([row, col], @color)
          moves << [row, col]
          break
        else
          break
        end
      end  
    end
    moves
  end
end