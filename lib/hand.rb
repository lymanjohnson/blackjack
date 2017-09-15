class Hand

  @cards
  @@dealer_score

  attr_accessor :cards , :score

  def initialize(deck)
    @cards = []
    2.times do
      @cards.push(deck.cards.shift)
    end
  end

  def score
    value = 0
    aces_count = 0
    @cards.each do |card|
      if card.rank == :K || card.rank == :Q || card.rank == :J
        value += 10
      elsif card.rank == :A
        aces_count += 1
      else
        value += card.rank
      end
    end

    if aces_count > 0
      # => There is no circumstance under which you'll count more than one ace as 11
      if (11+(aces_count-1)+value>21) # => If counting one of the aces will put you over 21, don't count any of them as 11
        value += aces_count
      else
        # => otherwise, count one of them as 11 and the rest as 1
        value += 11 + aces_count - 1
      end
    end
    return value
  end

end
