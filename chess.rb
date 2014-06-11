# require_relative 'piece'

require_relative 'chess_pieces'
require_relative 'chess_board'

if $PROGRAM_NAME == __FILE__
  b = Board.make_starting_board
  # b.display
  puts "Expect [[4, 0], [5, 0]]:"
  puts b[[6,0]].valid_moves.to_s
  
  puts "Expect [[5, 1], [4, 1]]:"
  puts b[[6,1]].valid_moves.to_s
end