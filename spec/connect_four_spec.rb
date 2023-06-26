require './lib/connect_four.rb'

describe ConnectFour do
    describe '#get_player1_name' do
        subject(:game) { described_class.new }

        context 'when it is used' do
            it 'gets the player1_name' do
                allow(game).to receive(:gets).and_return('john')
                expect(game.get_player1_name).to eq('john')
            end
        end
    end

    describe '#get_player2_name' do
        subject(:game) { described_class.new }

        context 'when it is used' do
            it 'gets the player2_name' do
                allow(game).to receive(:gets).and_return('Dan')
                expect(game.get_player2_name).to eq('Dan')
            end
        end
    end

    describe '#mark_cell' do
        subject(:game_marking) { described_class.new }

        context 'when it is player1 turn' do
            it "it marks all rows with 1" do
                expect{ game_marking.mark_cell(5, 1) }.to change { game_marking.row6 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '1', 'O', 'O'])
                expect{ game_marking.mark_cell(5, 1) }.to change { game_marking.row5 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '1', 'O', 'O'])
                expect{ game_marking.mark_cell(5, 1) }.to change { game_marking.row4 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '1', 'O', 'O'])
                expect{ game_marking.mark_cell(5, 1) }.to change { game_marking.row3 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '1', 'O', 'O'])
                expect{ game_marking.mark_cell(5, 1) }.to change { game_marking.row2 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '1', 'O', 'O'])
                expect{ game_marking.mark_cell(5, 1) }.to change { game_marking.row1 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '1', 'O', 'O'])
            end

            context 'when it is player2 turn' do
                it "it marks all rows with 2" do
                    expect{ game_marking.mark_cell(5, 2) }.to change { game_marking.row6 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '2', 'O', 'O'])
                    expect{ game_marking.mark_cell(5, 2) }.to change { game_marking.row5 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '2', 'O', 'O'])
                    expect{ game_marking.mark_cell(5, 2) }.to change { game_marking.row4 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '2', 'O', 'O'])
                    expect{ game_marking.mark_cell(5, 2) }.to change { game_marking.row3 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '2', 'O', 'O'])
                    expect{ game_marking.mark_cell(5, 2) }.to change { game_marking.row2 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '2', 'O', 'O'])
                    expect{ game_marking.mark_cell(5, 2) }.to change { game_marking.row1 }.from(['O', 'O', 'O', 'O', 'O', 'O', 'O']).to(['O', 'O', 'O', 'O', '2', 'O', 'O'])
                end
            end
        end
    end

    describe '#valid_input?' do
        subject(:game) { described_class.new }

        it 'returns true if it is valid' do
            expect(game.valid_input?('3')).to be true
        end

        it 'returns false if it is invalid' do
            expect(game.valid_input?('0')).to be false
            expect(game.valid_input?('lk')).to be false
        end
    end

    describe '#input' do
        subject(:game) { described_class.new }

        context 'when user inputs an incorrect value once, then a valid input' do
            before do
                letter = 'k'
                valid_input = '3'
                allow(game).to receive(:gets).and_return(letter, valid_input)
            end

            it 'outputs an error once' do
                expect(game).to receive(:puts).with('Introduce a value between 1 to 7').once 
                game.input
            end

        end

        context 'when user inputs an incorrect value twice, than a valid input' do
            before do
                letter = 'k'
                symbol = '@'
                valid_input = '2'
                allow(game).to receive(:gets).and_return(letter, symbol, valid_input)
            end

            it 'outputs an error twice' do
                expect(game).to receive(:puts).with('Introduce a value between 1 to 7').twice
                game.input
            end
        end

        context 'when user inputs an incorrect value thrice, than a valid input' do
            before do
                letter = 'k'
                symbol = '@'
                word = 'hello'
                valid_input = '7'
                allow(game).to receive(:gets).and_return(letter, symbol, word, valid_input)
            end

            it 'outputs and error thrice' do
                expect(game).to receive(:puts).with('Introduce a value between 1 to 7').thrice
                game.input
            end
        end

        context 'when user input is valid' do

            it 'stops the loop and does not display an error message' do 
                valid_input = '7'
                allow(game).to receive(:gets).and_return(valid_input)
                expect(game).not_to receive(:puts).with('Introduce a value between 1 to 7')
                game.input
            end
        end
    end

    describe '#check_winner' do
        subject(:game) {described_class.new}

        context 'when it is a row' do
           
            it 'returns true' do
                game.row1 = ['O', '1', '1', '1', '1', 'O', 'O']
                expect(game.check_winner).to be true
            end

            it 'does not return true if partial row' do
                game.row1 = ['O', 'O', 'O', '1', '1', 'O', 'O']
                expect(game.check_winner).to_not be true
            end
        end

        context 'when it is a column' do
            before do
                game.row1 = ['O', 'O', '2', 'O', 'O', 'O', 'O']
                game.row2 = ['O', 'O', '2', 'O', 'O', 'O', 'O']
                game.row3 = ['O', 'O', '2', 'O', 'O', 'O', 'O']
                game.row4 = ['O', 'O', '2', 'O', 'O', 'O', 'O']
            end
           
            it 'returns true' do
                expect(game.check_winner).to be true
            end
        end

        context 'when it is a partial column' do
            before do
                game.row1 = ['O', 'O', '2', 'O', 'O', 'O', 'O',]
                game.row2 = ['O', 'O', '2', 'O', 'O', 'O', 'O',]
                game.row3 = ['O', 'O', '2', 'O', 'O', 'O', 'O',]
            end
           
            it 'does not return true' do
                expect(game.check_winner).to_not be true
            end
        end

        context 'when it is a diagonal' do
            before do
                game.row1 = ['O', 'O', '2', 'O', 'O', 'O', 'O',]
                game.row2 = ['O', 'O', 'O', '2', 'O', 'O', 'O',]
                game.row3 = ['O', 'O', 'O', 'O', '2', 'O', 'O',]
                game.row4 = ['O', 'O', 'O', 'O', 'O', '2', 'O',]
            end
           
            it 'returns true' do
                expect(game.check_winner).to be true
            end
        end

        context 'when it is a partial diagonal' do
            before do
                game.row1 = ['O', 'O', '2', 'O', 'O', 'O', 'O',]
                game.row2 = ['O', 'O', 'O', '2', 'O', 'O', 'O',]
                game.row3 = ['O', 'O', 'O', 'O', '1', 'O', 'O',]
                game.row4 = ['O', 'O', 'O', 'O', 'O', '2', 'O',]
            end
           
            it 'does not return true' do
                expect(game.check_winner).to_not be true
            end
        end
    end
end
