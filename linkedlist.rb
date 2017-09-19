
class LinkedList
	attr_reader = :head, :tail

  def initialize
    @head = nil
	@tail = nil
  end

  def append(node)
  	if @tail == nil  #if @tail == nil then @head must also == nil
  	   @tail = node
       @head = node
  	else
  	  @tail.next_node = node
  	  @tail = node
    end
  end

  def prepend(node)
  	if @tail == nil  #if @tail == nil then @head must also == nil
  	   @tail = node
       @head = node
    else
      node.next_node = @head
      @head = node
    end
  end


  def size
  	counter = 1
  	if @head
  	  node=@head
  	  until node.next_node == nil
  		counter +=1
  		node=node.next_node
      end
      return counter
    else
    	"No list"
    end
  end


  def at(index)
  	node = head
  	until index==0
      index-=1
      node=node.next_node
    end
    
    return node
  end

  def pop
    if self.size > 1
  	  @tail = self.at(self.size-2)
  	  @tail.next_node = nil
    else
  	  "No list"
    end

  end


  def contains?(value)

  	node = head
  	index=0
  	tail_end = self.size

    until index == tail_end
      if self.at(index).value == value
      	return true, index
      end
      index +=1
    end
    return false
  end

  def find(value)
    located,index = contains?(value)
    if located == true
      return index
    else
    	return "Not found"
    end
  end

  def to_s
  	node = @head
  	until node == @tail
  		print "(#{node.value.to_s}) -> "
  		node = node.next_node
    end
    print "(#{node.value.to_s}) -> nil"
  end


  def insert_at(index,new_node)
  	begin
  	  if index == 0 
  	    prepend(node)
  	  else
  	    node = self.at(index-1)
  	    new_node.next_node = node.next_node
  	    node.next_node = new_node
  	  end
  	rescue
      puts "Not a valid input"
    end

  end



  def head
  	return @head
  end

  def tail
  	return @tail
  end








end  #Class End
 

class Node
  attr_reader :value
  attr_accessor :next_node

  def initialize(value=nil,next_node=nil)
  	@value = value
  	@next_node = next_node
  end

  
end



#Testing

linked_list=LinkedList.new
 
node1=Node.new(0)     #head
#puts node1.inspect
node2=Node.new(1)
#puts node2.inspect
node3=Node.new(2)
#puts node3.inspect
node4=Node.new(3)     #tail
#puts node4.inspect

linked_list.append(node2)
linked_list.prepend(node1)
linked_list.append(node3)
linked_list.append(node4)

puts linked_list.size
puts ""
puts linked_list.head
puts ""
puts linked_list.tail
puts ""
puts linked_list.at(3)

linked_list.pop
puts linked_list.size
puts linked_list.tail

puts linked_list.contains?(0)
puts linked_list.find(1)

puts linked_list.to_s

node5=Node.new(4) 

linked_list.insert_at(2,node5)


puts linked_list.to_s