def process( s, output_filename, index )
  output_file = File.open( output_filename, 'a+' )


  phrase = "welcome to code jam"
           #0123456789123456789  -- length = 19
  # strip all the extra characters, preserving spaces
  regex = Regexp.new( "[^" + phrase.gsub( /\s/ , '').split('').uniq.push("\\s").join( "|" ) + "]" )
  s.gsub!( regex, '' )
  
  puts s
  
  groups = []
  index = 0
  phrase_index = 0
  for i in ( 0 ... phrase.length )
    groups[ i ] = 0
    while s[ index ] == phrase[ i ]
      groups[ i ] = groups[ i ] + 1
      index = index + 1
    end
  end

  count = 1
  groups.each{ |g| count = g * count }
  puts count 
  output_file.puts "Case \##{index + 1}: #{count}"

  
  puts groups.inspect
  #phrase.split('').each_with_index do |l, i|
  #  #puts "#{l} #{i}" 
  #end
  
  output_file.close
  
end


def read_file_and_process( filename )
  file = File.open( filename, "r" )
  count = (file.gets).to_i
  
  output_filename = filename.gsub( /\.in\b$/i, '.out' )
  File.delete output_filename if File.exist? output_filename
  
  for i in ( 0 ... count )
    process( file.gets, output_filename, i )
  end
end


input_file = 'input.in'
read_file_and_process( input_file )