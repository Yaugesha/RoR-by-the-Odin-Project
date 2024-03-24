class Square
  attr_accessor :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end
end

class Array
  def to_s
    self.reduce("") do |accum_path, path|
      path_route = path.reduce("") do |accum_square, square|
        accum_square << "[#{square.row}, #{square.column}]"
        accum_square << " -> " unless square == path.last
        accum_square
      end
      accum_path << path_route + "; "
    end
  end
end

class Knight
  attr_accessor :position

  def move(position, row, column)
    Square.new(position.row + row, position.column + column)
  end

  def knight_moves(start, finish)
    position = Square.new(start[0], start[1])
    list = [[position]]
    find_finish_paths(position, finish, list)
  end


  def find_finish_paths(position, finish, list)
    finish_paths = []

    until list.size == finish_paths.size do
      finish_paths = write_all_possible_paths(position, list, finish, finish_paths)

      list.delete_at(0)
      # clear all paths that potentialy can reach finsish for more moves
      unless finish_paths.empty?
        list = list.reject do |path|
          path.length >= finish_paths.last.length && [path.last.row, path.last.column] != finish
        end
      end
      position = list.first.last
    end
    list
  end

  def write_all_possible_paths(position, list, finish, finish_paths)
    [-2, -1, 1, 2].each do |row|
      [-2, -1, 1, 2].each do |col|
        # check if move valid -> in borders of table and 2+1 or 1+2
        next unless (0..7).cover?(position.row + row) &&
                    (0..7).cover?(position.column + col) &&
                    row.abs != col.abs
        # save new position in list of paths
        moved_position = move(position, row, col)
        list.push(list.first.dup.push(moved_position))
        # check if move on finish square and save path to finish
        if [moved_position.row, moved_position.column] == finish
          finish_paths << list.last
        end
      end
    end
    finish_paths
  end

end

knight = Knight.new
p knight.knight_moves([0, 0], [2, 5]).to_s
p knight.knight_moves([0, 0], [6, 6]).to_s
p knight.knight_moves([5, 4], [3, 1]).to_s
