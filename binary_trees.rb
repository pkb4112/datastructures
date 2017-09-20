class Tree
	attr_reader :root

  def initialize(root)
    @root = root 
    
  end

  def breadth_first_search(target_val)
    node = @root.clone
    node_que = []
    node_que << node

    until node_que.empty?             
      node = node_que.shift 
      node_print(node)
	  if node.value == target_val
	    return node
	  else 
	  	if node.l_node
	  		node_que << node.l_node
	  	end
	  	if node.r_node
	  		node_que << node.r_node
	  	end
	  end
    end
    return nil
  end


  def depth_first_search(target_val)
    node = @root.clone
  	visited = []
  	node_stack = []
    node_stack << node # start with the root

   until node_stack.empty?
     node = node_stack.last
   	 return node if match?(node,target_val)
       #Given a node 
   	 if node.l_node && !visited.include?(node.l_node)
   		# If you can go left from this node, and you haven't gone left before
   	  return node.l_node if match?(node.l_node,target_val) # test the left node
   	  visited << node.l_node #visited the left node
   	  node_stack << node.l_node #But we can still test nodes beyond it
   	 elsif node.r_node && !visited.include?(node.r_node)
   	  #if you couldn't go left from the node, but you can go right, and you haven't visited the right node
   	  return node.r_node if match?(node.r_node,target_val)
   	  visited << node.r_node
   	  node_stack << node.r_node
   	  else
   	  	node_stack.pop
   	 end
    end
    return nil
  end

  def dfs_rec(node,target_val)
  	return node if match?(node,target_val)
  	node_print(node)
  	return if !node.l_node && !node.r_node 

  	if node.l_node
  		dfs_rec(node.l_node,target_val)
  	end
  	  dfs_rec(node.r_node,target_val)
  end


  def match?(node,target_val)
	if node.value == target_val
		return true
	else
		return false
	end
  end 


  def breadth_to_s
  	node = @root.clone
    node_que = []
    node_que << node

    until node_que.empty?             
      node = node_que.shift 
      #print node_que.inspect
      node_print(node)
	  	if node.l_node
	  		node_que << node.l_node
	  	end
	  	if node.r_node
	  		node_que << node.r_node
	  	end
	  end
    end

    def node_print(node)
    	puts ""
    	if node.value
    	  print "    (#{node.value}) "
    	else
    	  print "     (nil) "
    	end
    	puts ""
    	if node.l_node
    	  print "(#{node.l_node.value})   "
    	else 
    	  print "(nil)   "
    	end
    	if node.r_node
    	  print "  (#{node.r_node.value})" 
    	else 
    	  print "  (nil)"
    	end
    	puts ""	

    end

 




end #class end




class Node

  attr_accessor :p_node, :l_node, :r_node
  attr_reader :value

  def initialize(value=nil)
  	@value = value
  end

  def l_node=(value)   #try to remove this
      @l_node=value
  end

  def r_node=(value) #try to remove this 
      @r_node=value
  end


  def self.build_tree_sorted(sorted_array,start,fin) #[1,2,3,4,5,6,7]
   return if start > fin
  
  	mid = (start+fin)/2
  	value = sorted_array[mid]
  	root = self.new(value)
  	
  	root.l_node = build_tree_sorted(sorted_array,start, mid-1)
  	root.r_node = build_tree_sorted(sorted_array,mid+1,fin)

  	return root
  end

def self.build_unsorted_tree(array)
    root = array.shift #takes first value out of array, this is the root of the tree
    root = self.new(root) #creates the root Node object
	(array.size).times do 
		p_node = root        #the p_node to which we compare each new_node is reset to the root
        new_node=array.shift 
        new_node = self.new(new_node) #next element in the array is the new Node object
        move(p_node,new_node)    # Test new Node against all existing nodes in the tree to see where it belongs
    end
    return root
end

def self.move(p_node,new_node)
	if new_node.value < p_node.value && p_node.l_node  #If the new node is less than the p_node, and p_node has a link to another node 
       p_node = p_node.l_node                           # the node to the left of p_node becomes the new p_node to which we compare new_node
       move(p_node,new_node)                            #restart (recursive)
    elsif new_node.value >= p_node.value && p_node.r_node
    	p_node = p_node.r_node
    	move(p_node,new_node) 
    else                                                  #Process continues until we find a node 
    	if new_node.value < p_node.value
    	  p_node.l_node = new_node
    	  return
    	else
    	  p_node.r_node = new_node
    	  return
        end
    end
end





end #class end


sorted_array = [1,2,3,4,5,6,7,8,9]
unsorted_array = [5,2,6,1,8,4,9]

#puts Node.array.size/2
sorted_test_tree=Tree.new(Node.build_tree_sorted(sorted_array,0,sorted_array.size-1))

test_tree=Tree.new(Node.build_unsorted_tree(unsorted_array))
#puts test_tree.breadth_first_search('a')
#puts test_tree.depth_first_search('a')
#puts sorted_test_tree.breadth_first_search('a')
test_tree.depth_first_search(9)
puts test_tree.dfs_rec(test_tree.root,9)


