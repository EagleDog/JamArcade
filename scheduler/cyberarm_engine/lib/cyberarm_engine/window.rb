module CyberarmEngine
  class Window < Chingu::GameState
    include Common

    IMAGES = {}
    SAMPLES = {}
    SONGS = {}

    attr_accessor :show_cursor
    attr_writer :exit_on_opengl_error
    attr_reader :last_frame_time

    def self.now
      Gosu.milliseconds
    end

    def self.dt
      $cyberarm_engine_window.last_frame_time / 1000.0
    end

    def initialize(*options)
      @show_cursor = false

      # super(width, height, fullscreen: fullscreen, update_interval: update_interval, resizable: resizable, borderless: borderless)
      super(*options)
      $cyberarm_engine_window = self
      @last_frame_time = Gosu.milliseconds - 1
      @current_frame_time = Gosu.milliseconds

      $window.cursor = true

      @states = []
      @exit_on_opengl_error = false

      setup if defined?(setup)
    end

    def draw
      current_state.draw if current_state
    end

    def update
      Stats.clear

      current_state.update if current_state
      @last_frame_time = Gosu.milliseconds - @current_frame_time
      @current_frame_time = Gosu.milliseconds
    end

    def needs_cursor?
      @show_cursor
    end

    def dt
      @last_frame_time / 1000.0
    end

    def aspect_ratio
      width / height.to_f
    end

    def exit_on_opengl_error?
      @exit_on_opengl_error
    end

    def button_down(id)
      super
      current_state.button_down(id) if current_state
    end

    def button_up(id)
      super
      current_state.button_up(id) if current_state
    end

    def push_state(klass, options = {})
      options = { setup: true }.merge(options)

      if klass.instance_of?(klass.class) && defined?(klass.options)
        @states << klass
        klass.setup if options[:setup]
        klass.post_setup if options[:setup]
      else
        @states << klass.new(options) if child_of?(klass, GameState)
        @states << klass.new if child_of?(klass, Element::Container)
        current_state.setup if current_state.instance_of?(klass) && options[:setup]
        current_state.post_setup if current_state.instance_of?(klass) && options[:setup]
      end
    end

    private def child_of?(input, klass)
      input.ancestors.detect { |c| c == klass }
    end

    def current_state
      @states.last
    end

    def previous_state
      if @states.size > 1 && (state = @states[@states.size - 2])
        state
      end
    end

    def pop_state
      @states.pop
    end

    def shift_state
      @states.shift
    end

    def width
      $window.width
    end

    def height
      $window.height
    end

    def caption=(string)
      $window.caption = string
    end

    def mouse_x
      $window.mouse_x
    end

    def mouse_y
      $window.mouse_y
    end

    def button_down?(id)
      Gosu.button_down?(id)
    end

    def text_input
      $window.text_input
    end

    def text_input=(text_input)
      $window.text_input = text_input
    end

    # Sourced from https://gist.github.com/ippa/662583
    def draw_circle(cx, cy, r, z = 9999, color = Gosu::Color::GREEN, step = 10)
      0.step(360, step) do |a1|
        a2 = a1 + step
        draw_line(cx + Gosu.offset_x(a1, r), cy + Gosu.offset_y(a1, r), color, cx + Gosu.offset_x(a2, r),
                  cy + Gosu.offset_y(a2, r), color, z)
      end
    end
  end
end
