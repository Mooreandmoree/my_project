module TicTacToe
  LINES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  class Game
    def initialize(player_1_class, player_2_class)
      @board = Array.new(10)
      @current_player_id = 0
      @players = [player_1_class.new(self, "X"), player_2_class.new(self, "O")]
      puts "#{current_player} goes first"
    end

    def play
      loop do
        place_player_marker(current_player)
        if player_has_won?(current_player)
          puts "#{current_player} wins!"
          print_board
          return
        elsif board_full?
          puts "It's a draw!"
          print_board
          return
        else
          switch_players!
        end
      end
    end

    def free_positions
      (1..9).select { |position| @board[position].nil? }
    end

    def place_player_marker(player)
      position = player.select_position!
      puts "Place #{player.marker} at position #{position}"
      @board[position] = player.marker
    end

    def player_has_won?(player)
      LINES.any? do |line|
        line.all? { |position| @board[position] == player.marker }
      end
    end

    def board_full?
      free_positions.empty?
    end

    def print_board
      col_separator, row_separator = " | ", "--+---+--"
      label_for_position = lambda { |position| @board[position] || position }
      row_positions = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]
      rows_for_display = row_positions.map do |row|
        row.map(&label_for_position).join(col_separator)
      end
      puts rows_for_display.join("\n" + row_separator + "\n")
    end

    def switch_players!
      @current_player_id = 1 - @current_player_id
    end

    def current_player
      @players[@current_player_id]
    end

    # Add this method to get the opponent of the current player
    def opponent
      @players[1 - @current_player_id]
    end
  end

  class Player
    attr_reader :marker

    def initialize(game, marker)
      @game = game
      @marker = marker
    end
  end

  class HumanPlayer < Player
    def select_position!
      @game.print_board
      loop do
        print "Please select a position (#{marker}): "
        selection = gets.chomp.to_i
        return selection if @game.free_positions.include?(selection)
        puts "Position is not available, try again!"
      end
    end

    def to_s
      "Human"
    end
  end

  class ComputerPlayer < Player
    def select_position!
      winning_blocking_position || random_prioritized_position
    end

    def winning_blocking_position
      opponent_marker = @game.opponent.marker
      TicTacToe::LINES.each do |line|
        markers = line.group_by { |position| @game.board[position] }
        markers.default = []

        if markers[nil].length == 1 && markers[self.marker].length == 2
          return markers[nil].first
        elsif markers[nil].length == 1 && markers[opponent_marker].length == 2
          return markers[nil].first
        end
      end
      nil
    end

    def random_prioritized_position
      ([5] + [1, 3, 7, 9].shuffle + [2, 4, 6, 8].shuffle).find do |pos|
        @game.free_positions.include?(pos)
      end
    end
  end
end