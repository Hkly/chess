class Piece
  DIAGONALS = [[1, 1], [1, -1], [-1, -1], [-1, 1]]
  STRAIGHTS = [[0, 1], [1, 0], [-1, 0], [0, -1]]
  
  attr_accessor :position
  attr_reader :color
  def initialize(board, start_pos, color)
    @board = board
    @position = start_pos
    @color = color
  end
  
  def valid_moves
    self.possible_moves.select do |move|
      move unless move_into_check?(move)
    end
  end

  def target_pos_empty?(target_pos)
    @board.empty?(target_pos)
  end
  
  def inspect
    return self.class.to_s
  end
  
  def move_into_check?(pos)
    # will making this move leave me in check?
    dupped_board = @board.deep_dup
    dupped_board.move(@position, pos)
    dupped_board.in_check?(@color)
  end
end

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

class King < SteppingPiece
  def move_deltas
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
end

class Knight < SteppingPiece
  MOVES_VECTOR = [
    [2, 1],
    [2, -1], 
    [-2, -1], 
    [-2, 1], 
    [1, 2], 
    [1, -2],
    [-1, 2],
    [-1, -2]
  ]

  def move_deltas
    MOVES_VECTOR
  end
end

class Queen < SlidingPiece
  def move_deltas
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
end

class Bishop < SlidingPiece
  def move_deltas
    Piece::DIAGONALS
  end
end

class Rook < SlidingPiece
  def move_deltas
    Piece::STRAIGHTS
  end
end

class Pawn < SteppingPiece
  def move_deltas
    dy = color == :black ? 1 : -1
    [ [dy, 0], [dy, 1], [dy, -1] ]
  end
  
  def valid_moves
    moves = first_move

    self.possible_moves.each do |move|
      unless self.move_into_check?(move)
        if move.last == 0 && @board.empty?(move)
          moves << move
        elsif move.last != 0
          next if @board.empty?(move)
          moves << move if @board.capturable?(move)
        end
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












