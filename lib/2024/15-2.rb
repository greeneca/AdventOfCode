module D15P2
  class D15P2
    def run(input)
      @map = {}
      @robot = nil
      do_move = false
      @max_x, @max_y = 0, 0
      dirs = {"^" => Vector[0, -1], "v" => Vector[0, 1], "<" => Vector[-1, 0], ">" => Vector[1, 0]}
      input.each_with_index do |line, y|
        @max_y = y if y > @max_y
        if line == ""
          do_move = true
        elsif not do_move
          x = 0
          line.split('').each do |char|
            case(char)
            when "@"
              @robot = Vector[x, y]
              @map[Vector[x, y]] = "."
              x += 1
              @map[Vector[x, y]] = "."
              x += 1
            when "#"
              @map[Vector[x, y]] = "#"
              x += 1
              @map[Vector[x, y]] = "#"
              x += 1
            when "."
              @map[Vector[x, y]] = "."
              x += 1
              @map[Vector[x, y]] = "."
              x += 1
            when "O"
              @map[Vector[x, y]] = "["
              x += 1
              @map[Vector[x, y]] = "]"
              x += 1
            end
            @max_x = x if x > @max_x
          end
        else
          line.split('').each do |movement|
            perform_move(dirs[movement])
          end
        end
      end
      sum = 0
      @map.select{|k,v| v == "["}.each do |k,v|
        sum += k[0] + (k[1]*100)
      end
      puts "Sum: #{sum}"
    end
    def print_map()
      (0..@max_y).each do |y|
        (0..@max_x).each do |x|
          if @robot == Vector[x, y]
            print "@"
          elsif @map[Vector[x, y]]
            print @map[Vector[x, y]]
          else
            print "."
          end
        end
        puts ""
      end
    end
    def perform_move(dir)
      next_pos = @robot + dir
      if can_move?(next_pos, dir)
        @robot = @robot + dir
        push(@robot, dir)
      end
    end
    def can_move?(pos, dir)
      if @map[pos] == "."
        return true
      elsif @map[pos] == "#"
        return false
      else
        if dir[1] == 0
          return can_move?(pos+dir+dir, dir)
        else
          if @map[pos] == "["
            return (can_move?(pos+dir, dir) and can_move?(pos+dir+Vector[1, 0], dir))
          elsif @map[pos] == "]"
            return (can_move?(pos+dir, dir) and can_move?(pos+dir+Vector[-1, 0], dir))
          end
        end
      end
    end
    def push(pos, dir)
      if dir[1] == 0
        if ["[", "]"].include?(@map[pos])
          push(pos+dir+dir, dir)
          @map[pos+dir+dir] = @map[pos+dir]
          @map[pos+dir] = @map[pos]
          @map[pos] = "."
        end
      else
        if @map[pos] == "["
          push(pos+dir, dir)
          push(pos+dir+Vector[1, 0], dir)
          @map[pos+dir] = "["
          @map[pos+dir+Vector[1, 0]] = "]"
          @map[pos] = "."
          @map[pos+Vector[1, 0]] = "."
        elsif @map[pos] == "]"
          push(pos+dir, dir)
          push(pos+dir+Vector[-1, 0], dir)
          @map[pos+dir] = "]"
          @map[pos+dir+Vector[-1, 0]] = "["
          @map[pos] = "."
          @map[pos+Vector[-1, 0]] = "."
        end
      end
    end
  end
end
