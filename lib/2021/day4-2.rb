module D4P2
  class D4P2
    def run(input)
      seq = input.shift.split(",").map{|x| x.to_i}
      boards = parse_boards(input)
      last_winner = nil
      last_num = nil
      while boards.count > 0 and seq.count > 0
        num = seq.shift
        boards = game_tick(boards, num)
        loop do
          winner = get_winner(boards)
          if winner
            last_winner = boards.delete_at(winner)
            last_num = num
          else
            break
          end
        end
      end
      puts last_winner.to_s
      puts last_num
      score = get_score(last_winner, last_num)
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
      boards.each_with_index {|board, index|
        board.each {|row|
          return index if row.count{|x| x == "x"} == 5
        }
        board.transpose.each {|col|
          return index if col.count{|x| x == "x"} == 5
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
