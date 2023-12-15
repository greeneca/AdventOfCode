module D3P1
  class D3P1
    def run(input)
      sum = input.reduce(Array.new(input[0].length-1, 0)) do |sum,number|
        [sum, number.strip.split("").map{|x| x.to_i}].transpose.map{|x| x.reduce(:+)}
      end
      gamma = sum.map {|x| x >= input.count/2 ? "1" : "0"}.join.to_i(2)
      epsilon = sum.map {|x| x < input.count/2 ? "1" : "0"}.join.to_i(2)
      puts "Power Consumption: #{gamma*epsilon}"
    end
  end
end

module D3P2
  class D3P2
    def run(input)
      input.map! {|x| x.strip.split("").map{|y| y.to_i}}
      o2 = input
      co2 = input
      index = 0
      while o2.count > 1
        common = get_common(o2, index)
        o2 = o2.select{|x| x[index] == common}
        index += 1
      end
      index = 0
      while co2.count > 1
        common = get_common(co2, index)
        co2 = co2.select{|x| x[index] != common}
        index += 1
      end

      o2 = o2.first.map{|x| x.to_s}.join.to_i(2)
      co2 = co2.first.map{|x| x.to_s}.join.to_i(2)
      puts "Life Support Rating: #{o2*co2}"
    end

    def get_common(input, index)
      sum = input.reduce(0){|sum,x| sum += x[index]}
      return sum >= input.count/2.0 ? 1 : 0
    end
  end
end
