class MyPiece < Piece
  
  All_My_Pieces = All_Pieces + [[[[0, 0], [-1, 0], [1, 0], [2, 0], [-2,0]], # long(er) (only needs two)
                                [[0, 0], [0, -1], [0, 1], [0, 2],[0,-2]]],
                                rotations([[0, 0], [1, 0], [0, -1], [-1, -1], [-1,0]]), # Weird Z
                                rotations([[0, 0], [1, 0], [0, -1]])] # tiny L

  def self.next_piece(board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.cheat_piece(board)
    MyPiece.new([[0,0]], board)
  end
end

class MyBoard < Board
  def cheat
    if score >= 100 and !@cheat
      @score -= 100
      @chat = true
    end
  end
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 1)
      @current_block.move(0, 0, 1)
    end
    draw
  end
  def next_piece
    if @cheat
      @current_block = MyPiece.cheat_piece(self)
      @cheat = false
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
  end

   # gets the information from the current piece about where it is and uses this
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
    super
    @root.bind('c', proc {@board.cheat})
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

