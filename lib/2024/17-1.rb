module D17P1
  class D17P1
    def run(input)
      reg_pointer = 0
      registers = [0, 0, 0]
      ins_pointer = 0
      instructions = []
      output = []
      input.each do |line|
        if line.start_with? "Register"
          registers[reg_pointer] = line.split(' ')[-1].to_i
          reg_pointer += 1
        elsif line.start_with? "Program"
          instructions = line.split(' ')[-1].split(',').map{|i| i.to_i}
        end
      end
      while ins_pointer < instructions.length
        opcode = instructions[ins_pointer]
        operand = instructions[ins_pointer+1]
        ins_pointer += 2
        case(opcode)
        when 0 #adv
          registers[0] = registers[0]/(2**combo(operand, registers))
        when 1 #bxl
          registers[1] = registers[1]^operand
        when 2 #bst
          registers[1] = combo(operand, registers)%8
        when 3 #jnz
          if registers[0] != 0
            ins_pointer = operand
          end
        when 4 #bxc
          registers[1] = registers[1]^registers[2]
        when 5 #out
          output.push(combo(operand, registers)%8)
        when 6 #bdv
          registers[1] = registers[0]/(2**combo(operand, registers))
        when 7 #cdv
          registers[2] = registers[0]/(2**combo(operand, registers))
        end
      end
      puts "Output: #{output.join(',')}"
    end
    def combo(operand, registers)
      case(operand)
      when 0..3
        return operand
      when 4..6
        return registers[operand-4]
      else
        puts "Invalid combo operand: #{operand}"
      end
    end
  end
end
