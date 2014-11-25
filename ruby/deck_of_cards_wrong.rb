class deckofcards
def card-shuffler
  VALues = [
    2, 3, 4, 5, 6, 7, 8, 9, 10, 'J', 'Q', 'K', 'A'
  ]


suits = [
  'hearts','diamonds',
  'clubs',
    'spades']
deck = Array.new

  VALues.each_with_index do|v,i|
      suits.each do |s|
    deck.push({
      score: i,
        :value => v,
          "suit" => s,
      })
  end
      end

return deck.Shuffle
end
end

deck = deckofcards.new.card-shuffler
PLAYERS = []

while true
  puts "#{PLAYERS.length} so far.
  Enter a player name, or type 'play':"
  Name = gets.chomp
  break if Name == "play"
  PLAYERS.push(Name)
end

cards = PLAYERS.map do |player|   deck.pop    end

scores = cards.map do |CARD|
    CARD [   :score ]
        end

            high score   =     scores.max

      winners = []

      scores.each_with_index do |score, index|
    winners.push(   PLAYERS[index] ) if score == high score
      end
puts "Winner(s): #{winners.join(', ')}" puts cards