
class ConnectFour
    attr_accessor :row1, :row2, :row3, :row4, :row5, :row6, :player1_name, :player2_name, :count
    def initialize
        @row1 = ['O', 'O', 'O', 'O', 'O', 'O', 'O']
        @row2 = ['O', 'O', 'O', 'O', 'O', 'O', 'O']
        @row3 = ['O', 'O', 'O', 'O', 'O', 'O', 'O']
        @row4 = ['O', 'O', 'O', 'O', 'O', 'O', 'O']
        @row5 = ['O', 'O', 'O', 'O', 'O', 'O', 'O']
        @row6 = ['O', 'O', 'O', 'O', 'O', 'O', 'O']
        @player1_name = ''
        @player2_name = ''
        @count = 0
    end

    def show_board
       puts "#{@row1}"
       puts "#{@row2}"
       puts "#{@row3}"
       puts "#{@row4}"
       puts "#{@row5}"
       puts "#{@row6}"
       puts "-------------------------------------------------------------\n\n"
    end

    def get_player1_name
        puts 'Player one name: '
        @player1_name = gets.chomp
    end

    def get_player2_name
        puts 'Player two name: '
        @player2_name = gets.chomp
    end

    def mark_cell(index, number)
        list_of_rows = [row6, row5, row4, row3, row2, row1]
        for row in list_of_rows do
            if row[index - 1] == 'O'
                row[index - 1] = number.to_s
                break
            end
        end
        show_board()
    end

    def valid_input?(input)
        if (1..7).include?(input.to_i)
            return true
        else
            return false
        end
    end

    def last_row_verifier(input)
        if @row1[input - 1] != 'O'
            puts 'The last cell is marked'
            return false
        else
            return true
        end
    end

    def input
        input = gets.chomp
        loop do
            break if valid_input?(input)
            puts 'Introduce a value between 1 to 7'
            input = gets.chomp
        end

        loop do
            break if last_row_verifier(input.to_i)
            input = gets.chomp
        end

        return input.to_i
    end

    def four_in_a_row?(line)
        line.each_cons(4) do |a, b, c, d|
            return true if a != 'O' && a == b && a == c && a == d
        end
        false
    end

    def check_winner
        board = [@row1, @row2, @row3, @row4, @row5, @row6]
        # Check rows
        board.each do |row|
            return true if four_in_a_row?(row)
        end
  
        # Check columns
        (0..6).each do |col|
            column = []
            (0..5).each do |row|
                column << board[row][col]
            end
            return true if four_in_a_row?(column)
        end
  
        # Check diagonals
        3.times do |row|
            4.times do |col|
                diagonal = []
                reverse_diagonal = []
                4.times do |i|
                    diagonal << board[row + i][col + i]
                    reverse_diagonal << board[row + i][col + 3 - i]
                end
                return true if four_in_a_row?(diagonal)
                return true if four_in_a_row?(reverse_diagonal)
            end
        end
      false
    end

    def play
        puts "-------------------------------------------------------------\n\n"
        show_board()
        42.times do
            
            if @count.even?
                puts "It's #{@player1_name}'s turn"
                mark_cell(input, 1)

                if check_winner()
                    puts "#{@player1_name} won !!"
                    break
                end
            else
                puts "It's #{@player2_name}'s turn"
                mark_cell(input, 2)

                if check_winner()
                    puts "#{@player2_name} won !!"
                    break
                end
            end
            @count += 1
        end
        if @count == 42
            puts "It's a draw !!"
        end
    end
end

game = ConnectFour.new
game.get_player1_name
game.get_player2_name
game.play
