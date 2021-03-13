require_relative './magic.rb'

class HandsDestroy < Magic
  def effect(enemy_user)
    puts "相手の手札を#{magic_power}体破壊します"
    magic_power.times do |index|
      if enemy_user.hands.any?
        puts "#{index + 1}体目のクリーチャーを選択してください。" if index >= 1
        enemy_user.show_hands
        puts "破壊するクリーチャーを選択してください。555を入力したら中断します。"
        print "破壊するクリーチャーを選択  >  "
        select_num = gets.to_i
        break if select_num == 555
        enemy_user.deadzone << enemy_user.hands.delete_at(select_num - 1)
        puts "以下のクリーチャーを破壊しました。"
        enemy_user.deadzone[-1].show_detail
      else
        puts "相手のバトルゾーンにクリーチャーがいないので中断します"
        break
      end
    end
  end
end