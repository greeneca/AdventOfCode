module D12P2
  class D12P2
    def run(input)
      list = {}
      input.each do |line|
        nodes = line.strip.split("-")
        nodes.map! do |node|
          if not list[node]
            list[node] = Cave.new(node)
          end
          list[node]
        end
        nodes[0].add_neighbour(nodes[1])
        nodes[1].add_neighbour(nodes[0])
      end
      @paths = 0
      traverse(list["start"], [])
      puts "Number of Paths: #{@paths}"
    end

    def traverse(node, path)
      if node.name == "end"
        #puts path.map{|n| n.name}.join(",")
        @paths += 1
        return
      end
      node.each do |cave|
        check_path = path+[node]
        if cave.is_large
          traverse(cave, check_path)
        elsif "start" != cave.name
          if not check_path.include?(cave)
            traverse(cave, check_path)
          else
            small_caves = check_path.select{|n| not n.is_large}
            if small_caves.uniq.count == small_caves.count
              traverse(cave, check_path)
            end
          end
        end
      end
    end
  end


  class Cave
    attr_reader :name, :is_large

    def initialize(name)
      @name = name
      @adj_caves = []
      @is_large = @name == @name.upcase
    end

    def add_neighbour(cave)
      @adj_caves.push cave
      @adj_caves.uniq!
      @adj_caves.sort!{|a,b| a.name <=> b.name}
    end

    def to_s
      "#{name} -> [#{@adj_caves.map{|n| n.name}.join(",")}]"
    end

    def each
      @adj_caves.each do |cave|
        yield cave
      end
    end
  end
end
