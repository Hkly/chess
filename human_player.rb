class HumanPlayer
  attr_reader :color
  def initialize(game, color)
    @game = game
    @color = color
  end
  
  def play_turn
    opponent_color = self.color == :black ? :white : :black 
    start, target = @game.get_user_input
    @game.grid.move(start, target)
    if @game.grid.checkmate?(opponent_color)
      puts  "Check and Mate."
    elsif @game.grid.in_check?(opponent_color)
      puts "Check"
    end
  end
end
