require 'matrix'

class Knight

  attr_reader :board

  def initialize(board)
    @board = board
  end

  def knight_moves(xy1,xy2)
  	node = xy_to_node(xy1)
  	node_que = []
  	visited = []
    node_que << node
 
    until node_que.empty?           
      node = node_que.shift 
      visited << node
      puts print_node(node)
	  if match?(node,xy2)
	  	puts "Match!"
	    return print_path(node)
	  else 
	  	if node.nxyr && !visited.include?(node.nxyr)
	  		node_que << node.nxyr
	  		node.nxyr.parent_node = node
	  	end
	  	if node.nxyl && !visited.include?(node.nxyl)
	  		node_que << node.nxyl
	  		node.nxyl.parent_node = node
	  	end
	  	if node.sxyr && !visited.include?(node.sxyr)
	  		node_que << node.sxyr
	  		node.sxyr.parent_node = node
	  	end
	  	if node.sxyl && !visited.include?(node.sxyl)
	  		node_que << node.sxyl
	  		node.sxyl.parent_node = node
	  	end
	  	if node.exyr && !visited.include?(node.exyr)
	  		node_que << node.exyr
	  		node.exyr.parent_node = node
	  	end
	  	if node.exyl && !visited.include?(node.exyl)
	  		node_que << node.exyl
	  		node.exyl.parent_node = node
	  	end
	  	if node.wxyr && !visited.include?(node.wxyr)
	  		node_que << node.wxyr
	  		node.wxyr.parent_node = node
	  	end
	  	if node.wxyl && !visited.include?(node.wxyl)
	  		node_que << node.wxyl
	  		node.wxyl.parent_node = node
	  	end
	  end
    end
    return nil
  end

  def print_node(node)
  	return "#{node.xy}"
  end

  def xy_to_node(xy)
  	return @board[xy[0],xy[1]]
  end

  def print_path(node)
  	counter = 1
  	path=[]
  	path << node
  	until node.parent_node == nil
  		counter += 1
  		path << node.parent_node
  		node = node.parent_node
  	end
  	path = path.reverse
  	puts "You made it in #{counter} moves: "
    path.each {|x| print "#{x.xy} "}
  	return 
  end

  def print_que(node_que)
  	node_que.each {|x| print "#{x.xy} "}
  end


  def match?(xy,xy2)
  	puts "testing #{print_node(xy)} and #{xy2}"
  	if  xy == xy_to_node(xy2)
  		return true
  	else
  	  return false
  	end
  end

end #class end

class GameBoard
  attr_accessor :matrix

  def initialize 
    @matrix = Matrix.build(7,7) {|row,col| Node.new([row,col])}
    assign_moves(@matrix)
  end

  def assign_moves(matrix)
  	matrix.each {|x| populate_moves(x)}
  end

  def update_attribute(attribute,value,node)
  	m = "#{attribute}="              #This allows us to cycle through each attribute setter method (created by attr_accessor)
  	begin
  		node.send(m, value)
    rescue
    	puts "Node did not respond to #{attribute}"
    end
  end


  def populate_moves(node)
  	x = node.xy[0]
  	y = node.xy[1] 
  	potential_moves = {
    nxyl: [x-1,y+2],
    nxyr: [x+1,y+2],
    sxyl: [x-1,y-2],
    sxyr: [x+1,y-2],
    exyl: [x+2,y+1],
    exyr: [x+2,y-1],
    wxyl: [x-2,y+1],
    wxyr: [x-2,y-1],
    } 

    potential_moves.each do |key,value|

      if verify_coordinates(value)
      	x = value[0]
      	y = value[1]
      	value = @matrix[x,y]
      	update_attribute(key,value,node)
      end 	
    end
  end

  def verify_coordinates(xy)
  	x = xy[0]
  	y = xy[1]
	if x < 0 || x > 7 || y < 0 || y > 7
		return false
	else
		return true
	end

  end
  
end #class end

class Node
  attr_accessor :xy, :nxyl, :nxyr, :sxyl, :sxyr, :exyl, :exyr, :wxyl, :wxyr, :parent_node
  def initialize(xy,nxyl=nil,nxyr=nil,sxyl=nil,sxyr=nil,exyl=nil,exyr=nil,wxyl=nil,wxyr=nil)
    @xy = xy
	@nxyl = nxyl
    @nxyr = nxyr
    @sxyl = sxyl
    @sxyr = sxyr
    @exyl = exyl
    @exyr = exyr
    @wxyl = wxyl
    @wxyr = wxyr
  end

  def print_node
  	puts "#{self.xy}"
  end

  
end #class end 


chess = GameBoard.new
chess.matrix[0,1].print_node
puts chess.matrix[4,4].sxyr
knight = Knight.new(chess.matrix)
knight.knight_moves([0,0],[4,6])

