#require 'ftools'

def process( map, output_filename )
  output_file = File.open( output_filename, 'a+' )
  output_file.write "test"
  output_file.puts "test with new line"
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
      map[ row ] = (file.gets).split( ' ' ).collect{ |n| n.to_i }
    end
    
    puts map.inspect 
    
    process( map, output_filename )
  end
end


input_file = 'input.txt'
read_file_and_process( input_file )