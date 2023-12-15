module D1P1
  class D1P1
    def run(input)
      input.map! {|x| x.to_i}
      input.combination(2) do |pair|
        if pair.sum == 2020
          puts pair.reduce(:*)
          return
        end
      end
    end
  end
end

module D1P2
  class D1P2
    def run(input)
      input.map! {|x| x.to_i}
      input.combination(3) do |pair|
        if pair.sum == 2020
          puts pair.reduce(:*)
          return
        end
      end
    end
  end
end
