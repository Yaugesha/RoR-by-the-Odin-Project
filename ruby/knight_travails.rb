require_relative ("linked_list")

class Square
  attr_accessor :row, :column

  def initialize(row, column)
    @row = row
    @column = column
  end
end

class Knight
  attr_accessor :position

  def move(position, row, column)
    Square.new(position.row + row, position.column + column)
  end

  def knight_moves(start, finish)
    position = Square.new(start[0], start[1])
    list = LinkedList.new
    find_finish(position, finish, 0, list)
  end

  def find_finish(position, finish, moves, list)
    flag = false
    for row in -2..2
      next unless (position.row+row).between?(0, 8)
      for col in -2..2
        p "#{row}, #{col}"
          #find_finish(move(position, row, col), finish, moves+1)
        next unless (position.column+col).between?(0, 8)
        moved_position = move(position, row, col)
        list.append(moved_position)
        p moved_position
        flag = [position.row, position.column] == finish
        return moves if flag
      end
    end
    next_pos = list.at(0)
    list.remove_at(0)
    find_finish(next_pos.value, finish, moves+1, list)
  end
end

knight = Knight.new
p knight.knight_moves([0, 0], [2, 4])
