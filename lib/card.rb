class Card

  include Comparable

  RANKS = [:A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K]
  FACE_CARDS = [:J,:Q,:K]
  SUITS = [:clubs, :diamonds, :hearts, :spades]

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def greater_than?(other)
    RANKS.index(self.rank) > RANKS.index(other.rank)
  end

  # Comparison for splitting purposes
  def <=> (other)
    if FACE_CARDS.include?(self.rank) && FACE_CARDS.include?(other.rank)
      0
    elsif RANKS.index(self.rank) == RANKS.index(other.rank)
      0
    elsif RANKS.index(self.rank) > RANKS.index(other.rank)
      1
    elsif RANKS.index(self.rank) < RANKS.index(other.rank)
      -1
    else
      raise BadScoreError
    end
  end

  # def ==(other)
  #   self.rank == other.rank && self.suit == other.suit
  # end



end

def to_s
  "#{self.rank} of #{self.suit}"
end
