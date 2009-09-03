def process( s, output_filename, idx )
  output_file = File.open( output_filename, 'a+' )


  phrase = "welcome to code jam"
           #0123456789123456789  -- length = 19
  # strip all the extra characters, preserving spaces
  regex = Regexp.new( "[^" + phrase.gsub( /\s/ , '').split('').uniq.push("\\s").join( "|" ) + "]" )
  
  puts "#{s}"
  s.strip! 
  s.gsub!( regex, '' )
  
  puts s
  
  groups        = []
  
  index         = 0
  phrase_index = phrase.length - 1

  index    = s.length - 1
  
  puts "index = #{index}"
  puts "#{s[index].chr}"
  
  
  while( index > 0 )
    groups[ phrase_index ] ||= 0
    puts "scanning phrase at #{phrase_index} found #{phrase[phrase_index].chr} "
    puts "scanning string at index=#{index} found #{s[index].chr} "

    #if phrase_index - 1 < 0
    #  next_char = nil
    #else
    #  next_char = phrase[ phrase_index - 1 ]
    #end
    
    while( s[ index ] == phrase[ phrase_index ] )
      puts "matching #{s[index].chr} at index #{index} with #{phrase[ phrase_index ].chr } at phrase_index = #{phrase_index}"
      groups[ phrase_index ] = groups[ phrase_index ] + 1
      
      # move to next character
      if index >= 0 # s.length - phrase.length
        index = index - 1
        puts "move on to next index #{index}"
      else
        puts "index #{index} is smaller than #{s.length - phrase.length}.  Skipping"
        #break
      end
    end
    
    # move to next 
    if phrase_index > 0
      phrase_index = phrase_index - 1 
    end
  end
  
  count = nil
  # The total count is just the combination of the groups
  groups.each{ |g| count ||= 1; count = g * count }
  puts count 
  output_file.puts "Case \##{idx + 1}: #{format_number( count )}"

  
  puts groups.inspect
  #phrase.split('').each_with_index do |l, i|
  #  #puts "#{l} #{i}" 
  #end
  
  output_file.close
  
end

def format_number( n )
  return 0 if n.nil?
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