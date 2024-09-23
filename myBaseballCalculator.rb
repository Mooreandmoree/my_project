# frozen_string_literal: true

class BaseballPlayer
  def initialize(hits, walks, bats)
    @hits = hits
    @walks = walks
    @bats = bats
  end

  def batting_average
    @hits / @bats.to_f
  end

  def on_base_percentage
    (@hits + @walks) / @bats.to_f
  end
end

roger = BaseballPlayer.new(22, 4, 40)
puts roger.batting_average
clemens = BaseballPlayer.new(25, 3, 40)
puts clemens.on_base_percentage
