#
#
#     RESURRECTION OBJECTS
#
#

# RBPTH = "chingu/rebirth_assets/"

class Rift < Chingu::GameObject
  trait :timer
  def tremble
    after(20) {
      after(50) { self.factor = 1.1 }
      after(400) { self.factor = 0.9 }
      after(480) { self.factor = 1.1 }
      after(900) { self.factor = 1.2 }
      after(950) { self.factor = 1.0 }
      after(1050) { self.factor = 1.2 }
      after(1350) { self.factor = 1.1 }
      after(1400) { self.factor = 1.3 }
      after(1450) { self.factor = 1.0 }
      after(1500) { self.factor = 1.4 }
    }
  end
end

class Rift1 < Rift; def setup; @image = Gosu::Image.new(""+RBPTH+"crack1.png"); end; end
class Rift2 < Rift; def setup; @image = Gosu::Image.new(""+RBPTH+"crack2.png"); end; end
class Rift3 < Rift; def setup; @image = Gosu::Image.new(""+RBPTH+"crack3.png"); end; end

class Chunk < Chingu::GameObject
  trait :timer
  def setup
    @color = 0xFFDDDDDD
    @velocity_x = 0
    @velocity_y = 0
  end

  def shake(dir)
    counter = 0
    3.times {
      counter += 40
      after(counter) { self.angle += 2 * dir }
      counter += 40
      after(counter) { self.angle -= 4 * dir }
    }
  end

  def fling(dir)
    @velocity_x = -3 * dir - rand(6)
    @velocity_y = -4 - rand(10)
  end

  def land
  end

  def update
    @x = @x + @velocity_x
    @y = @y + @velocity_y 
  end

#  def draw
#    super
#    @image.draw_rot(@x, @y, 20, @angle, @center_x, @center_y, 1.0, 1.0, @color)
#                   [@x, @y, @angle, @center_x, @center_y, @factor_x, @factor_y, @color.dup, @mode, @zorder]
#
#  end

end

class Chunk1 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk1.png"); end; end
class Chunk2 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk2.png"); end; end
class Chunk3 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk3.png"); end; end
class Chunk4 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk4.png"); end; end
class Chunk5 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk5.png"); end; end



class ChinguGem < Chingu::GameObject
  attr_reader :x, :y
  def setup
    @image = Gosu::Image.new(""+RBPTH + "chingu_gem.png")
    @growing = false
    @moving = false
  end

  def grow
    @growing = true
  end

  def move
    @moving = true
  end

  def update
    if @growing && @factor < 1
      self.factor += 0.005
    end
    if @moving && self.y > 300
      self.y -= 20
    end
  end

end




