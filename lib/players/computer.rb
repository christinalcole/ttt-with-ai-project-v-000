module Players

  class Computer < Player

  #   def move(board)
  #     a = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
  #     a.sample
  #   end
  #
  # end
  ###  TEST SECTION FOR BUILDING AI LOGIC ###

    def move(board)
      minmax(board, token)
      @best_move
    end

    def minmax(board, token) #correct args?..needs to be game.current_player...or pass game, access game.current_player
      #return score(board) if game.over? #returns score of game if game is over

      scores = {} #hash key is position/cell on board, value is score associated with position
      spaces = [] #array holds available positions for turn
      #possible_moves = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]

      # possible_moves.each do |move| #populates array of available positions
      #   if board.taken?(move)
      #     spaces << move
      #   end
      # end

      board.cells.each do |cell|
        spaces << cell if (cell == " ")
      end
      #potential_board = board.dup
      spaces.each_index do |space|  #lines 37-41 are causing infinite loop...
        potential_board = board.dup
        potential_board.update(space+1, self) #can't pass "player" here--this is a Player object

        scores[space] = minmax(potential_board, self.token)
      end
      @best_position, best_score = best_move(self, scores)
      best_score

    end

    def best_move(player, scores) #returns max or min k, v pair from scores hash, based on player token
      if player.token == self.token  # self in lines 44, 38, 36, 34 replaced player or current_player, because player is Computer object
        scores.max_by {|k,v| v}
      else
        scores.min_by {|k,v| v}
      end
    end

    def score(game)
      if game.winner == self.token
        10
      elsif game.draw?
        0
      else
        -10
      end
    end


  end #class end (also have class end in line 10)
end
