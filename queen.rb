class Queen < SlidingPiece
  def move_deltas
    Piece::DIAGONALS + Piece::STRAIGHTS
  end
end
