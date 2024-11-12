module D18P1
  class D18P1
    def run(input)
      dir = {
        "R" => Vector[1, 0],
        "L" => Vector[-1, 0],
        "U" => Vector[0, -1],
        "D" => Vector[0, 1],
      }
      grid = {}
      cur = Vector[0,0]
      grid[cur] = true
    end
  end
end
