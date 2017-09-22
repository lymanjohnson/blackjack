module User_Interface
  def clean
    puts "\e[H\e[2J"
  end

  def print_array(arr)
    line = ""
    arr.each do |card|
      line += "#{card} "
    end
    line
  end

  def dealer_print(hand)
    arr = hand.cards.dup
    arr[0] = "__" if !$show_dealers_cards_now
    print_array(arr)
  end

  def status_bar
    bar = "Ante-Size: #{$ante_size}\n"
    bar += "Visible Cards: #{print_array($deck.visible_cards)}\n"
    bar += "Discard Pile: #{print_array($deck.discards)}\n" if $discards_visible
    bar += '_' * 10
    bar += "\n\n"
    bar += 'DEALER:'
    bar += "\nHand : #{dealer_print($dealer_hand)}\n"
    bar += "Score: #{$dealer_hand.score}\n" if $show_dealers_cards_now
    bar += "Score: ??\n" if !$show_dealers_cards_now
    bar += '_' * 10
    bar += "\n\n"

    $players.each do |player|
      bar += "Player: #{player.name}\tMoney: #{player.money}\t"
      if player.insurance > 0
        bar += "INSURED\n"
      else bar+= "\n"
      end
      if player.hands.length == 0
        bar += "\n\n\n"
        bar += '_' * 10
        bar += "\n\n"
      end
      player.hands.each_with_index do |hand, _i|
        bar += "\nHand #{_i + 1} : #{hand}\nScore: #{hand.score}\tWager: #{hand.wager}\n"

        bar += '_' * 10
        bar += "\n\n"
      end
    end

    clean
    puts bar
  end

  def welcome
    if $game_count == 0
      clean
      puts "

Thick cigarette smoke fills the casino hall, and yet still fails to hide the sharp odor of freon emanating from above.
The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old regulars.

Welcome back, stranger.



Press <enter> to continue
      "
      gets
    else
      status_bar
      puts "You've played #{$game_count} game(s).\n\nPress <enter> to continue\n"
      gets

      # Ask the player if they'd like to continue
      $game.stop_game unless q_keep_playing

    end
  end
end
