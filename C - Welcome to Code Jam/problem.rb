def process( s, output_filename, idx )
  output_file = File.open( output_filename, 'a+' )


  phrase = "welcome to code jam"
           #0123456789123456789  -- length = 19
  # strip all the extra characters, preserving spaces
  regex = Regexp.new( "[^" + phrase.gsub( /\s/ , '').split('').uniq.push("\\s").join( "|" ) + "]" )
  
  puts "#{s}"
  s.strip! 
  s.gsub!( regex, '' )
  
  s = s[ s.index( phrase[0].chr ) .. s.rindex( phrase[ phrase.length - 1 ].chr ) ]
  
  puts "#{s} - #{s.length}"
  
  groups        = []
  
  
  i = 0
  
  
  
  for i in 0 ... phrase.length
    puts "i #{i}:  #{phrase[i].chr}"
    groups[ i ] ||= 0
    for j in 0 ... s.length  # for all occurence of the match character, we check the string
      puts "j #{j}:  #{s[j].chr}"

      p1 = phrase[ 0, i ] || ''
      p2 = i + 1 <= phrase.length ? phrase[ i + 1, phrase.length ] : ''

      if s[ j ].chr == phrase[ i ].chr
        puts "found match character at #{j}"
        
        s1 = s[ 0, j ] || ''
        s2 = j + 1 <= s.length ? s[ j + 1, s.length ] : ''

        
        puts "s1:  #{s1}"
        puts "s2:  #{s2}"
        
        valid1 = false
        
        t1 = p1.split(//)
        
        k = s1.length
        while( c = t1.pop )
          puts "trying to match c [ #{c} ]"
          if s1[ 0, k].rindex( c )
            k = s1[ 0, k].rindex( c )
          else
            puts "not found sub-match for c [#{c}] in s1 [ #{s1} ]"
            break
          end
        end
        
        if t1.length == 0 
          valid1 = true
        else
          valid1 = false
          #puts "t1: #{t1}"
        end

        puts "valid1: #{valid1}\n\----"
        
        # match 2nd half
        valid2 = false
        t2 = p2.reverse.split(//)
        
        k = 0
        while( c = t2.pop )
          puts "trying to match c [ #{c} ]"
          if s2[ k, s2.length ].index( c )
            k = s2[ k, s2.length ].index( c )
          else
            puts "not found sub-match for c [#{c}] in s2 [ #{s2} ]"
            break
          end
        end
        
        if t2.length == 0 
          valid2 = true
        else
          valid2 = false
          #puts "t1: #{t1}"
        end        
        
        puts "valid2: #{valid2}"
        
        if valid1 and valid2
          groups[ i ] = groups[ i ] + 1
        end
      
        
        puts "*****"
        puts "valid1: #{valid1} and valid2: #{valid2}"
      end
  
    end
    
    puts "*****************"

    
  end
  
  
  count = nil
  # The total count is just the combination of the groups
  groups.each{ |g| count ||= 1; count = g * count }
  puts count 
  count ||= 0
  output_file.puts "Case \##{idx + 1}: #{format_number( count )}"

  
  puts groups.inspect
  
  
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

def match_left_half( p1, s1 )
  
  
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