#
#  MASTER MENU GAMESTATE
#
class MasterMenu < Chingu::GameState
  trait :timer
  def initialize
    super
    self.input = { [:up, :w] => :go_up,
      [:down, :s] => :go_down,
      [:right, :d] => :go_fullscreen,
      [:left, :a] => :leave_fullscreen,
      [:enter, :return, :space] => :choose_game }
  end

  def setup
    $window.width = 1100
    $window.height = 700
    $window.cursor = false
    $music = Gosu::Song["butterfly/sounds/space.flac"]
    $music.volume = 0.3
    $music.play(true)

    Chingu::Text.destroy_all
    MasterText.destroy_all
    $window.caption = "          MASTER MENU"
    @click = Gosu::Sound["click.ogg"]
    @chime = Gosu::Sound["pickup_chime.ogg"]

    @menu_index = 0
    @games = [:calm, :butterfly, :peeve, :boxes,
              :relax, :scheduler, :bricks, :penguin  ]
    @texts = []
    make_texts

    after(500) {  @texts_exist = true
        @texts = [@text1, @text2, @text3, @text4,
                  @text5, @text6, @text7, @text8 ]
        @click.play
    }
  end

  def go_up
    @click.play
    @menu_index -= 1
    @menu_index = @texts.length - 1 if @menu_index < 0
  end

  def go_down
    @click.play
    @menu_index += 1
    @menu_index = 0 if @menu_index > @texts.length - 1
  end

  def choose_game
    @chime.play
    self.send(@games[@menu_index])
    @menu_index = 0
  end

  def unhighlight_text
    @texts.each do |text|
      text.factor = 1
    end
  end

  def highlight_text
    @texts[@menu_index].factor = 1.2
  end

  def update
    if @texts_exist
      unhighlight_text
      highlight_text
    end
  end

  def calm;       push_game_state(Calm);                  end
  def butterfly;  push_game_state(ButterflySurfer);       end
  def peeve;      push_game_state(Peeve);                 end
  def boxes;      push_game_state(Boxes);                 end
  def relax;      push_game_state(Opening1);              end
  def scheduler;  push_game_state(SchedulerGame::Window); end
  def bricks;     push_game_state(BricksGame);            end
  def penguin;    push_game_state(PenguinGame);           end

  def go_fullscreen
    $window.fullscreen = true
  end
  def leave_fullscreen
    $window.fullscreen = false
  end

  def make_texts
    after(20) { @text = TitleText.create("Gosu Game Jam 2021", :size => 80, :y => 40)
      @text.x = 1100/2 - @text.width/2  }
    after(100) { @text1 = MasterText.create("Keep Calm & Balance",   :y => 150) }
    after(125) { @text2 = MasterText.create("Butterfly Surfer",      :y => 210) }
    after(155) { @text3 = MasterText.create("Pet Peeve",             :y => 270) }
    after(175) { @text4 = MasterText.create("Boxes",                 :y => 330) }
    after(200) { @text5 = MasterText.create("Relax",                 :y => 390) }
    after(225) { @text6 = MasterText.create("Scheduler",             :y => 450) }
    after(250) { @text7 = MasterText.create("Ruby Brickland (stub)", :y => 510) }
    after(275) { @text8 = MasterText.create("Chaos Penguin (stub)",  :y => 570) }
  end
end

class MasterText < Chingu::Text
  def setup
    @text = text
    @x = 300
    @font = "GeosansLight"
    @size = 40
    @color = Colors::White
    @zorder = 10
  end
end

class TitleText < MasterText
  def setup
    @size = 80
  end
end
