require "chess"

describe 'board' do

	before :all do
		@test_game = Board.new
	end

	before :each do
		@test_game.increment_turn
		@test_game.current_player
	end

	describe 'move_piece' do
		context "When a piece is moved" do
			it "leaves the space the piece was moved from empty" do
				expect(@test_game.can_it_move?([6,1],[5,1])).to be true
				@test_game.move_piece([6,1],[5,1])
				expect(@test_game.grid[6][1]).to eq nil
				expect(@test_game.grid[5][1].type).to eq "pawn"
			end
		end
	end

	describe 'can_it_move?' do
		context "when a pawn makes it's first move" do
			it "can move two spaces" do
				expect(@test_game.can_it_move?([1,3],[3,3])).to be true
				@test_game.move_piece([1,3],[3,3])
				expect(@test_game.grid[3][3].type).to eq "pawn"
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
				expect(@test_game.can_it_move?([1,2],[3,0])).to be false
			end
		end

		context "when a king moves" do
			it "cannot move more than one space" do
				expect(@test_game.can_it_move?([0,4],[2,2])).to be false
			end
		end

		context "when a king moves" do
			it "can move diagonally" do
				expect(@test_game.can_it_move?([0,4],[1,3])).to be true
			end
		end
	end

	describe 'castling' do
		before :each do
			@test_game.grid[0][1] = nil
			@test_game.grid[0][2] = nil
			@test_game.grid[0][3] = nil
		end

		context "when a king castles" do
			it "is interpreted as a legal move" do
				puts @test_game.display
				expect(@test_game.can_it_move?([0,4],[0,2])).to be true
			end
		end
	end

	describe 'display' do
		context "When \#display is called" do
			it "displays the current board setup in a human readable format" do
				expect{@test_game.display}.to output.to_stdout
#				expect(output).to include '   a  b  c  d  e  f  g  h  '
			end
		end
	end

end
