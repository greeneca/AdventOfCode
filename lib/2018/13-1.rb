module D13P1
  class D13P1
    NO_STRIP = true
    def run(input)
      grid = {}
      carts = []
      cart_horz = ["<", ">"]
      cart_vert = ["^", "v"]
      input.each_with_index do |row, y|
        row.split("").each_with_index do |char, x|
          if cart_horz.include?(char)
            grid[Vector[x,y]] = "-"
            carts.push(Cart.new(x, y, char))
          elsif cart_vert.include?(char)
            grid[Vector[x,y]] = "|"
            carts.push(Cart.new(x, y, char))
          else
            grid[Vector[x,y]] = char
          end
        end
      end
      while true
        carts.each do |cart|
          cart.move(grid)
          if cart.crash
            puts "Crash: #{cart.pos}"
            exit
          end
        end
      end
    end
  end
  class Cart
    DIR_MAP = {"^" => Vector[0,-1], "v" => Vector[0,1], "<" => Vector[-1, 0], ">" => Vector[1, 0]}
    TURNS = [:left, :straight, :right]
    @@id = 0
    @@cart_map = {}
    def self.cart_map
      @@cart_map
    end
    attr_reader :crash, :pos
    def initialize(x, y, char)
      @id = @@id += 1
      @pos = Vector[x,y]
      @dir = DIR_MAP[char]
      @turn = 0
      @crash = false
      @@cart_map[@pos] = self
    end
    def move(grid)
      @@cart_map[@pos] = nil
      @pos += @dir
      if @@cart_map[@pos]
        @crash = true
        return
      end
      @@cart_map[@pos] = self
      if grid[@pos] == "\\"
        @dir = Vector[@dir[1],@dir[0]]
      elsif grid[@pos] == "/"
        @dir = Vector[@dir[1]*-1,@dir[0]*-1]
      elsif grid[@pos] == "+"
        case TURNS[@turn]
        when :left
          @dir = Vector[@dir[1], @dir[0]*-1]
        when :right
          @dir = Vector[@dir[1]*-1, @dir[0]]
        end
        @turn = (@turn + 1) % TURNS.length
      end
    end
  end
end
