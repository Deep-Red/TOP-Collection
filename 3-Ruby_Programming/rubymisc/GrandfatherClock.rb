def chimeTime currentHour
	@reps = 1
	@timeNow += 1
	if @timeNow > 12
		@timeNow -= 12
	end
	while @reps < @timeNow
		@chime.call
		@reps += 1
	end


end

@chime = Proc.new do
	puts 'DONG!'
	puts 'The clock strikes ' + @reps.to_s
end

@timeNow = Time.now.hour.to_i

puts 'It is now ' + @timeNow.to_s + ':00'
puts 'Listen to the clock!'

chimeTime @timeNow





