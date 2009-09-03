#require 'ruby-debug'

class Node
  attr_accessor :row, :col, :a, :parent, :edge, :visited, :label
  def initialize( row, col, a )
    @row, @col = row, col
    @a        = a   # altitude
    @visited  = false
  end
  
  def is_sink
    @edge.nil?
  end
  
  def to_s
    "(#{@row}, #{@col})[#{@a}]:  #{@label}"
  end

end


def process( map, output_filename, index )
  output_file = File.open( output_filename, 'a+' )
  output_file.puts "Case \##{index + 1}:"

  for i in ( 0 ... map.length ) # row
    for j in( 0 ... map[0].length )
      node = map[ i ][ j ]
      neighbors = [ 
              i - 1 < 0 ? nil : map[ i -1  ][ j ],                  # north
              j - 1 < 0 ? nil : map[ i ][ j - 1 ],                  # west
              j + 1 == map[0].length  ? nil : map[ i ][ j + 1 ],    # east 
              i + 1 == map.length     ? nil : map[ i + 1 ][ j ]     # south 
            ].compact
      neighbors.each do |neighbor|
        # if neighbor is higher then we "flow" to the current node
        if neighbor.a > node.a
          if neighbor.edge.nil? or neighbor.edge.a >= node.a
            puts "neighber #{neighbor.row},#{neighbor.row} -> #{i},#{j}"
            neighbor.edge = node
          end
        end
      end
    end  
  end
  
  for i in ( 0 ... map.length ) # row
    for j in( 0 ... map[0].length )
      puts "#{i},#{j} -> #{ map[i][j].edge ? map[i][j].edge : 'sink' }"
    end
  end
  
  # traverse one more time to assign the label
  label = 'a'
  for i in ( 0 ... map.length ) # row
    for j in( 0 ... map[0].length )
      node = map[i][j]
      next if node.visited 
      
      temp = []
      while node
        node.visited = true
        temp.push( node )
        node = node.edge
      end
      
      sink_label = ''
      temp.reverse.each do |node|
        if node.is_sink # sink
          #puts "found sink #{node} with"
          if !node.label
            node.label = label.clone  # grrr ... caught me off guard here
            label.succ!
          end
          
          sink_label = node.label
          
        else # not sink, assigning the sink's label
          node.label = sink_label
        end
        
      end

    end
  end
  
  
  # now output
  for i in ( 0 ... map.length ) 
    output_file.puts map[i].collect{ |node| node.label }.join( " " )
  end

  output_file.close
  
end


def read_file_and_process( filename )
  file = File.open( filename, "r" )
  line = file.gets
  
  maps_count = line.to_i
  
  output_filename = filename.gsub( /\.txt\b$/i, '.output.txt' )
  File.delete output_filename if File.exist? output_filename
  
  for i in ( 0 ... maps_count )
    
    
    map = []
    rows_count, cols_count = (file.gets).split(' ').collect{ |n| n.to_i }
    for row in (0... rows_count )
      map[ row ] = []
      (file.gets).split( ' ' ).each_with_index{ |n, index| map[ row ] << Node.new( row, index, n.to_i ) }
    end

    process( map, output_filename, i ) if i == 3

  end
end


input_file = 'input.txt'
read_file_and_process( input_file )