class Card
  include Comparable

  RANKS = [:A, 2, 3, 4, 5, 6, 7, 8, 9, 10, :J, :Q, :K].freeze
  FACE_CARDS = %i[J Q K].freeze
  SUITS = %i[clubs diamonds hearts spades].freeze

  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def greater_than?(other)
    RANKS.index(rank) > RANKS.index(other.rank)
  end

  # Comparison for splitting purposes
  def <=>(other)
    if FACE_CARDS.include?(rank) && FACE_CARDS.include?(other.rank)
      0
    elsif RANKS.index(rank) == RANKS.index(other.rank)
      0
    elsif RANKS.index(rank) > RANKS.index(other.rank)
      1
    elsif RANKS.index(rank) < RANKS.index(other.rank)
      -1
    end
  end
end

def to_s
  "#{rank} of #{suit}"
end
