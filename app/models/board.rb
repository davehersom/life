class Board
  include ActiveModel::Validations
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :rows
  attr_accessor :columns

  def cell(row,column)
    return @cell["r=#{row.to_s}c=#{column.to_s}"]
  end

  def next_cell_value(row,column)
    return @cell["r=#{row.to_s}c=#{column.to_s}"].next_value
  end

  def cell_value(row,column)
    return @cell["r=#{row.to_s}c=#{column.to_s}"].value
  end

  def set_cell(row, column, point)
    @cell["r=#{row.to_s}c=#{column.to_s}"] = point
  end

  def set_next_cell_value(row,column,value)
    @cell["r=#{row.to_s}c=#{column.to_s}"].next_value = value
  end

  def set_cell_value(row,column,value)
    @cell["r=#{row.to_s}c=#{column.to_s}"].value = value
  end

  def neighbor_count(row,column)
    my_neighbors = 0
    (row-1).upto(row+1) do |r|
      (column-1).upto(column+1) do |c|
        if (cell_value(r,c) == :on) && ([r,c] != [row,column]) then my_neighbors += 1 end
      end
    end
    #puts "My Neighbors = "+my_neighbors.to_s+" "+row.to_s+" "+column.to_s
    return my_neighbors
  end

  def next_generation(print_new = false)
    #TODO clear edges?
    1.upto @rows do |row|
      1.upto @columns do |column|
        my_neighbors = neighbor_count(row,column)
        if ((cell_value(row,column) == :on) && ((my_neighbors == 2) || (my_neighbors == 3))) ||
          (my_neighbors == 3) then
          set_next_cell_value(row,column,:on)
        else
          set_next_cell_value(row,column,:off)
        end
      end
    end
 #Display board
    if print_new then printf("------------\n") end
    1.upto @rows do |row|
      1.upto @columns do |column|
        set_cell_value(row,column, next_cell_value(row,column))
        if print_new
          if next_cell_value(row,column) == :on then
            printf "*"
          else
            printf " "
          end
        end
      end
     if print_new then printf "\n" end
    end
  end

  def initialize(rows=0, columns=0)
    @rows = rows
    @columns = columns
    @cell = Hash.new
    0.upto (@rows+1) do |r|
      0.upto (@columns+1) do |c|
        p = Point.new
        p.value = :off
        set_cell(r,c,p)
      end
    end
  end

end