require_relative "output"
require_relative "player"

class Engine
  attr_accessor :first_player, :second_player
  attr_reader :board

  include Output

  def initialize
    @board = [[" ", " ", " "],[" ", " ", " "],[" ", " ", " "]]
  end

  def startGame
    user_input = -1
    until user_input == 0
      Output::menu
      Output::input
      user_input = gets.chomp.to_i
      if user_input == 1
        puts "game started"
        self.launch_game
      end
    end
  end

  private

  def launch_game
    self.create_players
    move = 1
    until move == 10
      player = move%2 == 1 ? self.first_player : self.second_player
      Output::board self.board
      self.move player
      break if self.win?(player.team)
      move += 1
    end
    Output::board self.board
    move < 10 ? puts("#{player.name}'s WIN!!!") : puts("It's draw )")
  end

  def move player
    position = []
    puts("#{player.name}'s move")
    print("row: ")
    position << gets.chop
    print("column: ")
    position << gets.chop
    player.move(position)
    self.board[position[0].to_i-1][position[1].to_i-1] = player.team
  end

  def create_players
    self.first_player = Player.new("X")
    puts "First player name: #{self.first_player.name}"
    self.second_player = Player.new("O")
    puts "Second player name: #{self.second_player.name}"
  end

  def win? team
    return (self.board[0][0] == team && self.board[0][1] == team && self.board[0][2] == team) ||
    (self.board[0][0] == team && self.board[1][0] == team && self.board[2][0] == team) ||
    (self.board[0][0] == team && self.board[1][1] == team && self.board[2][2] == team) ||
    (self.board[1][0] == team && self.board[1][1] == team && self.board[1][2] == team) ||
    (self.board[0][1] == team && self.board[0][2] == team && self.board[0][2] == team) ||
    (self.board[0][2] == team && self.board[1][2] == team && self.board[2][2] == team) ||
    (self.board[2][0] == team && self.board[2][1] == team && self.board[2][2] == team) ||
    (self.board[2][0] == team && self.board[1][1] == team && self.board[2][0] == team)
  end

end

game = Engine.new
game.startGame
