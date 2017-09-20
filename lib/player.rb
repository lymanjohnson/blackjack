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
    new_hand.wager = hand.wager
    @hands.push(new_hand)
    hand.draw_card_from_deck
    @money -= hand.wager
  end

  def discard_all_hands
    @hands.each(&:discard_hand_into_deck)
    @hands=[]
  end

#this method exists because Dealer and AI players will
#overwrite it with their own algorithms
  def make_decision(options,hand_index)
    q_make_decision(options,hand_index,possessive)
  end

  def choice_handler(hand, i, choice)
    if choice == :hit
      hand.draw_card_from_deck
    elsif choice == :split
      split_hand_of_index(i)
    elsif choice == :double
      @money -= hand.wager
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
    message = ""
    puts message
    $players.length == 1 ? wants_to_play = true : wants_to_play = q_playing_this_round(@name)
    if @money >= $ante_size && wants_to_play
      @wager = q_wager(name,money).to_i
      @money -= @wager
      new_hand
      hands[-1].wager = @wager
    end
  end

  def insurance?
    if q_insurance(@name,@wager)
      @insurance = @wager / 2
      @money -= @insurance
      puts 'Insurance purchased.'
    else
      @insurance = 0
      puts "That's okay."
    end
  end

  def possessive
    poss = @name +"'s"
    poss = "Your" if @name == "You"
    return poss
  end

  def my_turn

    @hands.each_with_index do |hand, _i|
      hand.define_options
      until hand.im_done
        puts "#{possessive} Hand ##{_i+1}: #{hand}"
        # puts "Score: #{hand.score}\t Wager: #{hand.wager}"
        choice = make_decision(hand.options,_i)
        choice_handler(hand, _i, choice)
        hand.define_options
      end
      status_bar
      puts "Dealer hit blackjack!" if $dealer_hand.score == :blackjack
      puts "#{possessive} Hand ##{_i+1} Finished \n\nPress <enter> to continue"
      gets
      puts "\nNext Hand\n\n" unless @hands[_i + 1].nil?
    end
  end

  def reset
    discard_all_hands
    @insurance = 0
  end

  def did_i_win
    @hands.each_with_index do |hand, _i|
      status_bar
      if hand > $dealer_hand
        puts "#{possessive} Hand ##{_i+1} beats dealer's hand!"
        @money += hand.wager * 2
        if hand.score == :blackjack
          puts 'Blackjack gets extra money!'
          @money += hand.wager/2
        end
      elsif hand == $dealer_hand && hand.score == :blackjack
        puts "#{possessive} Hand ##{_i+1} ties against the dealer's hand. Wager returned to #{@name}"
        @money += hand.wager
      elsif hand < $dealer_hand
        puts "#{possessive} Hand ##{_i+1} loses."
      elsif hand.score == :bust
        puts "#{possessive} Hand ##{_i+1} busts."
      end
      puts "\nPress <enter> to continue."
      gets
    end
  end
end

class Dealer < Player
  def initialize
    super
  end

  def new_hand
    $dealer_hand = Hand.new(nil, true)
    $dealer_hand.score = ""
    $hole_card = $dealer_hand.cards[0]
    $up_card = $dealer_hand.cards[1]
    @hands.push($dealer_hand)
    @im_done = false
  end

  def insurance?
    $up_card.rank == :A
  end

  def my_turn
    @hands.each do |hand|
      # binding.pry
      until @im_done
        status_bar
        if hand.score == :bust
          # binding.pry
          puts "#{@name} busts."
          puts "\nPress <enter> to continue."
          gets
          @im_done = true
        elsif hand.score == :blackjack
          puts "#{@name} finishes with blackjack."
          puts "\nPress <enter> to continue."
          gets
          @im_done = true
        elsif (hand.score <= 16 || hand.soft_seventeen?)
          # binding.pry
          hand.draw_card_from_deck
          puts "#{@name} draws #{hand.cards[-1]} from deck."
          puts "\nPress <enter> to continue."
          gets
          # puts "Their score is now #{hand.score}\n"
        else
          # binding.pry
          if hand.soft_seventeen?
            "#{@name} finishes with a hard seventeen."
          else
            puts "#{@name} finishes with a #{hand.score}."
          end
          puts "\nPress <enter> to continue."
          gets
          @im_done = true
        end

      end
    end
  end
end
