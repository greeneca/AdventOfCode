module D17P1
  class D17P1
    def run(input)
      input = input.first.strip.split(": ").last
      x, y = input.split(", ")
      ranges = []
      [x,y].each do |range|
        ranges.push(range.split("=").last.split("..").map{|v| v.to_i})
      end
      max_y_velocity = ranges[1].sort.reduce(:-).abs
      min_y = ranges[1].sort.last
      while min_y < 0
        min_y -= max_y_velocity
        max_y_velocity -= 1
      end
      max_y_velocity = max_y_velocity.abs
      target = ranges[1].sort
      target = target[0]..target[1]
      max_y = 0
      (max_y_velocity-10..max_y_velocity+100).each do |start_v|
        test_max_y = 0
        v = start_v
        p = 0
        while p >= target.min
          p += v
          v -= 1
          test_max_y = p if p > test_max_y
          if target.include?(p)
            max_y = test_max_y if test_max_y > max_y
            break
          end
        end
      end
      puts "Y value: #{max_y}"
    end
  end
end

module D17P2
  class D17P2
    def run(input)
      config = input.first.strip.split(": ").last
      starting = []
      if input.size > 1
        input[2..-1].each do |line|
          starting += line.split(" ")
        end
        starting.map! do |a|
          a.split(",").map{|b| b.to_i}
        end
        starting.sort!{|a,b| a[0] == b[0] ? a[1] <=> b[1] : a[0] <=> b[0]}
      end

      x, y = config.split(", ")
      ranges = []
      [x,y].each do |range|
        ranges.push(range.split("=").last.split("..").map{|v| v.to_i})
      end
      ranges.map!{|a| a.sort[0]..a.sort[1]}
      x_check_range = (0.5*(((ranges[0].min*8+1)**0.5)-1)).to_i..ranges[0].max
      y_check_range = ranges[1].min..ranges[1].min.abs
      found = []
      x_check_range.each do |x_v_start|
        y_check_range.each do |y_v_start|
          x_v = x_v_start
          y_v = y_v_start
          x, y = 0, 0
          while x < x_check_range.max and y > y_check_range.min
            x += x_v
            y += y_v
            if ranges[0].include?(x) and ranges[1].include?(y)
              found.push([x_v_start, y_v_start, [x, y]])
              break
            end
            y_v -= 1
            x_v -= 1 if x_v > 0
          end
        end
      end
      found.sort!{|a,b| a[0] == b[0] ? a[1] <=> b[1] : a[0] <=> b[0]}
      puts "Count: #{found.count}"
    end
  end
end
