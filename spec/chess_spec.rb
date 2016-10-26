require "chess"

describe 'board' do

	before :all do
		@test_game = Board.new
	end

	before :each do
		@test_game.increment_turn
		@test_game.set_player
	end


#	describe 'display' do
#		context "given a board in the starting position"
#		it "returns a board setup"
#
#	end

	describe 'move_piece' do
		context "When a piece is moved" do
			it "leaves the space the piece was moved from empty" do
#				puts grid[from[0]][from[1]].type
				puts "HI #{@test_game.set_player}"
				puts "THERE #{@test_game.grid[1][1].player} #{@test_game.grid[6][6].player}"
				expect(@test_game.can_it_move?([1,1],[2,1])).to be true
				@test_game.move_piece([1,1],[2,1])
				expect(@test_game.grid[1][1]).to eq nil
				expect(@test_game.grid[2][1].type).to eq "pawn"
			end
		end
	end

	describe 'can_it_move?' do
		context "when a pawn makes it's first move" do
			it "can move two spaces" do
				expect(@test_game.can_it_move?([6,3],[4,3])).to be true
				@test_game.move_piece([6,3],[4,3])
				expect(@test_game.grid[4][3].type).to eq "pawn"
			end
		end

		context "when a knight moves" do
			it "can 'jump' other pieces" do
				expect(@test_game.can_it_move?([0,1],[2,2])).to be true
				@test_game.move_piece([0,1],[2,2])
				expect(@test_game.grid[2][2].type).to eq "knight"
			end
		end

		context "when a piece other than a knight moves" do
			it "cannot 'jump' other pieces" do
				expect(@test_game.can_it_move?([7,2],[5,0])).to be false
	#			@test_game.move_piece([7,2],[5,0])
	#			expect { @test_game.move_piece([7,2],[5,0]) }.to raise_error(NoMethodError)
	#			expect(@test_game.grid[5][0]).to eq nil
	#			expect(@test_game.grid[7][2].type).to eq "bishop"
			end
		end

		context "when a king moves" do
			it "cannot move more than one space" do
				expect(@test_game.can_it_move?([7,4],[5,2])).to be false
#				@test_game.move_piece([7,4],[5,2])
#				expect(test_game.grid[5][2]).to eq nil
#				expect(test_game.grid[7][4].type).to eq "king"
			end
		end

		context "when a king moves" do
			it "can move diagonally" do
				expect(@test_game.can_it_move?([7,4],[6,3])).to be true
#				@test_game.move_piece([7,4],[6,3])
#				expect(@test_game.grid[6][3].type).to eq "king"
			end
		end
	end

	describe 'castling' do
		before :each do
			@test_game.grid[0][1] = nil
			@test_game.grid[0][2] = nil
		end

		context "when a king castles" do
			it "occupies the proper square" do

			end
		end
	end

	describe 'display' do
		context "When \#display is called" do
			it "displays the current board setup in a human readable format" do
#				expect(STDOUT).to receive(:puts).with('   a  b  c  d  e  f  g  h  ')
#				puts @test_game.display
				expect{@test_game.display}.to output.to_stdout
#				expect(output).to include '   a  b  c  d  e  f  g  h  '
			end
		end
	end

end
