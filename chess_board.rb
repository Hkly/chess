class Board
  attr_reader :board
  def self.make_starting_board
    board = Board.new
    starting_row = [Rook, Knight, Bishop, Queen, King, Bishop, Knight, Rook]
    starting_row.each_with_index do |piece_class, idx|
      board.place_piece(piece_class, [0, idx], :black)
      board.place_piece(piece_class, [7, idx], :white)
      board.place_piece(Pawn, [1, idx], :black)
      board.place_piece(Pawn, [6, idx], :white)
    end
    board
  end
  
  def initialize
    @board = Array.new(8) { Array.new(8) }
  end
  
  def deep_dup
    dupped_board = Board.new
    @board.each_with_index do |row, r_index|
      row.each_with_index do |square, c_index|
        unless square.nil?
          pos = [r_index, c_index]
          klass, color = square.class, square.color
          dupped_board.place_piece(klass, pos, color)
        end
      end
    end
    dupped_board
  end
  
  def place_piece(piece_class, pos, color)
    piece = piece_class.new(self, pos, color)
    self[pos] = piece
  end
  
  def checkmate?(color)
    if in_check?(color)
      own_color_pieces = get_same_color_pieces(color)
      own_color_pieces.all? { |piece| piece.valid_moves.empty? }
    end
  end
  
  def move(start, end_pos)
    raise "No piece." if empty?(start)
    piece = self[start]    
    raise "Invalid move." unless piece.possible_moves.include?(end_pos)
    piece.position = end_pos
    self[end_pos] = piece
    self[start] = nil
  end
  
  def on_board?(row, col)
    (0..7).include?(row) && (0..7).include?(col)
  end
  
  def empty?(pos)
    self[pos].nil?
  end
  
  def capturable?(pos, color)
    self[pos].color != color
  end
  
  def find_opposite_pieces(color)
    @board.flatten.compact.select do |piece| 
      piece.color != color
    end
  end
  
  def get_same_color_pieces(color)
    @board.flatten.compact.select do |piece| 
      piece.color == color
    end
  end
  
  def in_check?(color)
    king_position = find_king(color)
    find_opposite_pieces(color).each do |piece|
      return true if piece.possible_moves.include?(king_position)
    end
    false
  end
  
  def inspect
    return @board.each {|r| p r}
  end
  
  def [](pos)
    x = pos[0]
    y = pos[1]
    @board[x][y]
  end
  
  def []=(pos, value)
    x = pos[0]
    y = pos[1]
    @board[x][y] = value
  end

  def find_king(color)
    @board.each_with_index do |row, r_index|
      row.each_with_index do |square, c_index|
        return [r_index, c_index] if square.is_a?(King) && square.color == color
      end
    end
  end
end