require 'board'

describe 'Board' do
  context 'new' do
    it 'creates a new board with row and col size' do
      board = Board.new(5, 5)
      expect(board.grid.size).to eq 5
      expect(board.grid[0].size).to eq 5
    end
  end
  context '#plant_mines' do
    it 'randomize mines' do
      board = Board.new(5, 5)
      expect(board.plant_mines(10)).to eq 10
    end
  end

  context '#finish?' do
    it 'returns true when all sq open except M' do
      board = Board.new(2, 2)
      board.plant_mines(2)

      not_mine_sq = board.grid.select { |row, col| col.value != 'M' }
      not_mine_sq.each do |n|
        n[0].open = true
      end
      expect(board.finish?).to eq true
    end

    it 'returns false' do
      board = Board.new(2, 2)
      board.plant_mines(2)

      expect(board.finish?).to eq false
    end
  end
  # context '#display' do
  #   it 'displays the board' do
  #     board = Board.new(3, 3)
  #     expect(board.display(false)).to eq 
  #   end
  # end
end