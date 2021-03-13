#下のrequire_relativeはなぜかrequireではダメだった。原因は不明。。。
require_relative './magic.rb'
require_relative '../../methods.rb'

class BattlezoneDestroy < Magic
  def effect(enemy_user)
    puts "バトルゾーンのクリーチャーを#{magic_power}体破壊します"
    magic_power.times do |index|
      if enemy_user.battlezone.any?
        puts "#{index + 1}体目のクリーチャーを選択してください。" if index >= 1
        enemy_user.show_battlezone
        puts "破壊するクリーチャーを選択してください。555を入力すると中断します。"
        print "破壊するクリーチャーを選択  >  "
        select_num = gets.to_i
        break if select_num == 555
        enemy_user.deadzone << enemy_user.battlezone.delete_at(select_num - 1)
        puts "以下のクリーチャーを破壊しました。"
        enemy_user.deadzone[-1].show_detail
        divide
        if enemy_user.battlezone.any?
          puts "相手のバトルゾーンの状況です。"
          enemy_user.show_battlezone
        else
          puts "相手のバトルゾーンにクリーチャーがいなくなりました。"
        end
      else
        puts "相手のバトルゾーンにクリーチャーがいないので中断します"
        break
      end
    end
  end
end
