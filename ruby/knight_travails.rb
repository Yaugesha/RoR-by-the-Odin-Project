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
    list.append([position])
    find_finish(position, finish, list)
  end


  def find_finish(position, finish, list)
    flag = false
    first_finish_path = []
    paths = 0
    until list.size == paths do
      [-2, -1, 1, 2].each do |row|
        if (position.row + row).between?(0, 7)
          [-2, -1, 1, 2].each do |col|
            if (position.column + col).between?(0, 7) && row.abs != col.abs
              moved_position = move(position, row, col)
              list.append(list.head.value.dup.push(moved_position))
              # p moved_position, list.to_s
              if [moved_position.row, moved_position.column] == finish
                unless flag
                  flag = true
                  first_finish_path = list.tail.value
                  paths += 1
                end
                # p first_finish_path
                break
              end
            end
          end
        end
      end
      list.remove_at(0)
      unless first_finish_path == []
        i = 0
        until i == list.size
          # p i, list.to_s
          curr_list_node = list.at(i).value
          if curr_list_node.length >= first_finish_path.length &&
             [curr_list_node.last.row, curr_list_node.last.column] != finish
            list.remove_at(i)
          else
            i += 1
          end
        end
      end
      position = list.head.value.last
      flag = false
    end
    list
  end

end

knight = Knight.new
p knight.knight_moves([0, 0], [2, 5]).to_s
p knight.knight_moves([0, 0], [6, 6]).to_s
p knight.knight_moves([5, 4], [3, 1]).to_s
