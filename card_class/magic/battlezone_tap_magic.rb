require_relative './magic.rb'
require_relative '../../methods.rb'

class BattlezoneTap < Magic
  def effect(enemy_user)
    puts "バトルゾーンのクリーチャーを#{magic_power}体タップします。"
    magic_power.times do |index|
      if enemy_user.battlezone.any?
        puts "#{index + 1}体目のクリーチャーを選択してください。" if index >= 1
        enemy_user.show_battlezone
        puts "タップするクリーチャーを選択してください。555を入力すると中断します。"
        print "タップするクリーチャーを選択  >  "
        select_num = gets.to_i
        break if select_num == 555
        enemy_user.battlezone[select_num - 1].tap = true
        puts "以下のクリーチャーをタップしました。"
        enemy_user.battlezone[select_num - 1].show_detail
      elsif enemy_user.battlezone.empty?
        puts "全てのクリーチャーがタップされているので中断します。"
        break
      elsif enemy_user.battlezone.all?{|creature| creature.tap == true}
        puts "相手のバトルゾーンにクリーチャーがいないので中断します"
        break
      end
    end
  end
end