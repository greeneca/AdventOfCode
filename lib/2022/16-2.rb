module D16P2
  class D16P2
    def run(input)
      @map = {}
      input.each do |line|
        line = line.split(" ")
        room = @map[line[1]]
        unless room
          room ||= Room.new(line[1])
          @map[line[1]] = room
        end
        room.flow_rate = line[4].split("=").last.to_i
        line[9..-1].each do |child|
          name = child.gsub(",", "")
          child = @map[name]
          if child
            room.add_child(child)
          else
            @map[name] = room.createChild(name)
          end
        end
      end
      @cache = {}
      pressure = max_pressure(@map["AA"], @map["AA"], {}, 25)

      puts "Pressure = #{pressure}"
    end

    def max_pressure(cur_a, cur_b, opened, time_left)
      key = "#{cur_a.name}#{cur_b.name}#{opened.keys.join("")}#{time_left}"
      if @cache[key]
        return @cache[key]
      end
      if time_left <= 0
        return 0
      end
      best = 0
      value = 0
      did_open = [false, false]
      current_opened = opened.dup
      [cur_a, cur_b].each_with_index do |current, idx|
        if current_opened[current.name].nil?
          if current.flow_rate > 0
            value = current.pressure_released(time_left)
            current_opened[current.name] = true
            did_open[idx] = true
          end
        end
      end
      to_visit = [[], []]
      [cur_a, cur_b].each_with_index do |current, idx|
        if did_open[idx]
          to_visit[idx].push(current)
        else
          to_visit[idx] += current.children
        end
      end
      to_visit[0].each do |next_a|
        to_visit[1].each do |next_b|
          best = [best, value+max_pressure(next_a, next_b, current_opened, time_left-1)].max
        end
      end
      #puts "#{time_left}:#{best} -> #{current_opened.keys.join(",")}"
      @cache[key] = best
      best
    end
  end
  class Room

    attr_accessor :flow_rate
    attr_reader :children, :name

    def initialize(name)
      @name = name
      @flow_rate = 0
      @children = []
    end

    def createChild(name)
      child = Room.new(name)
      @children.push(child)
      child
    end

    def add_child(child)
      @children.push(child)
    end

    def pressure_released(time_left)
      time_left*@flow_rate
    end

    def to_s
      "#{@name}"
    end
  end
end
