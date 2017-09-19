require 'pry'

class Player

  attr_accessor :cards , :hands , :behavior, :money, :player_id, :name , :starting_money

  def initialize(character=nil)
    #binding.pry
    @player_id # Set up by game.rb loop
    @hands = []
    @insurance = 0

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

  def make_decision(options)
    q_make_decision(options)
  end

  def choice_handler(hand,i,choice)
    if choice == :hit
      hand.draw_card_from_deck
    elsif choice == :split
      split_hand_of_index(i)
    elsif choice == :double
      hand.wager *= 2
      hand.draw_card_from_deck
      hand.im_done = true
    elsif choice == :stand
      hand.im_done = true
    end
    if hand.score == :bust || hand.score == 21 || hand.score == :blackjack
      hand.im_done = true
    end
  end

  def get_dealt
    puts "Will #{@name} play this round?'"
    if @money >= $ante_size
      @wager = q_wager(money)
      new_hand
      hand[-1].wager = @wager
    end
  end

  def insurance?
    puts "Does #{name} want insurance? Put down #{@wager/2} to buy insurance. Get #{@wager} back if dealer reveals a blackjack. [y/n]"
    if q_insurance
      @insurance = @wager/2
      puts "Insurance purchased."
    else
      @insurance = 0
      puts "That's okay."
    end
  end



  def my_turn
    @hands.each_with_index {|hand,i|
      hand.define_options
      while !hand.im_done
        puts "Hand ##{i+1}: #{hand}"
        puts "Score: #{hand.score}\t Wager: #{hand.wager}"
        choice = make_decision(hand.options)
        choice_handler(hand,i,choice)
        hand.define_options
      end

      puts "\nHand Finished"
      puts "Hand ##{i+1}: #{hand} Results"
      puts "Score: #{hand.score}\t Wager: #{hand.wager}"
      gets
      if !@hands[i+1].nil?
        puts "\nNext Hand\n\n"
      end
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

  def insurance?
    @hands[0].cards[1].rank == :A
  end

end
