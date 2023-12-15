module D14P1
  class D14P1
    def run(input)
      mem = []
      mask = nil
      input.each do |command|
        if command.include?("mask = ")
          mask = command.split(" ").last.reverse.split("")
        else
          position = command.split(/\[|\]/)[1].to_i
          value = command.split(" ").last.to_i
          masked_value = []
          value = value.to_s(2).reverse.split("")
          mask.each_with_index do |bit, idx|
            if bit !="X"
              masked_value[idx] = bit
            elsif value[idx]
              masked_value[idx] = value[idx]
            else
              masked_value[idx] = "0"
            end
          end
          mem[position] = masked_value.reverse.join("").to_i(2)
          #puts "Pos: #{position} Val: #{mem[position]}"
        end
      end
      puts "Sum: #{mem.compact.reduce(:+)}"
    end
  end
end

module D14P2
  class D14P2
    def run(input)
      mem = {}
      mask = nil
      input.each do |command|
        if command.include?("mask = ")
          mask = command.split(" ").last.reverse.split("")
        else
          position = command.split(/\[|\]/)[1].to_i
          value = command.split(" ").last.to_i
          masked_position = []
          position = position.to_s(2).reverse.split("")
          mask.each_with_index do |bit, idx|
            if bit == "0" and position[idx]
              masked_position[idx] = position[idx]
            else
              masked_position[idx] = bit
            end
          end
          replace_count = masked_position.count("X")
          max_number = (2**replace_count)-1
          (0..max_number).each do |replace_value|
            replace_value = replace_value.to_s(2).reverse.split("")
            new_position = masked_position.dup
            replace_value.each do |replacement|
              new_position[new_position.index("X")] = replacement
            end
            while new_position.include?("X")
              new_position[new_position.index("X")] = "0"
            end
            position = new_position.reverse.join("").to_i(2)
            mem[position] = value
            #puts "Pos: #{position}, Val: #{value}"
          end
        end
      end
      puts "Sum: #{mem.values.reduce(:+)}"
    end
  end
end
