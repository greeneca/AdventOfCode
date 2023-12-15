module D8P2
  class D8P2
    def run(input)
      input.map! do |line|
        op, val = line.split
        [op.to_sym, val.to_i]
      end
      input.each_index do |idx|
        if input[idx][0] == :nop or input[idx][0] == :jmp
          modified = Marshal.load(Marshal.dump(input))
          case input[idx][0]
          when :nop
            modified[idx][0] = :jmp
          when :jmp
            modified[idx][0] = :nop
          end
          comp = Computer.new(modified)
          val = comp.run
          if val != -1
            puts "Value: #{val}"
            exit
          end
        end
      end
    end
  end

  class Computer
    def initialize(program)
      @memmory = program
      @acc = 0
      @pointer = 0
      @running = true
    end

    def run
      while @running
        execute_instrunction(@memmory[@pointer])
        check_end
      end
      return @exit_code if @exit_code < 0
      @acc
    end

    def execute_instrunction(command)
      case command[0]
      when :nop
        @pointer += 1
      when :acc
        @acc += command[1]
        @pointer += 1
      when :jmp
        @pointer += command [1]
      end
    end

    def check_end
      @operations ||= []
      @operations.push(@pointer)
      if @operations.count != @operations.uniq.count
        @exit_code = -1
        @running = false
      end
      if @pointer >= @memmory.count
        @exit_code = 0
        @running = false
      end
    end
  end
end
