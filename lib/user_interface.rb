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

  def status_bar
    bar = "Ante-Size: #{$ante_size}\n"
    bar += "Visible Cards: #{print_array($deck.visible_cards)}\n"
    bar += "Discard Pile: #{print_array($deck.discards)}\n" if $discards_visible
    bar += '_' * 10
    bar += "\n\n"
    bar += 'DEALER:'
    bar += "\nHand : #{$dealer_hand}\nScore: #{$dealer_hand.score}\n"
    bar += '_' * 10
    bar += "\n\n"

    $players.each do |player|
      bar += "Player: #{player.name}\t\tMoney: #{player.money}\n"
      player.hands.each_with_index do |hand, _i|
        bar += "\nHand #{_i + 1} : #{hand}\nScore: #{hand.score}\tWager: #{hand.wager}\n"
      end
    end
    bar += '_' * 10
    bar += "\n\n"
    clean
    puts bar
  end

  def welcome
    if $game_count == 0
      clean
      puts "

Thick cigarette smoke fills the casino hall, and yet still fails to hide the sharp odor of freon emanating from above.
The haze and gloom masks the faces of your fellow gamblers like two decades on a polaroid. Still, you see some old familiars.

Welcome back, stranger.


Press <enter> to continue
      "
      gets
    else
      status_bar
      puts "

      The dealer prepares for the next game. You've played #{$game_count} game(s). You have $#{$players[0].money} left.


      Press <enter> to continue
      "
      gets

      # Ask the player if they'd like to continue
      stop_game unless q_keep_playing

    end
  end
end
