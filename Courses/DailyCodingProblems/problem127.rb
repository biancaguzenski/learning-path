=begin
Let's represent an integer in a linked list format by having each node represent a digit in the number. 
The nodes make up the number in reversed order. For example, the following linked list: 1 -> 2 -> 3 -> 4 -> 5
is the number 54321. Given two linked lists in this format, return their sum in the same linked list format.
For example, given 9 -> 9, 5 -> 2 return 124 (99 + 25) as: 4 -> 2 -> 1
=end


class Node
    attr_accessor :data, :next
    def initialize(data)
        @data = data
        @next = nil
    end
end

class LinkedList
    def initialize
        @head = nil
    end

    def append(data)
        if @head.nil?
            @head = Node.new(data)
        else
            find_tail.next = Node.new(data)
        end
    end

    def find_tail
        current_tail = @head
        until current_tail.next.nil?
            current_tail = current_tail.next
        end
        return current_tail
    end

    def print_list
        current = @head
        puts "List: "
        until current.nil?
            print "#{current.data} "
            current = current.next
        end
    end

    def generate_number(list)
        array = Array.new
        until list.nil?
            array << list.data
        end
    end

    def sum(list1, list2)
        puts generate_number(list)
    end

end

list = LinkedList.new
list.append(10)
list.append(20)
list_2 = LinkedList.new
list_2.append(30)
list_2.append(40)
list.print_list
list_2.print_list
puts list
#sum(list.head, list_2.head)