module D3P2
  class D3P2
    def run(input)
      grid = {}
      gears = []
      input.each_with_index do |line, y|
        line.split("").each_with_index do |char, x|
          coor = Vector[x,y]
          grid[coor] = char
          if char == "*"
            gears.push coor
          end
        end
      end
      dirs = [Vector[-1, -1], Vector[-1,0], Vector[-1, 1], Vector[0, -1], Vector[0, 1], Vector[1, -1], Vector[1, 0], Vector[1, 1]]
      back = Vector[-1, 0]
      sum = 0
      gears.each do |part_coor|
        #puts "Testing Gear: #{part_coor}"
        number_starts = []
        dirs.each do |dir|
          test_coor = part_coor+dir
          if isNumber(test_coor, grid)
            while isNumber(test_coor+back, grid) do
              test_coor += back
            end
            number_starts.push test_coor
          end 
        end
        if number_starts.uniq.count == 2
          product = 1
          number_starts.uniq.each do |start|
            org_start = start
            number = ""
            while isNumber(start, grid) do
              number += grid[start]
              start += Vector[1, 0]
            end
            #puts "#{org_start}, #{number}"
            product *= number.to_i
          end
          sum += product
        end
      end
      puts "Sum: #{sum}"
    end
    def isNumber(coor, grid)
      grid[coor].to_i.to_s == grid[coor]
    end
  end
end
