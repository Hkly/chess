class Bishop < SlidingPiece
  def move_deltas
    Piece::DIAGONALS
  end
end
