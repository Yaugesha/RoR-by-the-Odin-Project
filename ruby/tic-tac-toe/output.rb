module Output
  def board data
    puts "    1   2   3  "
    puts "  ┌───┬───┬───┐"
    data.each_with_index do |line, index|
      puts "#{index + 1} │ #{line[0]} | #{line[1]} | #{line[2]} |"
      puts "  ├───┼───┼───┤" if index < 2
    end
    puts "  └───┴───┴───┘"
  end

  def menu
    puts "1. Start game\n0. Exit"
    self.input
  end

  def input
    print ">> "
  end

  def column
    print "column: "
  end

  def row
    print "row: "
  end

  def incorrect_move
    puts "Marker on this position has already exist"
  end

  def player_name player_name, team
    puts "#{team == "X" ? "First player": "Second player"} name: #{player_name}"
  end

  def player_move player_name
     puts("#{player_name}'s move")
  end
end
