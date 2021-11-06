#
#  MASTER MENU GAMESTATE
#
class MasterMenu < Chingu::GameState
  trait :timer
  def initialize
    super

#    self.input = { [:enter, :return] => :proceed, :p => Pause, :r => lambda{current_game_state.setup}, :n => :next }
  end

  def setup
    $window.width = 1100
    $window.height = 700

    Chingu::Text.destroy_all # destroy any previously existing Text, Player, EndPlayer, and Meteors
    $window.caption = "          MASTER MENU"
    @click = Gosu::Sound["pickup_chime.ogg"]

    after(300) {
      @text = Chingu::Text.create("Master Menu",
        :y => 150, :font => "GeosansLight", :size => 70,
        :color => Colors::White, :zorder => 10)
      @text.x = 1100/2 - @text.width/2 # center text
    }
    after(600) {
      @text2 = Chingu::Text.create("Keep Calm and Balance",
        :y => 350, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text2.x = 1100/2 - @text2.width/2 # center text
    }
    after(900) {
      @text2 = Chingu::Text.create("Pet Peeve",
        :y => 450, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text2.x = 1100/2 - @text2.width/2 # center text
    }
    after(1200) {
      @text2 = Chingu::Text.create("Relax",
        :y => 550, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text2.x = 1100/2 - @text2.width/2 # center text
    }
  end

end
