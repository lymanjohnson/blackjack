class Hand

  @cards
  @@dealer_score
  @split_hand

  attr_accessor :cards , :score

  def initialize(arg)
    if arg.class == Deck
      @split_hand = false
      @cards = []
      2.times do
        draw_card_from(arg)
      end

    elsif arg.class == Hand
      @split_hand = true
      @cards = []
      @cards.push(arg.cards.shift) # => To split a hand, initialize from another hand
    end
  end

  #
  def draw_card_from(deck)
    @cards.push(deck.cards.shift)
  end

  def discard_hand_into(deck)
    deck.discards.push(@cards.shift)
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

    # Special: determine if it's a blackjack, a bust, or a regular 21
    if aces_count == 1 && value == 21 && !@split_hand
      value = :blackjack
    elsif value > 21
      value = :bust
    end
    return value
  end

end
