module D12P1
  class D12P1

    TARGET_GENERATION = 20

    def run(input)
      start = 0
      generation = 0
      state = /initial state:\s(.*)/.match(input.shift)[1]
      input.shift
      checks = []
      input.each do |line|
        match_data = /([.|#]{5})\s=>\s([.|#])/.match(line)
          checks.push({
            pattern: match_data[1],
            result: match_data[2]
          })
      end

      #print_state(generation, start, state)
      while generation < TARGET_GENERATION
        empty_add = 5 - state.index("#")
        if empty_add > 0
          state = ("."*empty_add)+state
          start -= empty_add
        end
        empty_add = 5 - (state.size - state.rindex("#"))
        if empty_add > 0
          state += "."*empty_add
        end

        next_gen = Array.new(state.size)
        checks.each do |check|
          offset = 0
          while index = state.index(check[:pattern], offset)
            next_gen[index+2] = check[:result]
            offset = index+1
          end
        end
        next_gen.each_with_index do |pot, index|
          unless pot
            next_gen[index] = "."
          end
        end
        state = next_gen.join
        generation += 1
        #print_state(generation, start, state)
      end
      puts sum(state, start)
    end
    def print_state(generation, start, state)
      printf "%2d(%2d): %s\n", generation, start, state
    end
    def sum(state, start)
      offset = 0
      total = 0
      while index = state.index("#", offset)
        offset = index + 1
        total += index+start
      end
      total
    end
  end
end
