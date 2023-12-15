module D8P1
  class D8P1
    def run(input)
      input.map! do |line|
        op, val = line.split
        [op.to_sym, val.to_i]
      end
      comp = Computer.new(input)
      val = comp.run
      puts "Value before loop: #{val}"
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
        check_loop
      end
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

    def check_loop
      @operations ||= []
      @operations.push(@pointer)
      if @operations.count != @operations.uniq.count
        @running = false
      end
    end
  end
end
