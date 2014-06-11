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
      !move_into_check?(move)
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
    dupped_board.move!(@position, pos)
    dupped_board.in_check?(@color)
  end
end