require 'square'

describe 'Square' do
  context '#value' do
    it 'responds to value' do
      sq = Square.new(0, 'M')
      expect(sq.value).to eq('M')
    end
  end

  context '#open' do
    it 'default to false' do
      sq = Square.new(0, 'M')
      expect(sq.open?).to be(false)
    end
  end
end