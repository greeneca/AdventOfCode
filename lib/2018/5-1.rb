module D5P1
  class D5P1
    def run(input)
      polymer = input.first.split("")
      idx = 0
      while idx < polymer.length-1
        if polymer[idx] and polymer[idx+1]
          if (polymer[idx].ord -  polymer[idx+1].ord).abs  == 32
            2.times { polymer.delete_at(idx) }
            idx -= 1
          else
            idx += 1
          end
        end
      end

      puts "Length: #{polymer.length}"
    end
  end
end
