require_relative 'square'

class Board
  MINE_VALUE = 'M'
  AROUND = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]]

  def initialize(row, col)
    @grid = Array.new(row) { Array.new(col) }
    id = 0
    for i in 0..row-1 do
      for j in 0..col-1 do
        sq = Square.new(id, nil)
        @grid[i][j] = sq
        id += 1
      end
    end
  end

  def grid
    @grid
  end

  def row_size
    @grid.size
  end

  def col_size
    @grid[0].size
  end

  def plant_mines(number)
    @mine_count = number
    rn = Random.new
    number.times do |i|
      row = rn.rand(0..row_size-1)
      col = rn.rand(0..col_size-1)
      @grid[row][col].value = MINE_VALUE
    end
  end

  def valid_square?(row, col)
    if row >= 0 && row < row_size && col >= 0 && col < col_size
      return true
    end
    return false
  end

  def assign_mine_counts
    for row in 0..row_size-1 do
      for col in 0..col_size-1 do
        sq = @grid[row][col]
        next if sq.value == MINE_VALUE

        sum_mine = 0

        AROUND.each do |r, c|
          rr = row + r
          cc = col + c
          if valid_square?(rr, cc) && @grid[rr][cc].value == MINE_VALUE
            sum_mine += 1
          end
        end

        sq.value = sum_mine.to_s if sum_mine > 0
      end
    end
  end

  def open_around_dfs(row, col)
    return if !@grid[row][col].value.nil?

    AROUND.each do |r, c|
      if valid_square?(row+r, col+c) && !@grid[row+r][col+c].open?
        @grid[row+r][col+c].open = true
        open_around_dfs(row+r, col+c)
      end
    end
  end

  def open_around_bfs(row, col)
    que = []
    que.push([row, col]) if @grid[row][col].value.nil?
    while !que.empty? do
      row, col = que.pop()
      AROUND.each do |r, c|
        if valid_square?(row+r, col+c) && !@grid[row+r][col+c].open?
          @grid[row+r][col+c].open = true
          que.push([row+r, col+c]) if @grid[row+r][col+c].value.nil?
        end
      end  
    end
  end

  def play(id)
    for row in 0..row_size-1 do
      for col in 0..col_size-1 do
        if @grid[row][col].id == id
          sq = @grid[row][col]
          sq.open = true
          if sq.value == MINE_VALUE
            return 'Boom!'
          else
            open_around_bfs(row, col)
            return 'Ok!'
          end
        end
      end
    end
    return 'ID not found.  Please enter valid id.'
  end
  
  def finish?
    @mine_count == @grid.flatten.count { |sq| !sq.open? }
  end

  def display(open_all = false)
    for row in 0..row_size-1 do
      puts "\n"
      for col in 0..col_size-1 do
        sq = @grid[row][col]
        sq.display(open_all)
      end
      print '|'
    end
    puts "\n"
  end
end