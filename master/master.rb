#
#  MASTER MENU GAMESTATE
#
class MasterMenu < Chingu::GameState
  trait :timer
  def initialize
    super
    self.input = { :up => :go_up, :down => :go_down, [:enter, :return] => :choose_game }
#    self.input = { [:enter, :return] => :proceed, :p => Pause, :r => lambda{current_game_state.setup}, :n => :next }
  end

  def setup
    $window.width = 1100
    $window.height = 700

    Chingu::Text.destroy_all # destroy any previously existing Text, Player, EndPlayer, and Meteors
    $window.caption = "          MASTER MENU"
    @click = Gosu::Sound["pickup_chime.ogg"]

    # @main_menu_options = [
    #   { text: 'Play', method: :start_game },
    #   { text: 'How To Play', method: :display_how_to_play },
    #   { text: 'Fullscreen', method: :toggle_fullscreen },
    #   { text: 'Credits', method: :display_credits },
    #   { text: 'Quit', method: :quit }
    # ]

    @games = ['Calm', 'Peeve', 'Relax', 'Butterfly']
    @selection = 1
    make_text
    @texts = [@text1, @text2, @text3]
  end

  def go_up
    # beep_sound.play
    # self.menu_index -= 1
    # self.menu_index = menu.length - 1 if menu_index < 0
  end

  def go_down

  end

  def choose_game

  end

  def highlight_text
    @texts[@selection - 1].size = 60
  end
  def unhighlight_text
    @texts[@selection - 1].size = 45
  end


      # case key
      # when Gosu::KbUp, Gosu::KbW
      #   beep_sound.play
      #   self.menu_index -= 1
      #   self.menu_index = menu.length - 1 if menu_index < 0
      # when Gosu::KbDown, Gosu::KbS
      #   beep_sound.play
      #   self.menu_index += 1
      #   self.menu_index = 0 if menu_index > menu.length - 1
      # when Gosu::KbReturn, Gosu::KbSpace
      #   beep_sound.play
      #   self.send(menu[menu_index][:method])
      #   self.menu_index = 0
      # end

  def make_text
    after(100) {
      @text = Chingu::Text.create("Master Menu",
        :y => 150, :font => "GeosansLight", :size => 70,
        :color => Colors::White, :zorder => 10)
      @text.x = 1100/2 - @text.width/2 # center text
    }
    after(200) {
      @text1 = Chingu::Text.create("Keep Calm and Balance",
        :y => 250, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text1.x = 200 #1100/2 - @text2.width/2 # center text
    }
    after(300) {
      @text2 = Chingu::Text.create("Pet Peeve",
        :y => 350, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text2.x = 200 #1100/2 - @text2.width/2 # center text
    }
    after(400) {
      @text3 = Chingu::Text.create("Relax",
        :y => 450, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text3.x = 200 #1100/2 - @text2.width/2 # center text
    }
    after(500) {
      @text4 = Chingu::Text.create("Butterfly Surfer",
        :y => 550, :font => "GeosansLight", :size => 45,
        :color => Colors::White, :zorder => 10)
      @text4.x = 200 #1100/2 - @text2.width/2 # center text
    }
  end


end
