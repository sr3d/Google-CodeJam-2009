def process( words, patterns)
  
  patterns.each_with_index do |pattern, index|
    regex = pattern.split('(').collect{ |p|
      "(" + ( ( p =~ /(.+?)\)/ ) ? p.scan( /(.+?)\)/ ).collect{ |p1| p1.first.split('').join('|') }.join('|') : p ) + ")"
      #{}"(" + p + ")"
    }.collect!{ |p| p if p != '()' }.join('')
    
    regex = Regexp.new( regex )
    
    count = 0
    words.each do |w|
      count = count + 1 if regex =~ w
    end
    
    puts "Case \##{index + 1 }: #{count}" 
    
  end

end

def read_file( file )
  file = File.open( file, "r" )
  line = file.gets
  
  $l, $d, $n = line.split(" ")

  words = []

  for i in (0...$d.to_i)
    words << (file.gets).strip
  end
  
  patterns = []
  for i in (0...$n.to_i)
    patterns << (file.gets).strip
  end
  
  return [ words, patterns ]
end


#process( *read_file( "input.txt" ) )
process( *read_file("A-small-attempt0.in") )


