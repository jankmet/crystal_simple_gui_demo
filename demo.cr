# (c) Jan Kmet 2015

require "crsfml"

class Ball
  LIMIT_TOP   =  55
  LIMIT_BOTOM = 585
  LIMIT_LEFT  =  55
  LIMIT_RIGHT = 900

  def initialize(pos_x : Number, pos_y : Number, step, scale = 0.3)
    box_texture = SF::Texture.from_file("crystal.png")
    @box = SF::Sprite.new(box_texture)
    @box.position = SF.vector2(pos_x, pos_y)

    @box.scale = SF.vector2(scale, scale)

    @dir = SF.vector2(step, step)

    @box.origin = SF.vector2(@box.local_bounds.width / 2, @box.local_bounds.height / 2)
  end

  def move
    @box.move(@dir)
    @box.rotate(1)

    if (@box.position.y > LIMIT_BOTOM)
      @box.position.y = LIMIT_BOTOM
      @dir.y = -1
    elsif (@box.position.y < LIMIT_TOP)
      @box.position.y = LIMIT_TOP
      @dir.y = 1
    end

    if (@box.position.x > LIMIT_RIGHT)
      @box.position.x = LIMIT_RIGHT
      @dir.x = -1
    elsif (@box.position.x < LIMIT_LEFT)
      @box.position.x = LIMIT_LEFT
      @dir.x = 1
    end
  end

  def draw(target, states)
    target.draw @box
  end
end

window = SF::RenderWindow.new(SF.video_mode(960, 640), "Simple GUI Dmeo")
window.clear SF::Color::Blue

wall_texture = SF::Texture.from_file("Brick.png")

(0..29).each do |coll|
  wall = SF::Sprite.new(wall_texture)
  wall.position = SF.vector2(coll * 32, 0)
  window.draw wall

  wall2 = wall.dup
  wall2.position = SF.vector2(coll * 32, 19 * 32 + 1)
  window.draw wall2
end

(2..19).each do |row|
  wall = SF::Sprite.new(wall_texture)
  wall.rotation = -90
  wall.position = SF.vector2(0, row * 32)
  window.draw wall

  wall2 = wall.dup
  wall2.position = SF.vector2(29 * 32, row * 32)
  wall2.rotation = -90
  window.draw wall2
end

balls = [] of Ball
balls << Ball.new(3 * 32, 4 * 32, 1)
balls << Ball.new(10 * 32, 8 * 32, 1.5, 0.24)
balls << Ball.new(18 * 32, 12 * 32, 2.0, 0.2)

eraser = SF::RectangleShape.new(SF.vector2(28 * 32, 18 * 32))
eraser.position = SF.vector2(32, 32)
eraser.fill_color = SF::Color::Blue

while window.open?
  while event = window.poll_event
    case event.type
    when SF::Event::KeyPressed
      case event.key.code
      when SF::Keyboard::Escape
        window.close
      end
    when SF::Event::Closed
      window.close
    end
  end

  sleep(0.004)

  window.draw eraser

  balls.each do |ball|
    ball.move
    window.draw ball
  end

  window.display
end
