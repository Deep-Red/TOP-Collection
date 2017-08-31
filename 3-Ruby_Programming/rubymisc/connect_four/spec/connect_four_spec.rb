require "connect_four"

describe 'board' do

	before :each do
		@game = Board.new
	end

	it 'should be empty at start' do
		expect(@game.grid).to eq [['empty']*6]*7
	end

	describe 'piece behavior' do
		context 'when the piece is the first in the column' do
			it 'should be in the first slot of the correct column' do
				@game.place_piece(0, 'red')
				expect(@game.grid).to eq [["\u25C9"]+['empty']*5]+[['empty']*6]*6
			end
		end

		context 'when the piece is not the first piece in the column' do
			it 'should be above an existing piece in the column' do
				@game.place_piece(0, 'red')
				@game.place_piece(0, 'black')
				expect(@game.grid).to eq [["\u25C9", "\u25CE"]+['empty']*4]+[['empty']*6]*6
			end
		end

		context 'when there are already the max number of pieces in a column' do
			it 'should be unable to be placed in the column' do
				6.times { @game.place_piece(0, 'red') }
				expect(@game.place_piece(0, 'red')).to be false
			end
		end
	end

	describe 'game status behavior' do 
		
		context 'when there are only three pieces in a row' do
			it 'should not be game over' do
				3.times { @game.place_piece(0, 'black') }
				expect(@game.game_over?).to be false
			end
		end

		context 'when there are four pieces in a row vertically' do
			it 'should be game over if they are the same color' do
				4.times { @game.place_piece(3, 'black') }
				expect(@game.game_over?).to be true
			end

			it 'shouldn\'t be game over if they are not the same color' do
				3.times { @game.place_piece(3, 'black') }
				@game.place_piece(3, 'red')
				expect(@game.game_over?).to be false
			end
		end

		context 'when there are four pieces in a row horizontally' do
			it 'should be game over if they are the same color' do
				@game.place_piece(0, 'red')
				@game.place_piece(1, 'red')
				@game.place_piece(2, 'red')
				@game.place_piece(3, 'red')
				expect(@game.game_over?).to be true
			end

			it 'shouldn\'t be game over if they are not the same color' do
				@game.place_piece(0, 'red')
				@game.place_piece(1, 'black')
				@game.place_piece(2, 'red')
				@game.place_piece(3, 'black')
				expect(@game.game_over?).to be false
			end
		end

		context 'when there are four pieces in a row diagonally' do
			it 'matches in a right diagonal pattern' do 
				@game.place_piece(0, 'red')
				@game.place_piece(1, 'black')
				@game.place_piece(1, 'red')
				@game.place_piece(2, 'black')
				@game.place_piece(2, 'red')
				@game.place_piece(2, 'red')
				@game.place_piece(3, 'red')
				@game.place_piece(3, 'black')
				@game.place_piece(3, 'black')
				@game.place_piece(3, 'red')

				expect(@game.game_over?).to be true
			end

			it 'matches in a left diagonal direction' do
				@game.place_piece(6, 'red')
				@game.place_piece(5, 'black')
				@game.place_piece(5, 'red')
				@game.place_piece(4, 'black')
				@game.place_piece(4, 'red')
				@game.place_piece(4, 'red')
				@game.place_piece(3, 'red')
				@game.place_piece(3, 'black')
				@game.place_piece(3, 'black')
				@game.place_piece(3, 'red')
			end
		end
	end
end

describe 'players' do
	
	before :all do
		@players = Players.new('Black Player', 'Red Player')
		@turns = Turns.new(@players)
	end

	it 'should return the red player name on the even turns' do
		expect(@turns.return_player).to eq 'Red Player'
	end

	it 'should return the black player name on odd turns' do
		@turns.increment
		expect(@turns.return_player).to eq 'Black Player'
	end
end