class Rook < SlidingPiece
  def move_deltas
    Piece::STRAIGHTS
  end
end
