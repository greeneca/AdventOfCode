module D1P2
  class D1P2
    def run(input)
      numbers = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
      sum = 0
      input.each do |line|
        first = {idx: line.length, val: -1}
        last = {idx: -1, val: -1}
        numbers.each_with_index do |num, i|
          idx = line.index(num)
          if idx and idx < first[:idx]
            first[:idx] = idx
            first[:val] = i % 9 +1
          end
          idx = line.rindex(num)
          if idx and idx > last[:idx]
            last[:idx] = idx
            last[:val] = i % 9 +1
          end
        end
        sum += "#{first[:val]}#{last[:val]}".to_i
      end
      puts "Sum: #{sum}"
    end
  end
end
