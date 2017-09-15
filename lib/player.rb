# money values are multiples of the minimum bet
CHARACTERS = [
{:name => "Dougie Jones" , :behavior => :psychic , :wager => 2, :money => 20, :flavor_text => "A handsome man with dark hair and a sharp looking black suit. Moves slow and doesn't talk much. Loves coffee."},
{:name => "Eddie O'Shea" , :behvaior => :risky , :wager => 2, :money => 20, :flavor_text => "Always quick with a joke and a laugh. The jokes are often repeated and his laugh seem seems forced, though. He keeps looking over his shoulder."},
{:name => "The Duchess", :behavior => :dealer , :wager => 10, :money => 100, :flavor_text => "Her name is Bonnie or Bunny or Barbie or something, but everybody calls her Duchess. An aging beauty, she seems to be here for the company and doesn't care too much when she leaves empty-handed. They say she made her fortune in collect calling and got out before the cell phone revolution."},
{:name => "Tommy, Robbie, and Jason", :behavior => :random , :wager => 1 , :money => 10, :flavor_text => "He has the face of a twelve-year old boy, but his mustache, comedically large nose, and thick glasses mean there's no way he could actually be a kid, even if his voice does sound like that of a small boy doing a Vin Diesel impression. Strangely proportioned, his feet and body seem to stir with extra limbs under his long trench coat. Pays in coins. Doesn't seem to know the rules. Often heard whispering heatedly to his legs and torso."},
{:name => "Kevin Keebler" , :behavior => :countscards , :wager => 1, :money => 10, :flavor_text => "MIT drop out. Doesn't talk at all, as he seems too focused on everyone's cards."},
]

class Player
  @name
  @behavior
  @flavor_text

  @money
  @hands
  @cards

  attr_accessor :cards , :hands

  def initialize

  end

end
