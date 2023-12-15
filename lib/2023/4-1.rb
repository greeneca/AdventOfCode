module D4P1
  class D4P1
    def run(input)
      sum = 0
      input.each  do |line|
        card = Card.new(line)
        sum += card.points
      end
      puts "Sum: #{sum}"
    end
  end
  class Card
    attr_reader :points
    def initialize(data)
      @winning, @own = data.split(":").last.split("|")
      @winning = @winning.split(" ").map{|n|n.to_i}
      @own = @own.split(" ").map{|n|n.to_i}
      count = 0
      @own.each do |num|
        count += 1 if @winning.include?(num)
      end
      if count > 0
        @points = 2**(count-1)
      else
        @points = 0
      end
      #puts "#{count}, #{@points}"
    end
  end
end
