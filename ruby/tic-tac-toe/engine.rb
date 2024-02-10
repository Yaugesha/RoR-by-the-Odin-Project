require_relative "output"
require_relative "player"

class Engine

include Output

  attr_accessor :first_player, :second_player,:board_data

  def initialize
    @board_data = [[" ", " ", " "],[" ", " ", " "],[" ", " ", " "]]
  end

  def startGame
    user_input = -1
    until user_input == 0
      self.menu
      self.input
      user_input = gets.chomp.to_i
      if user_input == 1
        puts "game started"
        self.launch_game
      end
      self.board_data = [[" ", " ", " "],[" ", " ", " "],[" ", " ", " "]]
    end
  end

  private

  def launch_game
    self.create_players
    move = 1
    until move == 10
      player = move%2 == 1 ? self.first_player : self.second_player
      self.board(self.board_data)
      self.move player
      break if self.win?(player.team)
      move += 1
    end
    self.board(self.board_data)
    move < 10 ? puts("#{player.name}'s WIN!!!") : puts("It's draw )")
  end

  def move player
    self.player_move player.name
    position = self.define_position
    player.move(position)
    self.board_data[position[0]-1][position[1]-1] = player.team
  end

  def define_position
    while 1
      position = []
      self.row
      row = gets.chop.to_i
      position << row if row.between?(1,3)
      self.column
      column = gets.chop.to_i
      position << column if column.between?(1,3)
      puts self.position?(position)
      if self.position?(position)
        return position
      else
        self.incorrect_move
      end
    end
  end

  def position? position
    self.board_data[position.first-1][position.last-1] == " "
  end

  def create_players
    self.first_player = Player.new("X")
    self.player_name(self.first_player.name, "X")
    self.second_player = Player.new("O")
    self.player_name(self.second_player.name, "O")
  end

  def win? team
    return (self.board_data[0][0] == team && self.board_data[0][1] == team && self.board_data[0][2] == team) ||
    (self.board_data[0][0] == team && self.board_data[1][0] == team && self.board_data[2][0] == team) ||
    (self.board_data[0][0] == team && self.board_data[1][1] == team && self.board_data[2][2] == team) ||
    (self.board_data[1][0] == team && self.board_data[1][1] == team && self.board_data[1][2] == team) ||
    (self.board_data[0][0] == team && self.board_data[0][1] == team && self.board_data[0][2] == team) ||
    (self.board_data[0][2] == team && self.board_data[1][2] == team && self.board_data[2][2] == team) ||
    (self.board_data[2][0] == team && self.board_data[2][1] == team && self.board_data[2][2] == team) ||
    (self.board_data[2][0] == team && self.board_data[1][1] == team && self.board_data[2][0] == team)
  end

end

game = Engine.new
game.startGame
