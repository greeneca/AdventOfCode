module D8P2
  class D8P2
    def run(input)
      node = Node.new(input.first.split.each)
      puts "Value: #{node.value}"
    end
  end
  class Node
    def initialize(input)
      @node_count = input.next.to_i
      @meta_count  = input.next.to_i
      @nodes = []
      @meta = []
      @node_count.times do
        @nodes.push(Node.new(input))
      end
      @meta_count.times do
        @meta.push(input.next.to_i)
      end
    end
    def sum
      node_sum = @nodes.map {|node| node.sum}.reduce(:+)
      node_sum ||= 0
      @meta.reduce(:+) + node_sum
    end
    def value
      if @node_count > 0
        value = 0
        @meta.each do |index|
          if index > 0 and @nodes[index-1]
            value += @nodes[index-1].value
          end
        end
        return value
      else
        return @meta.reduce(:+)
      end
    end
  end
end
