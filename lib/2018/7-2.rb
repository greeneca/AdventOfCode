module D7P2
  class D7P2
    WORKERS = 5
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
      work_queue = []
      ticks = -1
      index.each_value do |step|
        if step.required.count == 0
          possible_steps.push step
        end
      end
      while possible_steps.count > 0 or work_queue.count > 0
        finished_steps = []
        work_queue.each do |step|
          step.work
          if step.finished?
            finished_steps.push(step)
          end
        end
        finished_steps.each do |step|
          completed_steps.push(step)
          work_queue.delete(step)
          possible_steps += step.next
        end
        possible_steps.uniq!
        possible_steps.sort! {|a, b| a.value <=> b.value}
        if work_queue.count < WORKERS
          steps_to_delete = []
          possible_steps.each do |step|
            if (step.required - completed_steps).count == 0
              work_queue.push(step)
              steps_to_delete.push(step)
              break if work_queue.count == WORKERS
            end
          end
          steps_to_delete.each do |step|
            possible_steps.delete(step)
          end
        end
        ticks +=1
      end
      puts "Steps Num: #{ticks}"
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
      @length = value.ord - 4
      @worked = 0
    end

    def to_s
      "#{value}: n: #{@next.map{|s| s.value}.join(",")} r: #{@required.map{|s|s.value}.join(",")} l: #{@length}, w: #{@worked}"
    end

    def work
      @worked += 1
    end

    def finished?
      @worked >= @length
    end
  end
end
