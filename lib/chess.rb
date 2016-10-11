require 'msgpack'

class Board
	attr_accessor :square, :grid, :turn, :captured, :check, :mate

	def initialize
		@grid = Array.new(8){ |i|
			i = Array.new(8){ |j|
				j = nil
			} }
#		puts @grid[0].inspect
		@grid[6].map! { |x, i| x = Piece.new(i.to_i, 6, "pawn", 2) }
		@grid[1].map! { |x, i| x = Piece.new(i.to_i, 1, "pawn", 1) }
		@grid[7][0] = Piece.new(7, 0, "rook", 2)
		@grid[7][7] = Piece.new(7, 7, "rook", 2)
		@grid[0][0] = Piece.new(0, 0, "rook", 1)
		@grid[0][7] = Piece.new(0, 7, "rook", 1)
		@grid[7][1] = Piece.new(7, 1, "knight", 2)
		@grid[7][6] = Piece.new(7, 6, "knight", 2)
		@grid[0][1] = Piece.new(0, 1, "knight", 1)
		@grid[0][6] = Piece.new(0, 6, "knight", 1)
		@grid[7][2] = Piece.new(7, 2, "bishop", 2)
		@grid[7][5] = Piece.new(7, 5, "bishop", 2)
		@grid[0][2] = Piece.new(0, 2, "bishop", 1)
		@grid[0][5] = Piece.new(0, 5, "bishop", 1)
		@grid[7][3] = Piece.new(7, 3, "queen", 2)
		@grid[0][3] = Piece.new(0, 3, "queen", 1)
		@grid[7][4] = Piece.new(7, 4, "king", 2)
		@grid[0][4] = Piece.new(0, 4, "king", 1)

#		puts @grid[0].inspect

		@turn = 0
		@check = 0
		@mate = 0
		@captured = []
	end

	def display
		disp = []
		cap_disp = []
		@grid.each{|i| i.each {|j| j == nil ? disp << "_" : disp << j.icon }}
		@captured.each{|i| cap_disp << i.icon }
		
		puts "   a  b  c  d  e  f  g  h  "
		puts "8  #{disp[0..7].join("  ")}"
		puts "7  #{disp[8..15].join("  ")}"
		puts "6  #{disp[16..23].join("  ")}"
		puts "5  #{disp[24..31].join("  ")}"
		puts "4  #{disp[32..39].join("  ")}"
		puts "3  #{disp[40..47].join("  ")}"
		puts "2  #{disp[48..55].join("  ")}"
		puts "1  #{disp[56..63].join("  ")}"
		puts ""
		puts "Captured: #{captured == [] ? 'nothing' : cap_disp.join('')}"
	end

	def is_piece?(square)
#		puts "the square is: #{square.inspect}"
		false if square.nil?
		false if square[0].nil?
		false if square[1].nil?
		grid[square[0]][square[1]] == nil ? false : true
	end

	def on_board?(square)
		if square[0] == nil || square[1] == nil
			return false
		elsif square[0].between?(0,7) && square[1].between?(0,7) 
			return true 
		else 
			return false
		end
	end

	def tried_to_move_opponent_piece
		puts "That piece doesn't belong to you!"
		@turn -= 1
		play_turn
	end

	def invalid_square_selected
		puts "That square isn't on the board! Try again."
		@turn -= 1
		play_turn
	end

	def empty_square_selected
		puts "You picked a square without a piece on it,"
		puts "let's try again."
		@turn -= 1
		play_turn
	end

	def illegal_move(from)
		puts "That isn't a legal move for #{grid[from[0]][from[1]]}!"
		puts "Let's try again."
		@turn -= 1
		play_turn
	end

	def square_occupied_by_self?(square)
		return false if grid[square[0]][square[1]].nil?
		allegiance = grid[square[0]][square[1]].player
		puts allegiance.class
		puts "Current: #{@current_player.class}"
		allegiance == @current_player ? true : false
	end

	def attempt_to_move_into_check?(from, to)
		grid[from[0]][from[1]].type == "king" ? king_pos = to : king_pos = find_king(grid[from[0]][from[1]].player)
		
		from_temp = grid[from[0]][from[1]]
		to_temp = grid[to[0]][to[1]]
		grid[from[0]][from[1]] = nil
		grid[to[0]][to[1]] = from_temp

		if check?(king_pos, from_temp.player) != []
			grid[from[0]][from[1]] = from_temp
			grid[to[0]][to[1]] = to_temp
			true
		else
			grid[from[0]][from[1]] = from_temp
			grid[to[0]][to[1]] = to_temp
			false
		end
	end

	def suicide_attempt
		puts "You can't take your own piece!"
		puts "Give that another shot."
		@turn -= 1
		play_turn
	end

	def find_king(player)
#		agressor = 0
#		player == 2 ? agressor = 1 : agressor = 2
		grid.each_with_index do |x, i|
#			puts x
#			puts i
#			puts "Once"
			x.each_with_index do |y, j|
#				puts "y: #{y}"
#				puts "j: #{j}"
				if y != nil
					if y.type == "king" && y.player == player
						king_pos = [i,j]
#						puts "Player #{player}s king is at:"
#						puts king_pos
#						puts "\n"
						return king_pos
					end
				end
			end
		end
	end

	def find_pieces(player)
		player_pieces = []
		for i in 0..7
			for j in 0..7
				print grid[i][j].inspect
				puts grid[i][j].nil?
				unless grid[i][j].nil?
					player_pieces << [i,j] if grid[i][j].player == player
				end
			end
		end
		return player_pieces
	end

	def check?(king_pos, player)

#		king_pos = find_king(player)
		opponent = 0
		player == 1 ? opponent = 2 : opponent = 1
#		grid[king_pos[0]][king_pos[1]].player == 1 ? opponent = 2 : opponent = 1
		opponent_pieces = []
		threatening_pieces = []
		opponent_pieces = find_pieces(opponent)
#		puts "The opponent's pieces are: #{opponent_pieces}"

		opponent_pieces.each do |pt|
			unless grid[pt[0]][pt[1]].type == "king"
#				puts "Checking #{pt.inspect} to see if it can reach the king at #{king_pos}"
				if can_it_move?(pt, king_pos)
#					puts "#{pt.inspect} can reach the king at #{king_pos.inspect}"
					threatening_pieces << pt 
				end
			end
		end
#		threatening_pieces << [i,j] if can_it_move?([i,j], king_pos)
#				puts "Line 132ish #{i}, #{j}"
#				possible_threat = grid[i][j]
#				if is_piece?([i,j]) && square_occupied_by_self?([i,j])
#					if on_board?(to)
#						if (legal_route?([i,j], king_pos) && trace_route([i,j], king_pos))
#							if square_occupied_by_self?(king_pos)
#								false
#							else
#								threatening_pieces << [i,j] 
#							end
#						else
#							false
#						end
#					else
#						false
#					end
#				else
#					false
#				end
#			end
#		end
#		puts "and is threatened by #{threatening_pieces.inspect}"
		return threatening_pieces
	end

	def checkmate?(player)
#		mate_1 = false
#		mate_2 = false
#		agressor = threatening_pieces[0].player
#		agressor == 2 ? player = 1 : player = 2
#		king_1 = find_king(1)
#		king_2 = find_king(2)
		player_king = find_king(player)
#		threaten_1 = check?(king_1, 1)
#		threaten_2 = check?(king_2, 2)
		threatened_by = check?(player_king, player)
#		puts "threaten_1.length is #{threaten_1.length}"
#		puts "threaten_2.length is #{threaten_2.length}"
#		puts "threatened_by.length is #{threatened_by.length}"
#		player_in_check = threaten_1.length <=> threaten_2.length
#		player_in_check = 2 if player_in_check == -1
		player_in_check = player
#		defenders_pieces = find_pieces(player_in_check)
		defenders_pieces = find_pieces(player)
#		if player_in_check == 2 
#			king_in_check = king_2 
#			threatening_pieces = threaten_2
#		else
#			king_in_check = king_1
#			threatening_pieces = threaten_1
#		end
		king_in_check = player_king
		threatening_pieces = threatened_by - [false]
		king_pos = king_in_check
		check_spots = []
#		if player_in_check == 0
#			return false
#		elsif threaten_1.length + threaten_2.length == 1
		if threatening_pieces.length == 1
#			puts "249ish"
			defenders_pieces.each do |defender|
				threatening_pieces.each do |tp|
#					return false if can_it_move?(defender, tp) && !attempt_to_move_into_check?(defender, tp)
					check_spots << (can_it_move?(defender, tp) && !attempt_to_move_into_check?(defender, tp))
#					puts "1 #{defender.inspect} to #{tp.inspect} should negate check" if check_spots.last == true
				end
			end
			intervening_squares = threatening_pieces.each { |tp| trace_route(tp, king_pos) }
#			puts "the intervening squares are #{intervening_squares.inspect}"
			defenders_pieces.each do |defender|
				intervening_squares.each do |is|
#					return false if can_it_move?(defender, is) && !attempt_to_move_into_check?(defender, is)
					check_spots << (can_it_move?(defender, is) && !attempt_to_move_into_check?(defender, is))
#					puts "2 #{defender.inspect} to #{is.inspect} should negate check" if check_spots.last == true
				end
			end
		else
#			puts "263ish"
			for i in -1..1
				for j in -1..1
					a = king_pos[0]+i
					b = king_pos[1]+j
					check_spots << (can_it_move?(king_pos, [a,b]) && !attempt_to_move_into_check?(king_pos, [a,b]))
#					puts "3 king to [a,b] should negate check" if check_spots.last == true
				end
			end
		end
		no_mate_yet = check_spots.include?(true)
#		puts "no_mate_yet is set to #{no_mate_yet}"
		
#		puts "if #{check_spots.inspect} includes true then no mate"
		no_mate_yet == false ? true : false
#		puts "SET CHECKMATE"
#		check_spots.include?(false) ? false : true
	end

	def name_square(input)
		name_piece = []
		n_p = input.split("")
#		resign if n_p == ["r", "e", "s", "i", "g", "n"]
#		puts n_p.inspect
		name_piece[1] = n_p[0].downcase.bytes.pop

		name_piece[1] -= 97
		reversing_array = [7, 6, 5, 4, 3, 2, 1, 0]
		name_piece[0] = reversing_array[n_p[1].to_i - 1]
		puts name_piece.inspect
		name_piece
	end

	def get_input
		input = gets.chomp
		handle_input(input)
	end

	def handle_input(input)
		case input
		when "r"
			resign
		when "s"
			save_game
		when "l"
			load_game
		else
			name_square(input)
		end
	end

	def dont_move_into_check
		puts "YOU CANT MOVE INTO CHECK"
		@turn -= 1
		play_turn
	end

	def play_turn
		display
		@turn += 1
		@current_player = 0
		@turn % 2 == 0 ? @current_player = 1 : @current_player = 2
		@current_player == 1 ? opponent = 2 : opponent = 1
		from = []
		to = []
		puts "What piece would you like to move?"
		from = get_input
		tried_to_move_opponent_piece unless square_occupied_by_self?(from)

		puts "To where would you like it moved?"
		to = get_input

		dont_move_into_check if attempt_to_move_into_check?(from, to)
		
		can_it_move?(from, to) ? move_piece(from, to) : illegal_move(from)

		if check?(find_king(opponent),opponent).length > 0
#			puts "328ish IiiiiiiiiiiiiiiiiiiiiiiiieIIIIIIIIIIIIIIIIIIIIIIIIIIII"
			if checkmate?(opponent)
				@mate = 1
#				puts "OLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIOLIO"
			end
		end
#		checkmate?(2) if check?(find_king(2),2)
		puts "@mate = #{@mate}"
		game_over? ? game_over_report : play_turn

	end

	def can_it_move?(from, to)
#		print "A"
		if is_piece?(from)
#			print "B"
			if on_board?(to)
#				print "C"
				if (legal_route?(from, to) && !trace_route(from, to).include?(false))
#					print "D"
					if (is_piece?(to) && grid[from[0]][from[1]].player == grid[to[0]][to[1]].player)
#					print "E"
						false
#						suicide_attempt
					else
#					print "F"
						true
					end
				else
					false	
#					illegal_move(from)
				end
			else
				false
#				empty_square_selected
			end
		else
			false
#			invalid_square_selected
		end
	end

	def in_file?(from, to)
		from[1] - to[1] == 0 ? true : false
	end

	def in_rank?(from, to)
		from[0] - to[0] == 0 ? true : false
	end

	def on_diagonal?(from, to)
		file = from[0] - to[0]
		rank = from[1] - to[1]
		file.abs == rank.abs ? true : false
	end

	def knight_move?(from, to)
		knight_routes = [[1,2],[2,1],[-1,2],[-2,1],[1,-2],[2,-1],[-1,-2],[-2,-1]]
		move_route = []
		move_route[0] = to[0] - from[0]
		move_route[1] = to[1] - from[1]
		knight_routes.include?(move_route) ? true : false
	end

	def only_one_step?(from, to)
		file = from[0] - to[0]
		rank = from[1] - to[1]
		puts file
		puts rank
		file.between?(-1,1) && rank.between?(-1,1) ? true : false
	end

	def forward_move?(from, to)
		progress = to[0] - from[0]
		case @current_player
		when 2
			progress <= 0 ? true : false
		when 1
			progress <= 0 ? false : true
		end
	end

	def valid_en_passant?(from, to)
# bug in en_passant allows capturing of own pieces at least from starting position
# => possibly corrected by changing assignment operator to equivalency test
		return false unless on_diagonal?(from, to) && only_one_step?(from, to)
		return false if grid[from[0]][to[1]].nil?
		return false if grid[from[0]][from[1]].en_passant_eligible == false
		captured << grid[from[0]][to[1]]
		grid[from[0]][to[1]] = nil
		return true
	end

#Problem with #has_moved method being called on an array needs correcting. 
#Anticipate possible problem of rook attempting to take the king after castling is complete.

	def castle(from, to)
		if from.has_moved == false && trace_route == true
			rook_from = 7 if to[1] == 6
			rook_from = 0 if to[1] == 1
			
			kingtomove = grid[from[0]][from[1]]
			rooktomove = grid[7][to[1]]
			destination = grid[to[0]][to[1]]
			grid[to[0]][to[1]] = kingtomove
			grid[from[0]][from[1]] = rooktomove
			grid[7][to[1]] = nil
			grid[to[0]][to[1]].has_moved = true
		else
			false
		end
	end

	def pawn_move?(from, to)
# Pawn captures not allowed, need to rewrite.
#		puts "381ish"
		rank = from[0] - to[0]
		file = from[1] - to[1]
#		puts "File is: #{file}"
		if file == 0
#			puts "No Capture"
			if 	forward_move?(from, to)
				if only_one_step?(from, to)
					grid[from[0]][from[1]].en_passant_eligible = false
					true
				elsif (grid[from[0]][from[1]].has_moved == false && (from[0] - to[0] == 2 || from[0] - to[0] == -2))
					grid[from[0]][from[1]].en_passant_eligible = true
					true
				else
					false
				end
			else
				false
			end
		elsif only_one_step?(from, to)
#			puts "Capture? #{grid[to[0]][to[1]]}"
			return false if grid[to[0]][to[1]] == nil
#			puts "LINE 228ish"
#			return true
			#
			#grid[from[0]][from[1]].en_passant_eligible = false
			valid_en_passant?(from, to) ? true : false
		else
			false
		end
	end

					



#		if forward_move?(from, to)
#			if in_file?(from, to)
#				if only_one_step?(from, to)
#					true
#				elsif grid[from[0]][from[1]].has_moved? 
#					valid_en_passant?(from, to)
#				else
#					false
#				end
#			else
#				false
#			end			
#		else
#			false
#		end
#	end
	def legal_route?(from, to)
#		puts "431ish"
		piece = grid[from[0]][from[1]]
		case 
		when piece.type == "rook"
			in_rank?(from, to) ^ in_file?(from, to) ? true : false
		when piece.type == "knight"
			knight_move?(from, to) ? true : false
		when piece.type == "bishop"
			on_diagonal?(from, to) ? true : false
		when piece.type == "queen"
			on_diagonal?(from, to) || in_file?(from, to) || in_rank?(from, to) ? true : false
		when piece.type == "king"
			return false if check?(to, grid[from[0]][from[1]].player) != []
			if only_one_step?(from, to)
				on_diagonal?(from, to) || in_file?(from, to) || in_rank?(from, to) ? true : false
			elsif from[1] - to[1] == -2 || from[1] - to[1] == -3
				castle(from, to) ? true : false
			else
				false
			end
		when piece.type == "pawn"
#			puts "Line 274ish: "
			pawn_move?(from, to) ? true : false
#			puts "#{h}"
#			return h
		end
	end

#	def obstructed?(from, to)
#
#	end

	def trace_route(from, to)
#		puts "464ish"
#		puts "#{grid[from[0]][from[1]].type}"
		rank_direction = to[0] <=> from[0]
		file_direction = to[1] <=> from[1]
		rank_change = from[0] - to[0]
		file_change = from[1] - to[1]
		adder = []
		check_square = from
		square_status = []
		return square_status if grid[from[0]][from[1]].type == "knight"
		if rank_direction == 1
			(a,b = from[0],to[0])
			adder[0] = 1
		else
			(a,b = to[0],from[0])
			adder[0] = -1
		end
		if file_direction == 1
			(c,d = from[1],to[1])
			adder[1] = 1
		else
			(c,d = to[1],from[1])
			adder[1] = -1
		end
#		puts "Variables assigned: \n a = #{a} b = #{b} c = #{c} d = #{d}"
		if rank_change != 0 && file_change != 0
#			puts "Diagonal Move!"
			for i in a...b-1
				if a == b-1
#					puts "491ish"
					square_status << false
				else
#					puts "i = #{i}"
#					puts "495ish"
#					puts square_status.inspect
					check_square = [check_square, adder].transpose.map {|x| x.reduce(:+)} 
					is_piece?(check_square) ? square_status << false : square_status << check_square
#					puts "After: #{square_status.inspect}"
				end
			end
#			i = a+1
#			j = c+1
#			while i < b
#				i += 1
#				j += 1
#				is_piece?([i,j]) ? square_status << false : square_status << true
#			end
		elsif rank_change != 0
#			puts "502ish"
			for i in a+1...b do
#				puts "i = #{i}"
				if a+1 == b 
					square_status << false
				else
					is_piece?([i,c]) ? square_status << false : square_status << [i,c]
				end
			end
		elsif file_change != 0
#			puts "508ish"
			for i in c+1...d do
				if c+1 == d 
					square_status << false
				else
#					puts "i = #{i}"
					is_piece?([a,i]) ? square_status << false : square_status << [a,i]
				end
			end
		else
			return square_status
		end
#		puts "square status: #{square_status.inspect}"
		return square_status
#		if square_status.include?(false)
#			puts "returning FALSE"
#			return false
#		else
#			puts "returning TRUE"
#			return true
#		end
	end

	def move_piece(from, to)
		tomove = grid[from[0]][from[1]]
#		puts tomove.inspect
#		puts tomove.inspect
		destination = grid[to[0]][to[1]]
		captured << destination if destination != nil
		grid[to[0]][to[1]] = tomove
		grid[from[0]][from[1]] = nil
		grid[to[0]][to[1]].has_moved = true
		grid[to[0]][to[1]].position = [to[0], to[1]]
#		grid[to[0]][to[1]] = to
#		play_turn
	end

	def game_over?
		@mate == 1 ? true : false
	end

	def game_over_report
		puts "Game Over"
		puts "Player #{@current_player} has won!"
	end

	def resign
		who = @current_player == 1 ? "White" : "Black"
		puts "The #{who} player has resigned."
		return false
	end

	def save_game
#		grid_to_save = grid.to_msgpack
		
#		game_state << grid.each
		vars = [turn, check, mate, captured]#.to_s
		save_file = File.open("Saved Game", "w")
			p_a =[]
			grid_data = []
			grid.each do |l|
				l.each do |p|
					if p == nil
						p_a << nil
					else
						p_a << p.position[0]
						p_a << p.position[1]
						p_a << p.type
						p_a << p.player
					end
					grid_data << p_a 
				end
#				p_a = []
			end
			save_file.puts  p_a
#			save_file.puts grid#.to_msgpack
			save_file.puts vars#.to_msgpack
		save_file.close
		puts "Game saved!"
		@turn -= 1
		play_turn
		return false
	end

	def load_game
#		junk = []
		game_data = []
		load_file = File.open("Saved Game")
#		load_file_packed = ""
		while !load_file.eof?
			game_data << load_file.readline
		end
#		puts load_file_packed
#		puts load_file_packed.inspect
#		puts load_file_packed.class
#		puts load_file_packed.length
	#	l_f_p_2 = load_file_packed[0..-4]
	#	puts l_f_p_2.inspect
#		load_file_data = MessagePack.load load_file_packed
#		puts load_file_data
#		processed_game_data = game_data.split ","
#		puts processed_game_data
		puts game_data.inspect
		puts game_data.length
		puts game_data[0].length
		64.times do |i|
			a = (i/8).floor
			b = (i%8)
			print "SQUARE [#{a},#{b}] BEING POPULATED "
			if game_data[0] == "\n"
				game_data.shift
				@grid[a][b] = nil
				puts "as nil"
			else
				@grid[a][b] = Piece.new(game_data.shift.chomp, game_data.shift.chomp, game_data.shift.chomp, game_data.shift.chomp)
				puts "with a new piece: #{@grid[a][b].inspect}"
			end
#			@grid[i] = game_data[i]
		end
#		@grid[0..63] = game_data[0..63]
		puts game_data.inspect
		@turn = game_data.shift.chomp.to_i
		@check = game_data.shift.chomp.to_i
		@mate = game_data.shift.chomp.to_i
		puts game_data.inspect
		until game_data.length == 0
			@captured << Piece.new(game_data.shift.chomp.to_i, game_data.shift.chomp.to_i, game_data.shift.chomp, game_data.shift.chomp.to_i)
		end
		puts "turn: #{@turn.inspect}"
		puts "captured: #{@captured.inspect}"
#		puts @grid[0]
#		puts @grid[0].class
#	puts @grid[0].inspect
		load_file.close
#		display
		@turn -= 1
		play_turn
		return false
	end
end

#class Player
#	def initialize
#
#	end
#end

class Piece
	attr_accessor :position, :type, :player, :piece, :icon, :has_moved, :en_passant_eligible#, :square_exists

	def initialize(x, y, type, player)
		@position = [x.to_i,y.to_i]
		@type = type
		@player = player.to_i
#		@piece = #@type.new(@player)
		@icon = assign_icon(type, player)#@piece.icon
		@has_moved = false
		@en_passant_eligible = false
	end

	def assign_icon(type, player)
#		puts type.inspect
#		puts player.class
#		puts 1.class
		if player == 1
			case
			when type == "pawn"
				"\u2659"
			when type == "king"
				"\u2654"
			when type == "queen"
				"\u2655"
			when type == "rook"
				"\u2656"
			when type == "bishop"
				"\u2657"
			when type == "knight"
				"\u2658"
			end
		else
			case
			when type == "pawn"
				"\u265F"
			when type == "king"
				"\u265A"
			when type == "queen"
				"\u265B"
			when type == "rook"
				"\u265C"
			when type == "bishop"
				"\u265D"
			when type == "knight"
				"\u265E"
			end
		end
	end

#	def move
#		self.square_exists?
#		self.type.legal_routes
#	end

#	def square_exists?(destination)
#		8 >= destination[0] && destination[0] >= 0 ? true : false
#		8 >= destination[1] && destination[1] >= 0 ? true : false
#	end

	def to_msgpack(piece)
		MessagePack.dump ({
		:position => @position,
		:type => @type,
		:player => @player,
		:icon => @icon,
		:has_moved => @has_moved,
		:en_passant_eligible => @en_passant_eligible
		})
	end

	def self.from_msgpack(piece)
		data = MessagePack.load piece
		self.new(data['position'], data['type'], data['player'], data['icon'], data['has_moved'], data['en_passant_eligible'])
	end

end

#class pawn < Piece
#	attr_accessor :icon#, :en_passant_eligible
#	def initialize(player)
#		@player = player
#		@icon = @player == 2 ? "\u2659" : "\u265F"
#		@en_passant_eligible = false
#	end

#	def legal_routes
#		if @player == 1
#			[[1, 1], [-1, 1]]
#		else
#			[[1, -1], [-1, -1]]
#		end
#	end
#end

#class rook < Piece
#	attr_accessor :icon, :legal_route#, :castling_eligible
#	def initialize(player)
#		@player = player
#		@icon = player == 2 ? "\u2656" : "\u265C"
#		@castling_eligible = true
#	end

#	def legal_route(destination)
#		if destination[0] == self.position[0] && destination[1] == self.position[1]
#			return false
#		elsif destination[0] != self.position[0] && destination[1] != self.position[1]
#			return false
#		else 
#			return true
#		end
#	end
#end

#class knight < Piece
#	attr_accessor :icon
#	def initialize(player)
#		@player = player
#		@icon = @player == 2 ? "\u2658" : "\u265E"
#	end

#end

#class bishop < Piece
#	attr_accessor :icon
#	def initialize(player)
#		@player = player
#		@icon = @player == 2 ? "\u2657" : "\u265D"
#	end
#
#end

#class queen < Piece
#	attr_accessor :icon
#	def initialize(player)
#		@player = player
#		@icon = @player == 2 ? "\u2655" : "\u265B"
#	end

#end
#
#class king < Piece
#	attr_accessor :icon#, :castling_eligible
#	def initialize(player)
#		@player = player
#		@icon = @player == 2 ? "\u2654" : "\u265A"
#		@castling_eligible = true
#		@in_check = 0
#	end

#end


game = Board.new
#game.display
#game.check?(1, 1)
#puts "game: \n#{game.inspect}"
#puts "grid: \n#{game.grid.inspect}"
#puts "grid.each: \n#{game.grid.each.inspect}"
#puts game.grid[0][0].class
game.play_turn
#puts game.grid[0][0].type
#puts game.grid[0][0].player
#game.move_piece([0,0], [6,0])
#puts "\u2659 \u265F \u2655 \u265C"