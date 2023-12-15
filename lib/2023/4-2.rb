module D4P2
  class D4P2
    def run(input)
      cards = Array.new(input.count, 0)
      input.each  do |line|
        card = Card.new(line)
        cards[card.num] += 1
        ((card.num+1)..(card.num+card.win)).each do |idx|
          cards[idx] += cards[card.num]
        end
      end
      puts "Sum: #{cards.reduce(:+)}"
    end
  end
  class Card
    attr_reader :num, :win
    def initialize(data)
      @num, numbers = data.split(":")
      @num = @num.split(" ").last.to_i - 1
      @winning, @own = numbers.split("|")
      @winning = @winning.split(" ").map{|n|n.to_i}
      @own = @own.split(" ").map{|n|n.to_i}
      @win = 0
      @own.each do |num|
        @win += 1 if @winning.include?(num)
      end
    end
  end
end
