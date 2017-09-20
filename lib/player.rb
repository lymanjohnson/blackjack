require 'pry'

class Player
  attr_accessor :cards, :hands, :behavior, :money, :player_id, :name, :starting_money , :insurance

  def initialize(character = nil)
    @hands = []
    @insurance = 0

    if character.class == Character
      @name = character.name
      @behavior = character.behavior
      @flavor_text = character.flavor_text
      @money = $ante_size * character.money
      @wager = $ante_size * character.wager
      @starting_money = @money

    elsif character == :human
      @behavior = character
    end
  end

  def human_properties
    @name = q_name(player_id)
    @money = q_money(@name)
    @starting_money = @money
  end

  # Pulls two cards from a deck to create a new hand
  def new_hand(card_source = nil, dealers_hand = nil)
    newhand = Hand.new(card_source, dealers_hand)
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
    @hands.each(&:discard_hand_into_deck)
    @hands=[]
  end

  def make_decision(options)
    q_make_decision(options)
  end

  def choice_handler(hand, i, choice)
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
    #clean
    message = "The dealer is ready to play. "
    message = "The deck is freshly shuffled and the dealer is ready to play." if $deck.cards.length == 52
    puts message
    puts "\nWill #{@name} be playing this round?"
    if @money >= $ante_size
      @wager = q_wager(money).to_i
      @money -= @wager
      new_hand
      hands[-1].wager = @wager
    end
  end

  def insurance?
    puts "Does #{name} want insurance? Put down #{@wager / 2} to buy insurance. Get #{@wager} back if dealer reveals a blackjack. [y/n]"
    if q_insurance
      @insurance = @wager / 2
      @money -= @insurance
      puts 'Insurance purchased.'
    else
      @insurance = 0
      puts "That's okay."
    end
  end

  def my_turn
    @hands.each_with_index do |hand, i|
      hand.define_options
      until hand.im_done
        puts "Hand ##{i + 1}: #{hand}"
        puts "Score: #{hand.score}\t Wager: #{hand.wager}"
        choice = make_decision(hand.options)
        choice_handler(hand, i, choice)
        hand.define_options
      end

      puts "\nHand Finished"
      puts "Hand ##{i + 1}: #{hand} Results"
      puts "Score: #{hand.score}\t Wager: #{hand.wager}"
      gets
      puts "\nNext Hand\n\n" unless @hands[i + 1].nil?
    end
  end

  def reset
    discard_all_hands
    @insurance = 0
  end

  def did_i_win
    @hands.each_with_index do |hand, _i|
      if hand > $dealer_hand
        puts "#{hand} beats dealer's hand!"
        @money += hand.wager * 2
        if hand.score == :blackjack
          puts 'Blackjack gets extra money!'
          @money += hand.wager
        end
      elsif hand == $dealer_hand && hand.score != :bust
        puts "Hand ##{_i} ties against dealer_hand. Wager returned to #{@name}"
        @money += hand.wager
      elsif hand < $dealer_hand
        puts "Hand ##{_i} loses."
      end
    end
  end
end

class Dealer < Player
  def initialize
    super
  end

  def new_hand
    $dealer_hand = Hand.new(nil, true)
    $hole_card = $dealer_hand.cards[1]
    $up_card = $dealer_hand.cards[1]
    @hands.push($dealer_hand)
  end

  def insurance?
    $up_card.rank == :A
  end

  def my_turn
    @hands.each do |hand|
      until @im_done

        if (hand <= 16 || hand.soft_seventeen?) && hand != :bust
          hand.draw_card_from_deck
          puts "#{@name} draws #{hand.cards[-1]} from deck."
          puts "Their score is now #{hand.score}\n"
        else
          @im_done = true
        end

      end
    end
  end
end
