class Creature
  attr_reader :name, :color, :power, :cost, :break_power, :triger
  attr_accessor :tap, :sickness
  def initialize(name: , color: , power: , cost: , break_power: , sickness: true, tap: false, triger: )
    @name = name
    @color = color
    @power = power
    @cost = cost
    @break_power = break_power
    @sickness = sickness
    @tap = tap
    @triger = triger
  end

  def shield_break(enemy_shield)
    tap = true
    enemy_shield.slice!(0, breakpower)
  end

  def show_detail
    puts "名前：#{name} 分類:#{self.class} カラー:#{color} コスト:#{cost} パワー:#{power} ブレイクパワー:#{break_power} タップ:#{tap} 召喚酔い:#{sickness} シールドトリガー:#{triger}"
  end

  def attack(myself, enemy_user)
    if enemy_user.battlezone.any?{|card| card.tap == true}
      puts "攻撃方法を選択してください。"
      puts "1.相手プレイヤーに攻撃する 2.相手のクリーチャーに攻撃する。555で攻撃を中止します。"
      while true
        print "攻撃方法を選択  >  "
        select_num = gets.to_i
        case select_num
        when 1
          shield_break(enemy_user)
          break
        when 2
          battle(myself, enemy_user)
          break
        when 555
          break
        else
          puts "1または2、または555を入力してください"
          redo
        end
      end
    else
      puts "相手のバトルゾーンにタップされたクリーチャーはいません。"
      puts "#{name}は相手プレイヤーを攻撃します。"
      shield_break(enemy_user)
      if enemy_user.life == false
        puts "#{enemy_user.name}はシールド0枚の状態で直に攻撃を受けました。"
        return
      end
      puts "相手のシールドは残り#{enemy_user.shields.length}枚です。"
    end
  end

  def shield_break(enemy_user)
    puts "#{name}は攻撃を行うのでタップされます。"
    self.tap = true
    self.show_detail
    if enemy_user.shields.any?
      breaked_shield = enemy_user.shields.slice!(0, break_power)
      puts "シールドを#{break_power}枚ブレイクしました。"
      puts "--------ブレイクしたシールド----------"
      breaked_shield.each do |card|
        card.show_detail
        enemy_user.hands << card
      end
    elsif 
      enemy_user.life = false
      return
    end
  end

  def battle(myself, enemy_user)
    tapped_creature = enemy_user.battlezone.select{|card| card.tap == true}
    puts "攻撃するクリーチャーを選んでください"
    tapped_creature.each.with_index(1) do |card, index|
      print "#{index}."
      card.show_detail
    end
    select_num = gets.to_i

    if power > tapped_creature[select_num - 1].power
      self.tap = true
      puts "#{name}のパワーが相手クリーチャーより強いので、相手クリーチャーを墓地に送ります。"
      puts "以下の相手クリーチャーが墓地に送られます"
      tapped_creature[select_num - 1].show_detail
      enemy_user.deadzone << enemy_user.battlezone.delete(tapped_creature[select_num - 1])
      enemy_user.show_deadzone
    elsif power == tapped_creature[select_num - 1].power
      puts "#{name}のパワーが相手クリーチャーと同じなので、両者墓地に送られます。"
      puts "#{myself.name}の#{name}が墓地に送られました。"
      self.show_detail
      myself.deadzone << myself.battlezone.delete(self)
      myself.show_deadzone
      puts "#{enemy_user.name}の#{tapped_creature[select_num - 1].name}が墓地に送られました。"
      tapped_creature[select_num - 1].show_detail
      enemy_user.deadzone << enemy_user.battlezone.delete(tapped_creature[select_num - 1])
      enemy_user.show_deadzone
    else
      puts "#{name}のパワーが相手クリーチャーより弱いので、#{name}のみが墓地に送られます。"
      myself.deadzone << myself.battlezone.delete(self)
      myself.show_battlezone
    end
  end
end