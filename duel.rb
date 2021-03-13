require './deck.rb'
require './methods.rb'
require './user.rb'
include MakingDeck
include DuelMasters


def two_duel(user_1, user_2, count)
  #デッキをシャッフル→上から5枚を手札に加える。

  #ここからは各ターン毎に繰り返し。unlessは先行のプレイヤーが1ターン目にドローできないようにするため。
  user_1.draw_cards(1) unless count == 0

  #バトルゾーンにある自身のクリーチャーを全てアンタップ、召喚酔いの解除
  if user_1.battlezone.any?
    user_1.tap_and_sickness_false
  end

  #自分の手札からマナゾーンにカードを入れる。
  user_1.charge_mana(1)

  #使用可能なマナを一度変数に格納
  available_mana = user_1.manazone.length

  #使用可能なカードをavailable_cardに格納
  user_1.collect_available_card(available_mana)

  divide

  #召喚・呪文発動フェイズ
  use_card_phase(user_1, user_2, available_mana)

  #バトルゾーンを表示
  user_1.show_battlezone

  #availab_cardをリセット
  user_1.available_card = []

  #アタック可能なクリーチャーを格納する。
  user_1.collect_attack_card
  #------アタックフェイズ-----
  if user_1.can_attack_creature.any?
    attack_phase(user_1, user_2)
  else
    puts "攻撃可能なモンスターがいません。#{user_1.name}のターンを終了します。"
  end
end

