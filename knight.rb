require 'matrix'

class Knight

  def knight_moves(xy1,xy2)


  end

end #class end

class GameBoard
  attr_accessor :matrix

  def initialize 
    @matrix = Matrix.build(8,8) {|row,col| Node.new([row,col])}
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
	if x < 0 || x > 8 || y < 0 || y > 8
		return false
	else
		return true
	end

  end
  
end #class end

class Node
  attr_accessor :xy, :nxyl, :nxyr, :sxyl, :sxyr, :exyl, :exyr, :wxyl, :wxyr

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

