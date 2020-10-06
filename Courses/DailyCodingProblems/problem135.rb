=begin
Given a binary tree, find a minimum path sum from root to a leaf.

For example, the minimum path in this tree is [10, 5, 1, -1], which has sum 15.

  10
 /  \
5    5
 \     \
   2    1
       /
     -1
=end

class Node
    attr_reader :data
    attr_accessor :left, :right

    def initialize(data)
        @data = data
        @left = nil
        @right = nil
    end
end

class BST

    def insert(root, data)
        if root.nil?
            root = Node.new(data)
            return root
        end
        if data > root.value
            insert(root.right, data)
        else
            insert(root.left, data)
        end
        return root
    end
end

bst = BST.new
bst.insert(nil, 10)