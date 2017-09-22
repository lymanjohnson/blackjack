require 'bigdecimal'
require 'bigdecimal/util'

def float_of_2_decimal(answer)
  begin
    answer.to_d.round(2, :truncate).to_f
  rescue ArgumentError
    return :oops
  end
end


def q_quick_start
    loop do
    clean
    print "Quick start? [y/n]  "
    answer = gets.chomp.downcase
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_playing_this_round(name)
    loop do
    clean
    print "Will #{name} be playing this round? [y/n]  "
    answer = gets.chomp.downcase
    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end


def q_wager(player_name,total_money)
  loop do
    clean
    print "What will #{player_name} wager this round? Minimum bet is $#{'%.2f' % $ante_size}.  "
    answer = gets.chomp
    if answer == ""
      clean
      puts "You bet $#{'%.2f' % $ante_size}"
      gets
      return $ante_size
    end
    answer = float_of_2_decimal(answer)
    if answer == :oops
    elsif answer < $ante_size
      clean
      puts "You must bet at least #{'%.2f' % $ante_size}. You put down #{'%.2f' % $ante_size}."
      gets
      return $ante_size
    elsif answer > total_money
      clean
      puts "You can't bet more than you have. (You have #{total_money})"
      puts "You put down #{total_money}"
      gets
      return total_money
    else
      return answer
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_make_decision(options,hand_index,possessive)
  message = "#{possessive} Hand #{hand_index + 1}:\n"
  message += options.include?(:hit) ? "  [H] Hit\n" : ""
  message += options.include?(:double) ? "  [D] Double\n" : ""
  message += options.include?(:split) ? "  [P] Split\n" : ""
  message += options.include?(:stand) ? "  [T] Stand\n" : ""

  loop do
    status_bar
    print message
    print "\nWhat will you do?  "

    answer = gets.chomp.downcase

    if answer[0] == "h" && options.include?(:hit)
      return :hit
    elsif answer[0] == "d" && options.include?(:double)
      return :double
    elsif answer[0] == "p" && options.include?(:split)
      return :split
    elsif answer[0] == "t" && options.include?(:stand)
      return :stand
    end
    puts "That is not a valid answer!"
    gets
  end
end

def q_play_with_robots(characters)
  clean
  message = "You look around the table and see some familiar faces. Who would you like to play with?\n\n\n\n"
  characters.each_with_index do |character,_i|
    message += "[#{_i+1}] #{character.name}  (#{character.description})\n\n#{character.flavor_text}\n\n\n\n"
  end
  message += "\t\tENTER THE NUMBER OF THE PERSON YOU'D LIKE TO PLAY WITH. \n\n\t\tPRESS ENTER IF YOU DON'T WANT TO PLAY WITH ANYONE ELSE\n\n\n\n"
  loop do
    clean
    print message
    response = gets.chomp
    return nil if response == "" || response[0].downcase == "n" || response[0] == " "
    begin
      response = Integer(response)
      if response > characters.length || response < characters.length
        clean
        puts "That's not a valid answer"
        gets
      else
        return response
      end
    rescue ArgumentError
      clean
      puts "That's not a valid answer. "
      gets
    end
  end
end

def q_shoe_size
    loop do
    clean
    print "How many decks do you want to play with? [1-#{$max_allowable_decks}]  "
    answer = gets.chomp
    if answer == ""
      return 1
    end
    answer = answer.to_i
    if answer > $max_allowable_decks
      clean
    elsif answer <= 0
      clean
    else
      return answer
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_number_of_humans
    loop do
    clean
    print "How many human players are there? [1-#{$max_allowable_humans}]  "
    answer = gets.chomp
    return 1 if answer == ""
    answer = answer.to_i
    if answer > $max_allowable_humans
      clean
    elsif answer < 1
      clean
    else
      return answer
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_money(name)
    loop do
    clean
    print "How much money are you bringing to the table, #{name}?  "

    answer = gets.chomp

    return 10 * $ante_size if answer == ""
    # answer = float_of_2_decimal(gets.chomp)
    answer = float_of_2_decimal(answer)
    if answer == :oops
      clean
      puts "That is not a valid answer!"
      gets
    elsif answer < $ante_size * 10
      clean
      puts "You need at least $#{'%.2f' % ($ante_size * 10)} if you're going to have any fun."
      gets
      puts "You bring $#{'%.2f' % $ante_size}"
      gets
      return $ante_size * 10
    elsif answer > 1_000_000_000
      clean
      puts "Any more than $#{'%.2f' % $max_allowable_money} is irresponsible..."
      gets
      puts "You bring $#{'%.2f' % $max_allowable_money}"
      gets
      return $max_allowable_money
    else
      return answer
    end
  end
end

def q_name(player_id)
    loop do
    clean
    print "What's your name, #{player_id.to_s.capitalize.tr(":","")}?  "
    answer = gets.chomp
      if answer.length > 20
        clean
        puts "Sorry, your name must be shorter than 20 characters."
        gets
      elsif answer == ""
        return player_id.to_s.capitalize.tr(":","")
      else
        clean
        puts "Nice to meet you, #{answer}."
        return answer
      end
  end
end

def q_custom_rules
    loop do
    clean
    print "Do you want to change the house rules? [y/n] "
    answer = gets.chomp.downcase

    if answer[0] == "y"
      return true
    elsif answer[0] == "n" || answer == ""
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_keep_playing
  status_bar
    loop do
    clean
    print "Do you want to keep playing? [y/n] "
    answer = gets.chomp.downcase

    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_resplit_aces
    loop do
    clean
    print "Do you want to allow re-splitting aces? [y/n] "
    answer = gets.chomp.downcase

    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_hit_on_soft_seventeen
    loop do
    clean
    print "Will the dealer hit on a soft seventeen? [y/n] "
    answer = gets.chomp.downcase

    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_double_after_split
    loop do
    clean
    print "Do you want to allow doubling on a split hand? [y/n] "
    answer = gets.chomp.downcase

    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

#Note: This sets the rules regarding insurance, it doesn't ask if the player wants insurance this round.
def q_offer_insurance
    loop do
    clean
    print "Do you want to offer insurance if dealer shows an ace? [y/n] "
    answer = gets.chomp.downcase

    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_discards_visible
    loop do
      clean
    print "Do you want help remembering what's in the discard pile? [y/n] "
    answer = gets.chomp.downcase

    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

#Note: this asks if the player wants insurance this round, not whether insurance should be allowed in the rules.
def q_insurance(name,wager)
    loop do
      status_bar
      puts "Does #{name} want insurance? Put down #{'%.2f' % (@wager/2)} to buy insurance.
      Get #{@wager} back if dealer reveals a blackjack. [y/n]"
    answer = gets.chomp.downcase

    if answer[0] == "y" || answer == ""
      return true
    elsif answer[0] == "n"
      return false
    end
    clean
    puts "That is not a valid answer!"
    gets
  end
end

def q_number_of_split_hands
    loop do
      clean
    print "What's the maximum number of hands a player can hold? [1-#{$max_allowable_split_hands}] "
    answer = gets.chomp

    return $max_allowable_split_hands if answer == ""
    # answer = float_of_2_decimal(gets.chomp)
    answer = float_of_2_decimal(answer)
    if answer > $max_allowable_split_hands || answer < 1
      clean
      puts puts "That is not a valid answer!"
      gets
    else
      return answer.to_i
    end
  end
end

def q_ante_size
    loop do
      clean
    print "What's the ante size? [1 - #{'%.2f' % $max_allowable_ante}]  "
    answer = gets.chomp.to_i

    return 10 if answer == ""
    answer = float_of_2_decimal(answer)
    if answer == :oops
      clean
      puts "That is not a valid answer!"
      gets
    elsif answer > $max_allowable_ante
      clean
      puts "The maximum is $#{'%.2f' % $max_allowable_ante}."
      gets
    elsif answer < 1
      clean
      puts "That is not a valid answer!"
      gets
    else
      return answer
    end
  end
end
