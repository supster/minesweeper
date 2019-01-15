class Mine
  def self.random_mines(board, number)
    rn = Random.new
    number.times do
      row = rn.rand(0..board.row-1)
      col = rn.rand(9..boad.col-1)
      board.plant_mine(row, col)
    end
  end
end