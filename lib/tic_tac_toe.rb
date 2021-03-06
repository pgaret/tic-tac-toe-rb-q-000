WIN_COMBINATIONS = [[0, 1, 2], [0, 3, 6], [0, 4, 8], [2, 5, 8], [6, 7, 8], [1, 4, 7], [2, 4, 6], [3, 4, 5]]

def play(board)
  player = "X"
  while !over?(board)
    turn(board, player)
    if player == "X"
      player = "O"
    else
      player = "X"
    end
  end
  if draw?(board)
    puts "Cats Game!"
  elsif winner(board) != nil
    puts "Congratulations #{winner(board)}!"
  end
end

def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def move(board, location, player)
  location = location.to_i - 1
  board[location] = player
end

def position_taken?(board, location)
  board[location] != " "
end

def valid_move?(board, location)
  location = location.to_i - 1
  location.between?(0,8) && !position_taken?(board, location)
end

def turn(board, player="X")
  puts "Please select a space from 1-9:"
  location = -1
  while (!valid_move?(board, location))
    location = gets.strip
  end
  move(board, location, player)
  display_board(board)
end

def turn_count(board)
  count = 0
  board.each do |place|
    if place == "X" || place == "O"
      count += 1
    end
  end
  return count
end

def current_player(board)
  if turn_count(board)%2 == 0
    return "X"
  else return "O"
  end
end

def won?(board)
  if !board.include?("X") && !board.include?("O")
    return false
  end
  WIN_COMBINATIONS.each do |combo|
    if board[combo[0]] == 'X' || board[combo[0]] == 'O'
      if board[combo[0]] == board[combo[1]] && board[combo[0]] == board[combo[2]]
        return combo
      end
    end
  end
  return false
end

def full?(board)
  if board.include?(" ")
    return false
  end
  return true
end

def draw?(board)
  if !won?(board) && full?(board)
    return true
  end
  return false
end

def over?(board)
  if full?(board) || draw?(board) || won?(board)
    return true
  end
  return false
end

def winner(board)
  victor = won?(board)
  if victor == false
    return nil
  else
    return board[victor[0]]
  end
end
