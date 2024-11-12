module D8P1
  class D8P1
    def run(input)
      node = Node.new(input.first.split.each)
      puts "Sum: #{node.sum}"
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
    end
  end
end
