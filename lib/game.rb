# Dir["./*.rb"].each {|file| require file}
#
class Game
  attr_accessor :on, :play_round , :stop_game

  def initialize

    @on = true
    $deck = Deck.new(1)
    $resplit_aces = true
    $hit_on_soft_seventeen = true
    $double_after_split = true
    $offer_insurance = true
    $ante_size = float_of_2_decimal(10)
    $number_of_split_hands = 4
    $number_of_humans = 1
    $dealer = Dealer.new
    $dealer.name = "The dealer"
    $players = []
    $discards_visible = true
    $show_dealers_cards_now = false
    $shuffle_every_turn = false

    # These variables are the max that the player is allowed to set in custom rules
    $max_allowable_decks = 5
    $max_allowable_humans = 4
    $max_allowable_split_hands = 4
    $max_allowable_money = float_of_2_decimal(1_000_000_000)
    $max_allowable_ante = float_of_2_decimal(10000)
  end

  def add_rules
    $quick_start = q_quick_start
    if $quick_start == false
      $number_of_humans = q_number_of_humans
      play_with_robots
      custom_rules if q_custom_rules

      $number_of_humans.times do
        add_human
        $players[-1].human_properties
      end

    else
      $characters.each do |character|
        add_robot(character)
      end
      add_human
      $players[-1].name = 'You'
      $players[-1].money = $ante_size * 10
      $players[-1].starting_money = $players[-1].money
    end
  end

  def custom_rules
    $deck = Deck.new(q_shoe_size)
    $shuffle_every_turn = q_shuffle_every_turn
    $ante_size = q_ante_size
    $resplit_aces = q_resplit_aces
    $double_after_split = q_double_after_split
    $offer_insurance = q_offer_insurance
    $number_of_split_hands = q_number_of_split_hands
    $hit_on_soft_seventeen = q_hit_on_soft_seventeen
    $discards_visible = q_discards_visible
  end

  def add_robot(character)
    if character.behavior == :random
      newplayer = Randomplayer.new
    elsif character.behavior == :default
      newplayer = Roboplayer.new
    elsif character.behavior == :psychic
      newplayer = Psychicplayer.new
    elsif character.behavior == :risky
      newplayer = Riskyplayer.new
    elsif character.behavior == :countscards
      newplayer = CardCountingPlayer.new
    end

    newplayer_id = ":player#{$players.length + 1}"
    newplayer.player_id = newplayer_id.to_sym
    newplayer.name = character.name
    newplayer.ante_modifier = character.ante_modifier
    newplayer.money = character.money*$ante_size
    newplayer.flavor_text = character.flavor_text
    #
    $players.unshift(newplayer)
  end

  def add_human
    newplayer = Player.new
    newplayer_id = ":player#{$players.length + 1}"
    newplayer.player_id = newplayer_id.to_sym
    $players.push(newplayer)
  end

  def play_with_robots
    asking = true
    while asking
      new_robot = q_play_with_robots($characters)
      if new_robot.nil?
        asking = false
      else
        add_robot(new_robot)
      end
    end
  end

  def play_round
    # First ask if each player wants to play this round

    $show_dealers_cards_now = false
    status_bar if $game_count > 1
    message = "\nThe dealer is ready to play. "
    message = "\nThe deck is freshly shuffled and the dealer is ready to play." if $deck.cards.length == 52
    puts message

    ##
    $players.each do |player|
      player.get_dealt if player.money >= $ante_size
    end

    # Then deal the dealer
    $dealer.new_hand

    # If the dealer shows an ace, ask everyone if they want insurance
    if $dealer.insurance?
      puts 'Dealer showing an ace. Do you want insurance?'
      $players.each do |player|
        status_bar
        player.insurance?
      end
    end

    # Dealer checks for blackjack, revealing if so and paying out insurance as necessary
    if $dealer_hand.score == :blackjack
      puts "Dealer hits blackjack! Insurance paid out and round ends."
      $players.each do |player|
        player.money += player.insurance*3
        puts "#{player.name} gets #{player.insurance*2} back in insurance."
        player.hands.each do |hand|
          hand.im_done = true # => There should be only one hand at this point, but just in case...
          hand.wager = 0  # => To prevent accidental payout later. Might be unnecessary.
        end
      end
    elsif $dealer_hand.score != :blackjack && $dealer.insurance?
      puts "Dealer does not have blackjack. Play continues..."
    end

    # Then we go around and give each player their turn
    $players.each do |player|
      player.my_turn
    end

    $show_dealers_cards_now = true # flag that hole card should be made visible
    $deck.visible_cards.push($hole_card) # add hole card to the list of visible cards

    # Then the dealer plays his turn
    $dealer.my_turn

    # Then each player sees how they did and collects winnings if applicable
    $players.each do |player|
      player.did_i_win
    end

    # Players and dealer discard their hands
    $dealer.reset
    $players.each do |player|
      player.reset
    end

    # If it's time to shuffle the deck, do so.
    $deck.shuffle if $deck.shuffle?


  end

  def stop_game
    puts "You leave the table with $#{@money}."
    puts 'Goodbye'
    @on = false
  end
end
