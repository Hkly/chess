require_relative 'chess_pieces'
require_relative 'chess_board'
require_relative 'stepping_pieces'
require_relative 'sliding_pieces'
require_relative 'pawn'
require_relative 'rook'
require_relative 'bishop'
require_relative 'queen'
require_relative 'king'
require_relative 'knight'
require_relative 'chess_game'
require_relative 'human_player'

if $PROGRAM_NAME == __FILE__
  a = Game.new
  a.play
end

# b = Board.make_starting_board
# b.place_piece(Queen, [5, 7], :white)
# b.place_piece(Rook, [6, 6], :white)
# b.place_piece(King, [7, 0], :black)