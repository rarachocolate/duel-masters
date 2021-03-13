require './deck.rb'
require './duel.rb'
require './user.rb'
include MakingDeck

puts "Player1は名前を入力してください  >  "
player1_name = gets.to_s.chomp

deck_1 = []
make_deck(deck_1)
alice = User.new(name: player1_name, deck: deck_1)

puts "Player2は名前を入力してください  >  "
player2_name = gets.to_s.chomp

deck_2 = []
make_deck(deck_2)
mary = User.new(name: player2_name, deck: deck_2)

alice.prepara_duel
mary.prepara_duel

count = 0

while alice.life == true && mary.life = true
  two_duel(alice, mary, count)

  break if mary.life == false

  count += 1

  two_duel(mary, alice, count)
end

if alice.life == true
  puts "#{alice.name}の勝利です。"
else
  puts "#{mary.name}の勝利です。"
end
