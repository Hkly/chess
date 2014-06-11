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

