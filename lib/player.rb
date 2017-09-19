require 'pry'

class Player

  attr_accessor :cards , :hands , :behavior, :money, :player_id, :name , :starting_money

  def initialize(character=nil)
    #binding.pry
    @player_id # Set up by game.rb loop
    @hands = []

    #binding.pry
    if character.class == Character
      #binding.pry
      @name = character.name
      @behavior = character.behavior
      @flavor_text = character.flavor_text
      @money = $ante_size*character.money
      @wager = $ante_size*character.wager
      @starting_money = @money
      #binding.pry

    elsif character == :human
      #binding.pry
      @behavior = character
      #binding.pry
    end
    #binding.pry
  end

  def human_properties
    #binding.pry
    @name = q_name(player_id)
    @money = q_money(@name)
    @starting_money = @money
    #binding.pry
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

  def discard_all_hands
    @hands.each { |hand| hand.discard_hand_into_deck}
  end

  def make_decision(hand)
  end

  def my_turn
    puts "#{@name}'s turn.'"
    @hands.each {|hand|
      puts hand
      make_decision(hand)
    }
  end

end

class Dealer < Player

  def initialize
    super
    new_hand
  end

  def new_hand
    @hands.push(Hand.new(nil,true))
  end

end
