class Deck
  attr_reader :cards

  def initialize
    @values = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
    @suits = ['hearts','diamonds','clubs','spades']
    @cards = card_shuffler
  end

  def card_shuffler
    cards = []
    @values.each_with_index do |v,i|
      @suits.each do |s|
        cards.push({score: i + 2, value: v, suit: s})
      end
    end
    return cards.shuffle
  end

end

deck = Deck.new
players = []

while true
  puts "#{players.length} players so far."
  puts "Enter a player name, or type 'play':"

  name = gets.chomp.capitalize
  name == "Play" ? break : players.push(name)
end

cards = players.map { |player| deck.cards.pop }

scores = cards.map do |card|
    card[:score]
end

high_score = scores.max

winners = []

scores.each_with_index do |score, index|
  winners.push( players[index] ) if score == high_score
  puts "#{players[index]}: #{cards[index]}"
end

puts "Winner(s): #{winners.join(', ')}"