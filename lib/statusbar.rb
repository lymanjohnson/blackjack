module User_Interface


  def clean
    puts "\e[H\e[2J"
  end

  def status_bar
    bar = "Ante-Size: #{$ante_size}\n"
    $players.each do |player|
      bar += "Player: #{player.name}\t\tMoney: #{player.money}\t\t"
      player.hands.each_with_index do |hand,_i|
        bar+="Hand #{_i+1} : #{$hand}"
      end
    end

    bar += "_"*10
    #clean
    puts bar
  end

end
