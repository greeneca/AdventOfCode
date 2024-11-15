module D7P1
  class D7P1
    def run(input)
      index = {}
      input.each do |line|
        match_data = /Step (.*) must be finished before step (.*) can begin\./.match(line)
        step_required = index[match_data[1]]
        unless step_required
          step_required = Step.new(match_data[1])
        end
        step_allowed = index[match_data[2]]
        unless step_allowed
          step_allowed = Step.new(match_data[2])
        end
        step_required.next.push(step_allowed)
        step_allowed.required.push(step_required)
        index[step_required.value] = step_required
        index[step_allowed.value] = step_allowed
      end
      completed_steps = []
      possible_steps = []
      index.each_value do |step|
        if step.required.count == 0
          possible_steps.push step
        end
      end
      while possible_steps.count > 0
        possible_steps.sort! {|a, b| a.value <=> b.value}
        possible_steps.each do |step|
          if (step.required - completed_steps).count == 0
            completed_steps.push(step)
            possible_steps.delete(step)
            possible_steps += step.next
            break
          end
        end
      end
      print "Steps: "
      completed_steps.each {|step| print step.to_s}
      print "\n"
    end
  end
  class Step
    attr_accessor :next
    attr_accessor :required
    attr_reader :value

    def initialize(value)
      @value = value
      @next = []
      @required = []
    end

    def to_s
      value
    end
  end
end
