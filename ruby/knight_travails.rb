require_relative ("linked_list")

class Square
  attr_accessor :row, :column

  def initialize(row, column)
    @row = row
    @column = column
    @lt=nil
    @tl=nil
    @tr=nil
    @rt=nil
    @ld=nil
    @dl=nil
    @dr=nil
    @rd=nil
  end

  def define_moves
    @lt=Square.new(self.row-2, self.column+1)
    @tl=Square.new(self.row-1, self.column+2)
    @tr=Square.new(self.row+1, self.column+2)
    @rt=Square.new(self.row+2, self.column+1)
    @ld=Square.new(self.row-2, self.column-1)
    @dl=Square.new(self.row-1, self.column-2)
    @dr=Square.new(self.row+1, self.column-2)
    @rd=Square.new(self.row+2, self.column-1)
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
    [-2, -1, 1, 2].each do |row|
      if !(position.row+row).between?(0, 8)
        next
      end
      [-2, -1, 1, 2].each do |col|
        if !(position.column+col).between?(0, 8) || row.abs == col.abs
          next
        end
        moved_position = move(position, row, col)
        list.append(moved_position)
        return moves if [position.row, position.column] == finish
      end
    end
    next_pos = list.at(0)
    list.remove_at(0)
    find_finish(next_pos.value, finish, moves+1, list)
  end
end

knight = Knight.new
p knight.knight_moves([0, 0], [2, 4])
