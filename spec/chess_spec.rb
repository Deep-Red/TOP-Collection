require "chess"

describe 'board' do 

	before :each do
		@test_game = Board.new
	end


	describe 'display' do
		context "given a board in the starting position"
		it "returns a board setup"

	end

	describe 'move_piece' do
		context "When a piece is moved"
		it "leaves the space the piece was moved from empty"
		@test_game.move_piece([1,1],[1,3])
		expect(@test_game.grid[0][0]).to eql nil
	end
end