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

if $PROGRAM_NAME == __FILE__
  a = Game.new
  a.play
end