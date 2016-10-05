require "chess"

describe 'board' do 

	before :all do
		@test_game = Board.new
	end


#	describe 'display' do
#		context "given a board in the starting position"
#		it "returns a board setup"
#
#	end

	describe 'move_piece' do
		context "When a piece is moved" do
			it "leaves the space the piece was moved from empty" do
				@test_game.move_piece([1,1],[2,1])
				expect(@test_game.grid[1][1]).to eq nil
			end
		end

		context "when a pawn makes it's first move" do
			it "can move two spaces" do
				@test_game.move_piece([6,3],[4,3])
				expect(@test_game.grid[4][3].type).to eq Pawn
			end
		end

		context "when a knight moves" do
			it "can 'jump' other pieces" do
				@test_game.move_piece([0,1],[2,2])
				expect(@test_game.grid[2][2].type).to eq Knight
			end
		end
		
		context "when a piece other than a knight moves" do
			it "cannot 'jump' other pieces" do
				@test_game.move_piece([7,2],[5,0])
	#			expect { @test_game.move_piece([7,2],[5,0]) }.to raise_error(NoMethodError)
				expect(@test_game.grid[5][0]).to eq nil
				expect(@test_game.grid[7][2].type).to eq Bishop
			end
		end

		context "when a king moves" do
			it "cannot move more than one space" do
				@test_game.move_piece([7,4],[5,2])
				expect(test_game.grid[5][2]).to eq nil
				expect(test_game.grid[7][4].type).to eq King
			end
		end

		context "when a king moves" do
			it "can move diagonally" do
				@test_game.move_piece([7,4],[6,3])
				expect(@test_game.grid[6][3].type).to eq King
			end
		end

	end

	describe 'display' do
		context "When \#display is called" do
			it "displays the current board setup in a human readable format" do
#				expect(STDOUT).to receive(:puts).with('   a  b  c  d  e  f  g  h  ')
				expect{@test_game.display}.to output.to_stdout
#				expect(output).to include '   a  b  c  d  e  f  g  h  '
			end
		end
	end

end
