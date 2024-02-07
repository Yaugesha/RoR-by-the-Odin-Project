module Output
  def self.board data
    puts "    1   2   3  "
    puts "  ┌───┬───┬───┐"
    data.each_with_index do |line, index|
      puts "#{index + 1} │ #{line[0]} | #{line[1]} | #{line[2]} |"
      puts "  ├───┼───┼───┤" if index < 2
    end
    puts "  └───┴───┴───┘"
  end

  def self.menu
    puts "1. Start game\n0. Exit"
  end

  def self.input
    print ">> "
  end
end
