class Card
  RANKS = [:A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K]
  SUITS = [:clubs, :diamonds, :hearts, :spades]

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def greater_than?(other)
    RANKS.index(self.rank) > RANKS.index(other.rank)
  end

  def ==(other)
    self.rank == other.rank && self.suit == other.suit
  end
end
