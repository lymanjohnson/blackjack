
class Hand
  include Comparable

  # ObjectSpace._id2ref(s1.object_id)
  # @cards          # => Cards that are in this hand
  # @split_hand     # => Is this the original hand I was dealt or is it split?
  # @options = []   # => On this round what can I do?
  # @im_the_dealer # => True if this hand belongs to the dealer

  attr_accessor :cards, :score, :split_hand, :player_id, :options, :im_done, :wager, :money

  SCORE_RANK = [:bust, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, :blackjack].freeze

  # first parameter is object_id of the player whose hand this is (there has to be a better way of doing this), the second arg
  def initialize(card_source = nil, dealers_hand = false)
    @wager = $ante_size # TODO: Make this definable by player
    @options = []
    @doubled = false
    @split_hand = false

    if card_source.nil?
      @cards = []
      2.times do
        draw_card_from_deck
      end


    elsif card_source.class == Hand
      @cards = []
      @cards.push(card_source.cards.shift) # => To split a hand, initialize from another hand
      draw_card_from_deck


    elsif card_source.class == Array # => Debug, create a hand with any cards
      @cards = card_source

    elsif card_source.class == Card
      @cards.push(card_source)
    end

    @im_the_dealer = dealers_hand
  end


  def soft_seventeen?
    @cards.any?{|card| card.rank == :A} && score == 17 && $hit_on_soft_seventeen
  end

  def define_options

    my_player = $players.find {|player| player.player_id == @player_id }
    @money = my_player.money
    @my_players_hand_count = my_player.hands.length

    # start with the normal ones
    @options = %i[stand hit double]

    # remove doubling if out of money or if already doubled, hit, or split
    @options.delete(:double) if @split_hand || @doubled || @cards.length > 2 || @wager > @money

    # add splitting if appropriate and sufficient money
    if @cards.length == 2 && @cards[0] == @cards[1] && @my_players_hand_count < 4 && @money >= @wager
      @options.push(:split)
    end

    # turn is over if 21, blackjack, bust, already doubled, or split aces
    if score == 21 || score == :blackjack || score == :bust || @doubled || (@cards[0].rank == :A && @split_hand)
      @options = [:stand]
    end
    @options
  end

  #
  def draw_card_from_deck
    @cards.push($deck.cards.shift)
  end

  def discard_hand_into_deck
    @cards.each do |card|
      $deck.discards.push(card)
    end
    @cards = []
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
      # #binding.pry
    end

    if aces_count > 0
      # => There is no circumstance under which you'll count more than one ace as 11
      if 11 + (aces_count - 1) + value > 21 # => If counting one of the aces will put you over 21, don't count any of them as 11
        value += aces_count
      else
        # => otherwise, count one of them as 11 and the rest as 1
        value += 11 + aces_count - 1
      end
    end

    # Special: determine if it's a blackjack, a bust, or a regular 21
    if @cards.length == 2 && value == 21 && !@split_hand
      value = :blackjack
    elsif value > 21
      value = :bust
    end
    value
  end

  def to_s
    s = ''
    @cards.each { |card| s += " #{card} " }
    s[0...-1]
  end

  # Comparisons can be made between two hands, or between a hand and a raw score
  def <=>(other)
    my_score = score
    if other.class == Hand
      other_score = other.score
      if SCORE_RANK.index(my_score) > SCORE_RANK.index(other_score)
        1
      elsif SCORE_RANK.index(my_score) == SCORE_RANK.index(other_score)
        0
      elsif SCORE_RANK.index(my_score) < SCORE_RANK.index(other_score)
        -1
      end

    else #if other.is_a?(Integer) || other.is_a?(Float) || other.is_a?(Symbol)
      if SCORE_RANK.index(my_score) > SCORE_RANK.index(other)
        1
      elsif SCORE_RANK.index(my_score) == SCORE_RANK.index(other)
        0
      elsif SCORE_RANK.index(my_score) < SCORE_RANK.index(other)
        -1
      end
    end
  end
end
