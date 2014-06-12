class Game
  attr_reader :grid
  def initialize
    @grid = Board.make_starting_board
    @white_player = HumanPlayer.new(self, :white)
    @black_player = HumanPlayer.new(self, :black)
  end
  
  def get_user_input
    print "Choose your piece's position (Ex. 6, 0): "
    start = gets.chomp.split(',').map(&:to_i)
    print "Choose target position: "
    target = gets.chomp.split(',').map(&:to_i)
    [start, target]
  end
  
  def play
    active_player = @white_player
    until @grid.checkmate?(:black) || @grid.checkmate?(:white)
      @grid.render
      active_player.play_turn
      active_player = toggle_player(active_player)
    end
  end
  
  def toggle_player(active_player)
    active_player == @white_player ? @black_player : @white_player
  end
end

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
