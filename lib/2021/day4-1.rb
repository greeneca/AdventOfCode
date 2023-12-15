module D4P1
  class D4P1
    def run(input)
      seq = input.shift.split(",").map{|x| x.to_i}
      boards = parse_boards(input)
      winner = nil
      num = nil
      while winner.nil?
        num = seq.shift
        boards = game_tick(boards, num)
        winner = get_winner(boards)
      end
      score = get_score(winner, num)
      puts "Winning Score: #{score}"
    end

    def parse_boards(input)
      boards = []
      while input.count > 0
        input.shift
        board = []
        5.times do
          board.push(input.shift.strip.split(" ").map{|x| x.to_i})
        end
        boards.push(board)
      end
      boards
    end

    def game_tick(boards, number)
      boards.each_index  {|i|
        boards[i].each_index {|j|
          boards[i][j].each_index {|k|
            boards[i][j][k] = "x" if boards[i][j][k] == number
          }
        }
      }
      boards
    end

    def get_winner(boards)
      boards.each {|board|
        board.each {|row|
          return board if row.count{|x| x == "x"} == 5
        }
        board.transpose.each {|col|
          return board if col.count{|x| x == "x"} == 5
        }
      }
      nil
    end

    def get_score(winner, num)
      score = 0
      winner.each {|row|
        score += row.select{|x| x != "x"}.sum
      }
      score * num
    end
  end
end
