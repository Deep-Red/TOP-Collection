class Board
  attr_reader :grid, :game_status

  def initialize
    @height = 6
    @width = 7
    @grid = Array.new(@width) {Array (@height.times.map{'empty'})}
  end

  def place_piece(horizontal_coord, color)
    color = color == 'black' ? "\u25CE" : "\u25C9"

    return false if horizontal_coord >= @width
    next_empty = pick_first_empty_slot(@grid[horizontal_coord])
    if next_empty 
      @grid[horizontal_coord][next_empty] = color
    else
      return false
    end
  end

  def pick_first_empty_slot(column)
    column.each_with_index do |slot, index|
      return index if slot == 'empty'
    end
    return false
  end

  def game_over?

    #Check to see if there are any vertical matches
    vertical_count = 1

    @grid.each_with_index do |column, column_index|
      column.each_with_index do |slot, slot_index|

        if slot_index != 0 && slot == column[slot_index - 1] && slot != 'empty'
          vertical_count += 1
          return true if vertical_count == 4
        else 
          vertical_count = 1
        end

        horizontal_count = 1

        @grid.each_with_index do |column2, column2_index|
          #Check to see if there are any horizontal matches

          if column2_index != 0 && column[slot_index] == @grid[column2_index - 1][slot_index] && column2[slot_index] != 'empty'
            horizontal_count += 1
            return true if horizontal_count == 4
          else
            horizontal_count = 1
          end

          #Check to see if there are any diagonal matches in the right direction
          if column2_index < @height - 4 && slot_index < @width - 4
            return true if @grid[column2_index][slot_index] != 'empty' &&
                           @grid[column2_index][slot_index] == @grid[column2_index+1][slot_index+1] &&
                           @grid[column2_index+1][slot_index+1] == @grid[column2_index+2][slot_index+2] &&
                           @grid[column2_index+2][slot_index+2] == @grid[column2_index+3][slot_index+3] 
          end
          #Check to see if there are any diagonal matches in the left direction
          if column2_index < @height - 4 && slot_index > 2
            return true if @grid[column2_index][slot_index] != 'empty' &&
                           @grid[column2_index][slot_index] == @grid[column2_index+1][slot_index+1] &&
                           @grid[column2_index+1][slot_index+1] == @grid[column2_index+2][slot_index+2] &&
                           @grid[column2_index+2][slot_index+2] == @grid[column2_index+3][slot_index+3]
          end
        end
      end
    end
    return false
  end

  def print_board
    vertical_coord = @height-1
    while vertical_coord >= 0 
      print_array = ''
      horizontal_coord = 0
      while horizontal_coord < @width - 1
        print_array += @grid[horizontal_coord][vertical_coord].encode('utf-8').center(7) + '|' 
        horizontal_coord += 1
      end
      puts print_array
      puts '-'*@width*7
      vertical_coord -= 1
    end
  end
end

class Players
  attr_reader :black_player, :red_player

  def initialize(black, red)
    @black_player = black
    @red_player = red
  end
end

class Turns
  attr_reader :turn_count
  def initialize(players)
    @turn_count = 0
    @black_player = players.black_player
    @red_player = players.red_player
  end

  def increment
    @turn_count += 1
  end

  def return_player
    return @turn_count%2 == 0 ? @red_player : @black_player
  end

  def return_color
    return @turn_count%2 == 0 ? 'red' : 'black'
  end
end

def run
  game_continue = true

  puts 'What is the name of the player who will use black pieces?'
  black = gets.chomp!
  puts 'What is the name of the player who will use red pieces?'
  red = gets.chomp!

  game = Board.new
  players = Players.new(black, red)
  turns = Turns.new(players)

  while game_continue do

    puts "The current board looks like:"
    print "#{game.print_board}"
    valid_response = false
    until valid_response do
      puts "It is #{turns.return_player}'s turn. Please pick a slot from 1 to 7 to place your next piece in:"
      position = gets.chomp!
      if position.to_i.to_s == position
        position = position.to_i - 1
        valid_response = true if position >= 0 && position < 7 && game.place_piece(position, turns.return_color)
      end
    end

    turns.increment

    valid_response = false
    if game.game_over? 
      puts "#{turns.return_player} has gotten four in a row! Congratulations. Play again?"
      response = gets.chomp!.downcase
      valid_resopnse = true if response == 'yes' || response == 'no'
      game_continue = false if response == 'no'
      game = Board.new if response == 'yes'
    end
  end
end

run