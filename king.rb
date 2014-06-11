class King < SteppingPiece
  def move_deltas
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
end