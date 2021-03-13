require './methods.rb'

class Magic
  attr_reader :name, :color, :cost, :magic_power, :triger
  def initialize(name: , color: , cost: , magic_power: , triger:)
    @name = name
    @color = color
    @cost = cost
    @magic_power = magic_power
    @triger = triger
  end

  def show_detail
    puts "名前：#{name} 分類:#{self.class} カラー:#{color} コスト:#{cost} マジックパワー:#{magic_power} シールドトリガー:#{triger}"
  end
end