# Homework assignment: I made a lot of comments while I wrote this program to make sure nothing was forgotten.

class MyPiece < Piece
  
  All_My_Pieces = All_Pieces + [[[[0, 0], [-1, 0], [1, 0], [2, 0], [-2,0]], # long
                                [[0, 0], [0, -1], [0, 1], [0, 2],[0,-2]]], # long rotation
                                rotations([[0, 0], [1, 0], [0, -1], [-1, -1], [-1,0]]), # big one
                                rotations([[0, 0], [1, 0], [0, -1]])] # tiny one


  def self.next_piece(board) # class method is declared with self.methods_name
    MyPiece.new(All_My_Pieces.sample, board) # create a new piece choosing randomly from array of pieces
  end

  def self.cheat_piece(board) # cheat piece = lose 100 points and gets a one-block piece
    MyPiece.new([[0,0]], board)
  end
end

class MyBoard < Board
  def cheat # cheat option - "c" key
    if @score >= 100 and !@cheat # you only lose 100 points if you have more than 100 points
      @score -= 100
      @cheat = true
    elsif @score < 100 and !@cheat # in case you have less then 100 points but you want to cheat
      @cheat = true # you get the cheat piece without losing points
    end
  end
  def rotate_180 # introducing "u" key to rotate 180 degrees
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 1)
      @current_block.move(0, 0, 1)
    end
    draw
  end
  def next_piece
    if @cheat # if cheat is true, next piece is cheat peace
      @current_block = MyPiece.cheat_piece(self)
      @cheat = false
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

  # Gets the information from the current piece about where it is and uses this
  # to store the piece on the board itself.  Then calls remove_filled.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..(locations.size - 1 )).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
  end
end

class MyTetris < Tetris
  def key_bindings
    super # Super brings initialize from Tetris
    @root.bind('c', proc {@board.cheat}) # Using procs to make a closure
    @root.bind('u', proc {@board.rotate_180})
  end
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
end

