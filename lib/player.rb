require 'pry'

class Player
  attr_accessor :cards, :hands, :money, :player_id, :name, :starting_money , :insurance, :ante_modifier, :flavor_text, :wager

  def initialize
    @hands = []
    @insurance = 0
  end

  def human_properties
    @name = q_name(player_id)
    @money = q_money(@name)
    @starting_money = @money
    @flavor_text = "A human player. That's you."
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

  def playing_this_round
    q_playing_this_round(@name)
  end

  def my_wager
    #
    q_wager(name,money).to_i
  end

  def get_dealt
    message = ""
    puts message
    $players.length == 1 ? wants_to_play = true : wants_to_play = playing_this_round
    if @money >= $ante_size && wants_to_play
      #
      @wager = my_wager
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

class Randomplayer < Player

  def make_decision(options,hand_index)
    status_bar
    puts "#{name}'s turn"
    gets
    choice = options.sample
    status_bar
    puts "#{name} decided to #{choice.to_s.downcase.tr(":","")}"
    gets
    return choice
  end

  def my_wager
    #
    rand($ante_size...@money/2)
  end

  def insurance?
    if @money > @wager/2 || rand(2) == 1
      @insurance = @wager / 2
      @money -= @insurance
      puts "#{name} buys insurance."
    else
      @insurance = 0
      puts "#{name} does not buy insurance"
    end
    gets
  end

  def playing_this_round
    $ante_size<@money
  end

end


class Roboplayer < Player

  def initialize
    super
    @risk_tolerance = 17
  end

  def make_decision(options,hand_index)
    status_bar
    puts "#{name}'s turn"
    gets
    if @hands[hand_index].score == :blackjack || @hands[hand_index].score == :bust
      choice = :stand
    elsif @hands[hand_index].score < @risk_tolerance
      choice = :hit
    else
      choice = :stand
    end
    status_bar
    puts "#{name} decided to #{choice.to_s.downcase.tr(":","")}"
    gets
    return choice
  end

  def my_wager
    max = $ante_size*@ante_modifier
    (max = @money) if @money < max
    rand($ante_size...(max))
  end

  def insurance?
    @insurance = 0
    puts "#{name} does not buy insurance"
    gets
  end

  def playing_this_round
    $ante_size<@money
  end
end

class Psychicplayer < Roboplayer
  def make_decision(options,hand_index)
    status_bar
    choice = :stand
    puts "#{name}'s turn"
    gets
    array = []
    @hands[hand_index].cards.each do |card|
      array.push(card)
    end
    array.push($deck.cards[0])
    virtual_hand = Hand.new(array)
    #binding.pry
    if @hands[hand_index] == :blackjack || @hands[hand_index] > virtual_hand
      choice = :stand
    elsif (virtual_hand == :blackjack || virtual_hand > 20) && options.include?(:double)
      choice = :double
      #binding.pry
    elsif virtual_hand == :bust
      choice = :stand
      #binding.pry
    elsif options.include?(:split)
      choice = :split
      #binding.pry
    else
      choice = :hit
      #binding.pry
    end
    #binding.pry
    status_bar
    puts "#{name} decided to #{choice.to_s.downcase.tr(":","")}"
    gets
    return choice
  end
end

class Riskyplayer <Roboplayer
  def initialize
    super
    @risk_tolerance = 19
  end

  def my_wager
    #
    rand($ante_size...@money/3)
  end
end

class Dealer < Player

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
      # #
      until @im_done
        status_bar
        if hand.score == :bust
          # #
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
          # #
          hand.draw_card_from_deck
          puts "#{@name} draws #{hand.cards[-1]} from deck."
          puts "\nPress <enter> to continue."
          gets
          # puts "Their score is now #{hand.score}\n"
        else
          # #
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
