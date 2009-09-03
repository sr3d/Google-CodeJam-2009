def process( s, output_filename, idx )
  output_file = File.open( output_filename, 'a+' )


  phrase = "welcome to code jam"
           #0123456789123456789  -- length = 19
  # strip all the extra characters, preserving spaces
  regex = Regexp.new( "[^" + phrase.gsub( /\s/ , '').split('').uniq.push("\\s").join( "|" ) + "]" )
  s.gsub!( regex, '' )
  
  puts s
  
  groups        = []
  index         = 0
  
  # skip the first unmatched characters that happened to be in the mix

  
  for i in ( 0 ... phrase.length )
    while index < s.length and s[ index ] != phrase[ i ]
      index = index + 1
      puts "bumpding string index #{index}"
      
      #break if index > 30
    end 
    
    groups[ i ] = 0
    while s[ index ] == phrase[ i ] or ( s[ index ] == ' ' and phrase[ i ] != ' ' ) # allow spaces between characters
      groups[ i ] = groups[ i ] + 1
      index = index + 1
      
      puts "adding +1 to group"
    end
    
  end

  count = 1
  # The total count is just the combination of the groups
  groups.each{ |g| count = g * count }
  puts count 
  output_file.puts "Case \##{idx + 1}: #{format_number( count )}"

  
  puts groups.inspect
  #phrase.split('').each_with_index do |l, i|
  #  #puts "#{l} #{i}" 
  #end
  
  output_file.close
  
end

def format_number( n )
  case 
  when n < 10:
     "000#{n}"
  when n >= 10 && n < 100:
    "00#{n}"
  when n >= 100 && n < 1000: 
    "0#{n}"
  when n >= 10000:
    n = n.to_s; n[ n.length - 4, n.length ]
  end
end

puts format_number( 1 )
puts format_number( 10 )
puts format_number( 256 )
puts format_number( 0 )


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