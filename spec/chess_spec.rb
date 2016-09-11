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
	end
end