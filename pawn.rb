class Pawn < SteppingPiece
  def move_deltas
    dy = color == :black ? 1 : -1
    [ [dy, 0], [dy, 1], [dy, -1] ]
  end
  
  def possible_moves
    moves = first_move

    super.each do |move|
      if move.last == @position.last && @board.empty?(move)
        moves << move
      elsif move.last != @position.last
        next if @board.empty?(move)
        moves << move if @board.capturable?(move)
      end
    end
    moves
  end
  
  def first_move
    starting_row = color == :white ? 6 : 1
    current_row = @position.first
    move = []
    
    if current_row == starting_row
      x = @position.first + move_deltas.first[0]
      y = @position.last
      one_step =  [x, y]
      delta = color == :white ? -2 : 2
      second_step = [current_row + delta, y]
      if @board.empty?(second_step) && @board.empty?(one_step)
        move <<  second_step 
      end
    end
    move
  end
end
