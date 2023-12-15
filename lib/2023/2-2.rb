module D2P2
  class D2P2
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
        #puts "#{game.power}, #{game.red}, #{game.green}, #{game.blue} \t #{line}"
        games.push(game)
      end
      puts "Sum: #{games.sum{|g| g.power}}"
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
    def power
      return @red*@green*@blue
    end
  end
end
