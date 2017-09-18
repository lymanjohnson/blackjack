
class Player
  @@ante_size = 10
  attr_accessor :cards , :hands , :behavior, :money, :player_id

  def initialize(character)
    @player_id = :player1 # => TODO Placeholder, change this later!!
    @hands = []
    unless character
      raise ArgumentError.new("Must feed a character object or :human")
    end

    if character == :human
      @name = q_name
      @money = q_money
      @behavior = :human

    else
      @name = character.name
      @behavior = character.behavior
      @flavor_text = character.flavor_text

      @money = @@ante_size*character.money
      @wager = @@ante_size*character.wager
    end
  end

  # Pulls two cards from a deck to create a new hand
  def new_hand(card_source=nil,dealers_hand=nil)
    newhand = Hand.new(card_source,dealers_hand)
    newhand.player_id = @player_id
    @hands.push(newhand)
  end

  # Takes one of the player's existing hands and splits it into two
  def split_hand_of_index(hand_index)
    hand = @hands[hand_index]
    hand.split_hand = true
    new_hand = Hand.new(hand)
    new_hand.player_id = @player_id
    new_hand.split_hand = true
    @hands.push(new_hand)
    hand.draw_card_from_deck
  end

end
