module D9P1
  class D9P1

    PLAYERS = 416
    TARGET_MARBLE = [71617, 7161700]

    def run(input)
      TARGET_MARBLE.each do |marble_value|
        scores = Array.new(PLAYERS, 0)
        current_value = 0
        current = Marble.new(0)
        current.next = current
        current.prev = current
        while current_value < marble_value
          scores.each_index do |player|
            current_value +=1
            if current_value % 23 == 0
              7.times {current = current.prev}
              scores[player] += current_value + current.delete
              current = current.next
            else
              current = current.next.insert(current_value)
            end
            break if current_value == marble_value
          end
        end
        puts "#{marble_value}: #{scores.max}"
      end
    end
  end
  class Marble
    attr_accessor :next
    attr_accessor :prev
    attr_reader :value

    def initialize(value)
      @value = value
      @next = nil
      @prev = nil
    end

    def insert(value)
      new = Marble.new(value)
      new.next = @next
      new.prev = self
      @next.prev = new
      @next = new
    end

    def delete
      @prev.next = @next
      @next.prev = @prev
      @value
    end
  end
end
