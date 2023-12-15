module D3P1
  class D3P1
    def run(input)
      grid = {}
      parts = []
      input.each_with_index do |line, y|
        line.split("").each_with_index do |char, x|
          coor = Vector[x,y]
          grid[coor] = char
          if char != "." and  char.to_i.to_s != char
            parts.push coor
          end
        end
      end
      dirs = [Vector[-1, -1], Vector[-1,0], Vector[-1, 1], Vector[0, -1], Vector[0, 1], Vector[1, -1], Vector[1, 0], Vector[1, 1]]
      back = Vector[-1, 0]
      number_starts = []
      parts.each do |part_coor|
        dirs.each do |dir|
          test_coor = part_coor+dir
          test = grid[test_coor]
          if test.to_i.to_s == test
            while isNumber(test_coor+back, grid) do
              test_coor += back
            end
            number_starts.push test_coor
          end 
        end
      end
      sum = 0
      number_starts.uniq.each do |start|
        org_start = start
        number = ""
        while isNumber(start, grid) do
          number += grid[start]
          start += Vector[1, 0]
        end
        #puts "#{org_start}, #{number}"
        sum += number.to_i
      end
      puts "Sum: #{sum}"
    end
    def isNumber(coor, grid)
      grid[coor].to_i.to_s == grid[coor]
    end
  end
end
