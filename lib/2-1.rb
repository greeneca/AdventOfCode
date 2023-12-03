module D2P1
  class D2P1
    def run(input)
      games = []
      input.each do |line|
        id, draws = line.split(":")
        id =id.split(" ").last.to_i
        game = Game.new(id)
        draws = draws.split(";")
        draws.each do |draw|
          draw = draw.split(",")
          draw.each  do |color|
            num, color = color.chomp.split(" ")
            game.add(num.to_i, color)
          end
        end
        #puts "#{game.isPossible?}, #{game.id}, #{game.red}, #{game.green}, #{game.blue} \t #{line}"
        if game.isPossible?
          games.push(game)
        end
      end
      puts "Sum: #{games.sum{|g| g.id}}"
    end
  end
  class Game
    attr_reader :id, :red, :green, :blue
    def initialize(id)
      @id = id
      @red = 0
      @green = 0
      @blue = 0
    end
    def add(num, color)
      case(color)
      when "red"
        @red  = [@red, num].max
      when "green"
        @green  = [@green, num].max
      when "blue"
        @blue  = [@blue, num].max
      else
        puts "Error: unknown color #{color}"
      end
    end
    def isPossible?
      return  ((@red <= 12) and (@green <= 13) and (@blue <= 14))
    end
  end
end
