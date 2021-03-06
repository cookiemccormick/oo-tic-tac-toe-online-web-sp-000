class TicTacToe
  def initialize(board = nil)
    @board = board || Array.new(9, " ")
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7], 
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
    ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, token)
    @board[index] = token
  end

  def position_taken?(index)
    @board[index] != " " 
  end

  def valid_move?(index)
    !position_taken?(index) && index.between?(0, 8)
  end

  def turn_count
    @board.count {|token| token == "X" || token == "O"}
  end
  
  def current_player
    turn_count % 2 == 0 ? "X" : "O"
  end
   
  def turn
    puts "Please enter 1-9:"
    index = input_to_index(gets.strip)
    token = current_player
    if valid_move?(index)
      move(index, token)
    else 
      turn
    end
    display_board
  end
  
  def won?
    WIN_COMBINATIONS.find do |win_combination|
      position_1 = @board[win_combination[0]]
      position_2 = @board[win_combination[1]]
      position_3 = @board[win_combination[2]]
      (position_1 == "X" && position_2 == "X" && position_3 == "X") || 
        (position_1 == "O" && position_2 == "O" && position_3 == "O")
    end
  end
  
  def full?
    @board.all? {|token| token == "X" || token == "O"}
  end

  def draw?
    full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    combo = won?
    if combo
      @board[combo[0]]
    end
  end

  def play
    until over?
      turn
    end
    if won?
      puts "Congratulations #{winner}!"
    else
      puts "Cat's Game!"
    end
  end
end