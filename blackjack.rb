Dir['./lib/*.rb'].each { |file| require file }
require 'pry'

include User_Interface

$game = Game.new
$game_count = 0
welcome
$game.add_rules
$deck.shuffle

while $game.on
  $game_count+=1
  $game.play_round
  welcome
end
