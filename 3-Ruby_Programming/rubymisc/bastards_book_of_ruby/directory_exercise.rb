path = "../../*"
puts Dir.glob("#{path}").length
puts Dir.glob("#{path}*/*").length
file_list = Dir.glob("#{path}*/*")
file_list_rb = Dir.glob("#{path}*/*.{rb}") #.join(",\n")
sorted_files = file_list.sort_by { |item| File.size(item)}
puts sorted_files.class
rev_sort = sorted_files.reverse
puts rev_sort.class
bigten = []
i=0
10.times do
		bigten << rev_sort[i]
		i += 1
	end

puts bigten.class
puts bigten.length


#bigten.each do |item|
#	puts "#{item} #{File.size(item)}"
#end

hash = Dir.glob("#{path}*/*.*").inject({}) do |hsh, fname|
	ext = File.basename(fname).split('.')[-1].to_s.downcase
	hsh[ext] ||= [0,0]
	hsh[ext][0] += 1
	hsh[ext][1] += File.size(fname)
	hsh
end
File.open("file_analysis.txt", "w") do |f|
	hash.each do |arr|
		txt = arr.flatten.join("\t")
		f.puts txt
		puts txt
	end
end