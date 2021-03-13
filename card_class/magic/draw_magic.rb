require_relative './magic.rb'

class Draw < Magic
  def effect(myself)
    draw_card = myself.deck.slice!(0, magic_power)
    puts "#{magic_power}枚ドローします。"
    draw_card.each do |card|
      card.show_detail
      myself.hands << card
    end
  end
end
