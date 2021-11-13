#
#
#     RESURRECTION OBJECTS
#
#

# RBPTH = "chingu/rebirth_assets/"

class Rift < Chingu::GameObject
  trait :timer
  def tremble
    self.factor = 1.1
    after(400) { self.factor = 0.9 }
    after(480) { self.factor = 1.1 }
    after(900) { self.factor = 1.2 }
    after(950) { self.factor = 1.0 }
    after(1050) { self.factor = 1.2 }
    after(1350) { self.factor = 1.1 }
    after(1400) { self.factor = 1.3 }
    after(1450) { self.factor = 1.0 }
    after(1500) { self.factor = 1.4 }
  end
  def tremble1
    after(70) { tremble }
  end
  def tremble2
    tremble
  end
  def tremble3
    trembling
#    after(1000) { trembling }
  end

  def trembling
    self.factor = 1.4
    counter = 0
    5.times {
      counter += 40
      after(counter) { self.factor = 1.5 }
      counter += 40
      after(counter) { self.factor = 1.4 }
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
    @rand_x = 40
    @rand_y = 30
  end

  def shaking(dir)
    counter = 0
    5.times {
      counter += 40
      after(counter) { self.angle -= 5 * dir }
      counter += 40
      after(counter) { self.angle += 4 * dir }
    }
  end

  def shake(dir)
    shaking(dir)
#    after(1000) { shaking(dir) }
  end

  def fling(dir)
    @velocity_x = -rand(@rand_x) * dir
    @velocity_y = -rand(@rand_y) - 20
  end

  def land
  end

  def update
    @x = @x + @velocity_x
    @y = @y + @velocity_y 
  end

end

class Chunk1 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk1.png"); end; end
class Chunk2 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk2.png"); end; end
class Chunk3 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk3.png"); end; end
class Chunk4 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk4.png"); end; end
class Chunk5 < Chunk; def setup; super; @image = Gosu::Image.new(""+RBPTH+"chunk5.png"); end; end



class ChinguGem < Chingu::GameObject
#  attr_reader :x, :y
  trait :timer
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

  def shake
    counter = 0
    5.times {
      counter += 40
      after(counter) { self.angle -= 15 }
      counter += 40
      after(counter) { self.angle += 15 }
    }
  end

  def update
    if @growing && @factor < 1.3
      self.factor += 0.035
    end
    if @moving && self.y > 300
      self.y -= 10
    end
  end

end




