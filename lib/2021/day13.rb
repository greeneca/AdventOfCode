module D13P1
  class D13P1
    def run(inputs)
      page = {}
      line = inputs.shift
      @max_x,@max_y = 0,0
      while not line.strip.empty?
        x,y = line.strip.split(",").map{|p| p.to_i}
        @max_x = x if x > @max_x
        @max_y = y if y > @max_y
        page[Matrix[[x],[y]]] = true
        line = inputs.shift
      end
      fold = inputs.shift.split(" ").last
      axis, value = fold.split("=")
      value = value.to_i
      case axis
      when "y"
        folded_keys = page.keys.select{|k| k[1,0]>value}
        folded_keys.each do |key|
          new_y = value - (key[1,0]-value)
          page.delete(key)
          page[Matrix[[key[0,0]], [new_y]]] = true
        end
      when "x"
        folded_keys = page.keys.select{|k| k[0,0]>value}
        folded_keys.each do |key|
          new_x = value - (key[0,0]-value)
          page.delete(key)
          page[Matrix[[new_x], [key[1,0]]]] = true
        end
      end
      puts "Point Count: #{page.count}"
    end

    def print_sheet(page)
      (0..@max_y).each do |y|
        line = ""
        (0..@max_x).each do |x|
          if page[Matrix[[x],[y]]]
            line += "#"
          else
            line += " "
          end
        end
        puts line
      end
    end
  end
end
module D13P2
  class D13P2
    def run(inputs)
      page = {}
      line = inputs.shift
      @max_x,@max_y = 0,0
      while not line.strip.empty?
        x,y = line.strip.split(",").map{|p| p.to_i}
        @max_x = x if x > @max_x
        @max_y = y if y > @max_y
        page[Matrix[[x],[y]]] = true
        line = inputs.shift
      end
      while inputs.count > 0
        fold = inputs.shift.split(" ").last
        axis, value = fold.split("=")
        value = value.to_i
        case axis
        when "y"
          folded_keys = page.keys.select{|k| k[1,0]>value}
          folded_keys.each do |key|
            new_y = value - (key[1,0]-value)
            page.delete(key)
            page[Matrix[[key[0,0]], [new_y]]] = true
          end
          @max_y = value
        when "x"
          folded_keys = page.keys.select{|k| k[0,0]>value}
          folded_keys.each do |key|
            new_x = value - (key[0,0]-value)
            page.delete(key)
            page[Matrix[[new_x], [key[1,0]]]] = true
          end
          @max_x = value
        end
      end
      print_sheet(page)
    end

    def print_sheet(page)
      (0..@max_y).each do |y|
        line = ""
        (0..@max_x).each do |x|
          if page[Matrix[[x],[y]]]
            line += "#"
          else
            line += " "
          end
        end
        puts line
      end
    end
  end
end
