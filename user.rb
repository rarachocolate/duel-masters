require './methods.rb'
require './deck.rb'

class User
  attr_reader :name
  attr_accessor :deck, :hands, :shields, :battlezone, :can_attack_creature, :manazone, :deadzone, :available_card, :life
  def initialize(name:, deck:)
    @name = name
    @deck = deck
    @hands = []
    @shields = []
    @battlezone = []
    @can_attack_creature = []
    @manazone = []
    @deadzone = []
    @available_card = []
    @life = true
  end

  def prepara_duel
    deck_shuffle
    draw_cards(5)
    set_shields(5)
  end

  def deck_shuffle
    deck.shuffle!
  end

  def set_shields(num)
    puts "#{name}がシールドゾーンに#{num}枚セットしました。"
    draw_card = deck.slice!(0, num)
    draw_card.each do |card|
      shields << card
    end
  end

  def tap_and_sickness_false
    divide
    battlezone.each do |creature|
      creature.tap = false
      creature.sickness = false
    end
    puts "#{name}のバトルゾーンのクリーチャーを全てアンタップします。"
    puts "現時点でバトルゾーンにいるクリーチャーの召喚酔いも解かれます。"
    show_battlezone
  end

  def draw_cards(num)
    divide
    puts "#{name}のドローフェイズ！"
    puts "↓↓↓ドローカード↓↓↓"
    draw_card = deck.slice!(0, num)
    draw_card.each do |card|
      card.show_detail
      hands << card
    end
  end

  def charge_mana(num)
    divide
    puts "#{name}のマナチャージフェイズです。"
    puts "#{num}枚マナゾーンに入れられます。555と入力するとマナゾーンに入れずに先に進みます。"
    show_hands
    mana_info
    num.times do |time|
      divide
      puts "#{time + 1}枚目にマナに送るカードを選択してください" if time >= 1
      print "1 ~ #{hands.length}の数値を入力してください > "
      select_num = gets.to_i
      case select_num
      when (1..hands.length)
        selected_card = hands.delete_at(select_num - 1)
        manazone << selected_card
        puts "以下のカードをマナゾーンに入れました。"
        selected_card.show_detail
      when 555
        puts "マナチャージを中断します。"
        break
      else
        puts "不適切な値です。もう1度入力してください。"
        redo
      end
      show_hands
    end
    mana_info
  end

  def show_hands
    divide
    if hands.any?
      puts "#{name}の手札です。"
      @hands.each.with_index(1) do |hand,index|
        print "#{index}."
        hand.show_detail
      end
    else
      puts "#{name}は手札がありません。"
    end
  end

  def summon_creature(select_num)
    puts "#{available_card[select_num].name}を召喚！"
    available_card[select_num].show_detail
    battlezone << hands.delete(available_card[select_num])
    available_card.delete_at(select_num)
  end

  def show_battlezone
    divide
    if battlezone.any?
      puts "#{name}のバトルゾーンです。"
      battlezone.each.with_index(1) do |card,index|
        print "#{index}."
        card.show_detail
      end
    else
      puts "#{name}のバトルゾーンにはクリーチャーがいません。"
    end
  end

  def show_deadzone
    divide
    if deadzone.any?
      puts "#{name}の墓地状況です。"
      deadzone.each.with_index(1) do |card, index|
        print "#{index}"
        card.show_detail
      end
    else
      puts "#{name}の墓地にはカードがありません。"
    end
  end

  def mana_info
    divide
    puts "♢♢♢♢♢♢マナゾーンの状況♢♢♢♢♢♢"
    mana_info = []
    if manazone.any?{|card| card.color == :red}
      mana_info << "red"
    end
    if manazone.any?{|card| card.color == :blue}
      mana_info << "blue"
    end
    if manazone.any?{|card| card.color == :green}
      mana_info << "green"
    end
    if manazone.any?{|card| card.color == :yellow}
      mana_info << "yellow"
    end
    if manazone.any?{|card| card.color == :black}
      mana_info << "black"
    end
    puts "マナ数:#{manazone.length}"
    puts "マナゾーンにあるカラー  ↓  "
    puts mana_info.join(" ")
  end

  def divide
    puts "------------------------------------------------------------------------------------------------------------"
  end

  #使用可能なカードが手札に含まれているならばtrue,なければfalseを返す
  def collect_available_card(available_mana)
    hands.each do |hand|
      if mana_color_check(hand) && mana_num_check(hand, available_mana)
        available_card << hand
      end
    end
  end
  #引数に入れたカードと同じカラーのカードがマナゾーンにあればtrue,なければfalseを返す
  def mana_color_check(card)
    manazone.any?{|mana_card| mana_card.color == card.color}
  end
  #引数に入れたカードが第２引数の値以下ならばtrue,そうでなければfalseを返す
  def mana_num_check(card, available_mana)
    card.cost <= available_mana
  end

  #召喚酔いしていない、かつタップされていないクリーチャーをcan_attack_creatureに格納
  def collect_attack_card
    battlezone.each do |card| 
      if card.tap == false && card.sickness == false
        can_attack_creature << card
      end
    end
  end

  def win
    @win += 1
  end
end