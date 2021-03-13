require './card_class/creature/creature.rb'
require './card_class/magic/battlezone_destroy_magic.rb'
require './card_class/magic/battlezone_tap_magic.rb'
require './card_class/magic/hands_destroy_magic.rb'
require './card_class/magic/draw_magic.rb'
require './card_class/magic/magic.rb'

module MakingDeck
  def make_deck(deck_1)
    4.times do
      deck_1 << Creature.new(name: "レッドドラゴン", color: :red, power: 3000, cost: 1, break_power: 2, sickness: true, tap: false, triger: false)
    end
    4.times do
      deck_1 << Creature.new(name: "ブルードラゴン", color: :blue, power: 2000, cost: 1, break_power: 1, sickness: true, tap: false, triger: false)
    end
    4.times do
      deck_1 << Creature.new(name: "グリーンドラゴン", color: :green, power: 2000, cost: 1, break_power: 1, sickness: false, tap: false, triger: false)
    end
    4.times do
      deck_1 << Creature.new(name: "イエロードラゴン", color: :yellow, power: 2000, cost: 1, break_power: 1, sickness: false, tap: false, triger: false)
    end
    4.times do
      deck_1 << Creature.new(name: "ブラックドラゴン", color: :black, power: 4000, cost: 1, break_power: 1, sickness: true, tap: false, triger: false)
    end
    4.times do
      deck_1 << BattlezoneDestroy.new(name: "レッドハンド", color: :red, cost: 1, magic_power: 1, triger: false)
    end
    4.times do
      deck_1 << Draw.new(name: "ブルーハンド", color: :blue, cost: 1, magic_power: 1, triger: false)
    end
    4.times do
      deck_1 << Draw.new(name: "グリーンハンド", color: :green, cost: 1, magic_power: 1, triger: false)
    end
    4.times do
      deck_1 << BattlezoneTap.new(name: "イエローハンド", color: :yellow, cost: 1, magic_power: 1, triger: false)
    end
    4.times do
      deck_1 << BattlezoneDestroy.new(name: "ブラックハンド", color: :black, cost: 1, magic_power: 1, triger: true)
    end
  end
end


