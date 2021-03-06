module CyberarmEngine
  class Renderer
    attr_reader :opengl_renderer, :bounding_box_renderer

    def initialize
      @bounding_box_renderer = BoundingBoxRenderer.new
      @opengl_renderer = OpenGLRenderer.new(width: $cyberarm_engine_window.width, height: $cyberarm_engine_window.height)
    end

    def draw(camera, lights, entities)
      @opengl_renderer.render(camera, lights, entities)
      @bounding_box_renderer.render(entities) if @show_bounding_boxes
    end

    def canvas_size_changed
      @opengl_renderer.canvas_size_changed
    end

    def finalize # cleanup
    end
  end
end
