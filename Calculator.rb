begin
   f = File.new(ARGV[0], "r")
rescue TypeError
   puts "Adj meg egy file-t!"
   exit
rescue Errno::ENOENT
   puts "Nincs ilyen file!"
   exit   
end

lines = []
$solutions = {}

class String
   def is_integer?
     self.to_i.to_s == self
   end
 end

 def csoda(str)
   if str.is_integer?
      return str.to_i
   else
      return $solutions[str]
   end
end



g = File.new("eredmeny.txt", "w")



f.each_line do |line|
   lines = line.split()
   lines.each do |a|
      a = a.strip
   end
   lines[0] = lines[0].chop #removes "," from first word
   #lines.each do |a|
    #  puts a
   #end
   numbers = lines.drop(3) # removes first 3 elements
   numbers = numbers.map {|str| csoda(str)}

    if lines[1] == "max,"
        tmp =  numbers.max
        g << lines[0]
        g << " = "
        g << tmp
        g << "\n"
        $solutions[lines[0]] = tmp
    elsif lines[1] == "sum,"
         sum = 0
         numbers.each {|a| sum += a}
         g << lines[0]
         g << " = "
         g << sum
         g << "\n"
         $solutions[lines[0]] = sum
    elsif lines[1] == "prod,"
         prod = 1
         numbers.each {|a| prod *= a}
         g << lines[0] 
         g << " = "
         g << prod
         g << "\n"
         $solutions[lines[0]] = prod
    end
end
      
g.close
f.close