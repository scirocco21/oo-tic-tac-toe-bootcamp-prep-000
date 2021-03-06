class TicTacToe

  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

    WIN_COMBINATIONS = [
      [0,1,2],
      [3,4,5],
      [6,7,8],
      [0,3,6],
      [1,4,7],
      [2,5,8],
      [0,4,8],
      [2,4,6]
    ]

    def display_board
        puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
        puts "-----------"
        puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
        puts "-----------"
        puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
      end

    def input_to_index(input)
       input.to_i - 1
      end

      def move( index, character = "X")
        @board[index] = character
        return @board
      end

      def position_taken?(index)
        !(@board[index].nil? || @board[index] == " ")
      end

      def valid_move?(index)
        if position_taken?(index) == false && index.between?(0, 8)
          return true
        else
          puts "This is not a valid move!"
          return false
        end
      end

      def turn
        puts "Please enter 1-9:"
        input = gets.chomp.to_i
        index = input_to_index(input)
        if valid_move?(index)
          character = current_player
          move(index, character)
          display_board
        else
          turn
        end
      end

      def turn_count
        @board.count{|token| token == "X" || token == "O"}
      end

     def current_player
       turn_count % 2 == 0 ? "X" : "O"
     end

     def won?
      WIN_COMBINATIONS.each do |win_combination|
        win_index_1 = win_combination[0]
        win_index_2 = win_combination[1]
        win_index_3 = win_combination[2]

        position_1 = @board[win_index_1]
        position_2 = @board[win_index_2]
        position_3 = @board[win_index_3]

        if (position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O")
           return win_combination
        end
       end
     return false
     end


      def full?
        @board.each do |position|
          if position == " "
             return false
           end
         end
       return true
        end

  def draw?
    if won?
       return false
    else
       if full?
         return true
       else
         return false
       end
    end
  end

  def over?
    if won? || draw? || full?
      return true
    else
      return false
    end
  end

  def winner
      if won? == false
          return nil
      else
          set_of_indices = won?
          arbitrary_position =  set_of_indices[0]
             if @board[arbitrary_position] == "X"
                return "X"
              elsif @board[arbitrary_position] == "O"
                return "O"
            end
      end
  end

     def play
       until over? do
         turn
       end
      if won?
        the_winner = winner
        puts "Congratulations #{the_winner}!"
       elsif draw?
        puts "Cat's Game!"
       end
      end

end
