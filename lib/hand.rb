class Hand

  include Comparable


# ObjectSpace._id2ref(s1.object_id)
  @@dealer_score = 0 # => The dealer's hand score.
  # @cards          # => Cards that are in this hand
  # @split_hand     # => Is this the original hand I was dealt or is it split?
  # @options = []   # => On this round what can I do?
  # @im_the_dealer # => True if this hand belongs to the dealer

  attr_accessor :cards , :score , :split_hand, :player_id

  SCORE_RANK = [:bust,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,:blackjack]

# first parameter is object_id of the player whose hand this is (there has to be a better way of doing this), the second arg
  def initialize(player_id, card_source = nil, dealers_hand=false)

    @options = []
    @doubled = false
    @split_hand = false
    @player_id = player_id

    if card_source == nil || card_source == @@deck# => if no arg given, draw from @@deck
      @cards = []
      2.times do
        draw_card_from_deck
      end
    elsif card_source.class == Hand
      card_source.split_hand = true
      @split_hand = true
      @cards = []
      @cards.push(card_source.cards.shift) # => To split a hand, initialize from another hand
    elsif card_source.class == Array # => Debug, create a hand with any cards
      @cards = card_source
    elsif card_source.class == Card
      @cards.push(card_source)
    end

    if dealers_hand
      @im_the_dealer = true
    else
      @im_the_dealer = false
    end

  end

  def hand_turn

    going = true
    @turn = 1
    while going
      define_options # => Determine the options
      if @options == [:stand] # => If stand is the only option, turn's over
        going = false
      end
      make_decision # => Make the decision based on options avail
      @turn += 1
      @options = [] # => reset options at the end of the sub_turn
      if @turn >= 100
        puts "STUCK ON HAND_TURN"
        going = false
      end
    end
    puts "Turn has ended"

  end

  def define_options

    # Find the total number of cards in this player's
    this_players_hand_count = ObjectSpace._id2ref(player_id).hands.length

    #start with the normal ones
    @options = [:stand, :hit, :double]

    #remove doubling if already doubled or already split
    if @split_hand || @doubled
      @options.delete(:double)
    end

    #add splitting if appropriate
    if @cards.length == 2 && @cards[0] == @cards[1] && this_players_hand_count < 4
      @options.push(:split)
    end

    #turn is over if 21, blackjack, bust, already doubled, or split aces
    if @score == 21 || @score == :blackjack || @score == :bust || @doubled || (@cards[0].rank==:A && @split_hand)
      @options = [:stand]
    end

  end

  #
  def draw_card_from_deck
    @cards.push(@@deck.cards.shift)
  end

  def discard_hand_into_deck
    @@deck.discards.push(@cards).flatten
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

# Comparisons will only be made to the dealer's hand
  def <=>(other)
    if SCORE_RANK.index(self.score) > SCORE_RANK.index(other.score)
      1
    elsif SCORE_RANK.index(self.score) == SCORE_RANK.index(other.score)
      0
    elsif SCORE_RANK.index(self.score) < SCORE_RANK.index(other.score)
      -1
    else
      raise BadScoreError
    end
  end

end
