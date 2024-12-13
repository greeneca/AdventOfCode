module D13P2
  class D13P2
    def run(input)
      sum = 0
      a = {x: 0, y: 0}
      b = {x: 0, y: 0}
      prize = {x: 0, y: 0}
      input.each do |line|
        if line.start_with?("Button A:")
          a = {x: /X\+(\d+)/.match(line)[1].to_i, y: /Y\+(\d+)/.match(line)[1].to_i}
        elsif line.start_with?("Button B:")
          b = {x: /X\+(\d+)/.match(line)[1].to_i, y: /Y\+(\d+)/.match(line)[1].to_i}
        elsif line.start_with?("Prize:")
          prize = {x: /X=(\d+)/.match(line)[1].to_i, y: /Y=(\d+)/.match(line)[1].to_i}
          prize[:x] += 10000000000000
          prize[:y] += 10000000000000
          tickets = cal_tickets(a, b, prize)
          sum += tickets
        end
      end
      puts "Sum: #{sum}"
    end
    def cal_tickets(a, b, prize)
      xlcm = a[:x].lcm(a[:y])
      factor = Rational(xlcm/a[:x], xlcm/a[:y])
      b_num = ((prize[:y]-(factor*prize[:x]))/(b[:y]-(factor*b[:x]))).to_i
      a_num = ((prize[:x]-(b[:x]*b_num))/a[:x]).to_i
      if a[:x]*a_num + b[:x]*b_num == prize[:x] and a[:y]*a_num + b[:y]*b_num == prize[:y]
        return a_num*3 + b_num
      end
      return 0
    end
  end
end
