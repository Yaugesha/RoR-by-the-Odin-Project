class Player

  attr_reader :name, :moves, :team

  def initialize team
    self.create
    @team = team
  end

  def move position
    moves << position
  end

  private

  def create
    print "Input your name: "
    @name = gets.chomp
    @moves = []
  end

end
