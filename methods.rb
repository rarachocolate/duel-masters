module DuelMasters
  def use_card_phase(user_1, user_2, available_mana)
    if user_1.available_card.any?
      while user_1.available_card.any?
        puts "#{user_1.name}の召喚・呪文発動フェイズです。"
        puts "使用可能なカードはこちらです↓"
        user_1.available_card.each.with_index(1) do |card, index|
          print "#{index}."
          card.show_detail
        end
        puts "使用するカードを選択してください。555を入力すると次のフェイズに進みます。"
        select_num = gets.to_i
        case select_num
        when 555
          puts "召喚・発動フェイズを終了します。"
          break
        when (1..user_1.available_card.length)
          available_mana -= user_1.available_card[select_num - 1].cost
          if user_1.available_card[select_num - 1].class == Creature
            user_1.summon_creature(select_num - 1)
          else
            use_magic(user_1, user_2, user_1.available_card[select_num - 1])
            puts "#{user_1.available_card[select_num - 1].name}は発動しました。墓地に送ります。"
            user_1.deadzone << user_1.hands.delete(user_1.available_card[select_num - 1])
            user_1.available_card.delete_at(select_num - 1)
            puts "#{user_1.name}の墓地状況です。"
            user_1.deadzone.each do |card|
              card.show_detail
            end
          end
        else
          puts "#1~#{user_1.available_card.length}の値を入力してください。"
          redo
        end

        puts "このターンに使用可能なマナ数は残り#{available_mana}です。"

        if user_1.available_card.all?{|card| card.cost > available_mana}
          puts "このターンに使用できるカードが手札にありません。次のフェイズへ進みます。"
          break
        end
      end
    else
      puts "使用できるカードが手札にありません。次のフェイズへ進みます。"
    end
  end

  #アタックフェイズ
  def attack_phase(user_1, user_2)
    catch :done do
      while user_1.can_attack_creature.any?
        puts "アタックフェイズです。"

        puts "以下のクリーチャーは攻撃可能です。"
        user_1.can_attack_creature.each.with_index(1) do |card, index|
          print "#{index}."
          card.show_detail
        end

        while true 
          puts "攻撃に使用するクリーチャーを選択してください。555でアタックフェイズを終了します。"
          select_num = gets.to_i
          if select_num == 555
            puts "攻撃に使用するクリーチャーを選択しませんでした。"
            throw :done
          end
          break if (1..user_1.can_attack_creature.length).include?(select_num)
          puts "1~#{user_1.can_attack_creature.length}の値を入力してください。"
        end

        puts "#{user_1.can_attack_creature[select_num - 1].name}で攻撃します"
        
        user_1.can_attack_creature[select_num - 1].attack(user_1, user_2)
        user_1.can_attack_creature.delete_at(select_num - 1)
        if user_2.life == false
          return
        end
      end
    end

    puts "#{user_1.name}のターンを終了します。"
    user_1.can_attack_creature = []
  end


  #どのカテゴリの呪文によって適切に引数を代入してメソッドを実行してくれる
  def use_magic(myself, enemy_user, *magics)
    magics.each do |card|
      case card
      when BattlezoneDestroy
        card.effect(enemy_user)
      when HandsDestroy
        card.effect(enemy_user)
      when Draw
        card.effect(myself)
      when BattlezoneTap
        card.effect(enemy_user)
      end
    end
  end

  #見やすくするためのもの
  def divide
    puts "------------------------------------------------------------------------------------------------------------"
  end
end