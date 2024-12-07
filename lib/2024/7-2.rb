module D7P2
  class D7P2
    def run(input)
      sum = 0
      input.each do |line|
        answer, values = line.split(":")
        answer = answer.to_i
        values = values.split(" ").map{|v| v.to_i}
        sum += answer if test_values(answer, values)
      end
      puts "Sum: #{sum}"
    end
    def test_values(answer, values)
      return true if answer == values[0] and values.length == 1
      return false if answer > 0 and values.length == 0 or values.length == 0
      result = false
      if answer > values[-1]
        result ||= test_values(answer - values[-1], values[0..-2])
      end
      if answer/values[-1] == (answer*1.0)/values[-1]
        result ||= test_values(answer/values[-1], values[0..-2])
      end
      if answer.to_s.end_with?(values[-1].to_s)
        result ||= test_values(answer.to_s.chomp(values[-1].to_s).to_i, values[0..-2])
      end
      return result
    end
  end
end
