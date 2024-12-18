module D17P2
  class D17P2
    def run(input)
      reg_pointer = 0
      registers = [0, 0, 0]
      instructions = []
      input.each do |line|
        if line.start_with? "Register"
          registers[reg_pointer] = line.split(' ')[-1].to_i
          reg_pointer += 1
        elsif line.start_with? "Program"
          instructions = line.split(' ')[-1].split(',').map{|i| i.to_i}
        end
      end
      a = 109550473595422
      a = 109550500334110
      registers[0] = a
      output = run_program(registers, instructions)
      puts "A: #{a} Output: #{output.join(',')} Instructions: #{instructions.join(',')}"
      while output != instructions
        a += 10
        registers[0] = a
        output = run_program(registers, instructions, true)
        if output.length > 5
          registers[0] = a
          output = run_program(registers, instructions)
          puts "A: #{a} Output: #{output.join(',')} Instructions: #{instructions.join(',')}"
        end
      end
      puts "A: #{a} Output: #{output.join(',')} Instructions: #{instructions.join(',')}"
    end
    def run_program(registers, instructions, short = false)
      ins_pointer = 0
      output = []
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
        if output.length > 0 and output[-1] != instructions[output.length-1] and short
          return output
        end
      end
      return output
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
