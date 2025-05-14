require 'ruby2d'

set resizable: true
set background: 'navy'
set title: 'Mini-golf heroes'
set fullscreen: true
set width: 1920
set height: 1080

@dotted_line = []
@opposite_line = nil
@dragging = false
$playing = true
$won = false
$main_menu = false
$menu = false
$music_on = true

$background_music = Music.new('monkeys_spinning_monkeys.mp3')
$background_music.loop = true
$background_music.play


# creating obstacles






class Ball
  attr_accessor :x_pos, :y_pos, :angle, :speed, :moving, :hits, :ball
  
  
  def initialize(x_pos, y_pos)
    @x_pos = x_pos
    @y_pos = y_pos
    @angle = 0
    @speed = 0
    @moving = false

    @ball = Circle.new(
      x: x_pos, y: y_pos,
      radius: 10, 
      z: 1000,
      color: 'white'
    )

    @hits = 0
  end

  def radius()
    return @ball.radius
  end

  def x()
    return @ball.x
  end

  def y()
    return @ball.y
  end

  def hit (x1, y1, x2, y2)
    dx = x2 - x1
    dy = y2 - y1

    @speed = Math.sqrt(dx**2 + dy**2) / 20.0
    @angle = Math.atan2(dy, dx) + Math::PI

    @moving = true
    @hits += 1
  end
  
  def update(block_arr)
    return unless @moving

    steps = 20
    i = 0
    while i < 20

      block_arr.each do |block|
        if collision?(block)
          bounce(block)
        end
      end

      @x_pos += Math.cos(@angle) * @speed / steps
      @y_pos += Math.sin(@angle) * @speed / steps

      @ball.x = @x_pos
      @ball.y = @y_pos      

      i+=1
    end

    # Speed reduction from moving, friction and air resistance. 
    if @speed > 0
      @speed -= 0.02
      @speed *= 0.985
    end
    
    # if it moves at a negative speed, stop moving.
    if @speed <= 0
      @speed = 0
      @moving = false
    end
  end

  def collision?(block)
    step_x = Math.cos(@angle) * @speed 
    step_y = Math.sin(@angle) * @speed 

   
    next_x_pos = @x_pos + step_x 
    next_y_pos = @y_pos + step_y 

    if !block.contains?(@x_pos, @y_pos) && next_x_pos > block.x - @ball.radius && next_x_pos < block.x + block.width + @ball.radius &&
      next_y_pos > block.y - @ball.radius && next_y_pos < block.y + block.height + @ball.radius
      return true
    end

    return false
  end

  def bounce(block)
    # Normalize the angle to be within 0 to 360 degrees
    @angle %= 360
    while @angle < 0
      @angle += 360
    end

    # Check if the collision is horizontal or vertical
    if ((block.y - @ball.radius) < @y_pos && (block.y + block.height + @ball.radius) > @y_pos)
      @angle = Math::PI - @angle
    elsif ((block.x - @ball.radius) < @x_pos && (block.x + block.width + @ball.radius) > @x_pos)
      @angle = -@angle
    end

    # Reduce speed to simulate energy loss on bounce
    @speed *= 0.7
  end

  def stop()
    @speed = 0
    @moving = false
  end

  def set_position(x, y)
    @x_pos = x
    @y_pos = y
    @ball.x = x
    @ball.y = y
  end
end


# Funktioner för att skapa banor
def course_1()
  $ball = Ball.new(300, 540)

  $goal = Circle.new(
    x: 1500, y: 540, 
    radius: 15, 
    sectors: 32, 
    color: 'black', 
    z: 100
  )

  $block_arr = []
  $block_arr << Rectangle.new(x: 80, y: 80, width: 1760, height: 350, color: 'lime') # Hinder 1
  $block_arr << Rectangle.new(x: 80, y: 650, width: 1760, height: 350, color: 'lime')    # Hinder 2
  $block_arr << Rectangle.new(x: 80, y: 430, width: 120, height: 220, color: 'lime')     # Hinder 3
  #block_arr << Rectangle.new(x: 1000, y: 600, width: 200, height: 200, color: 'lime')  # Hinder 4
  

  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
end

def course_2()
  $ball = Ball.new(240, 840)

  $goal = Circle.new(
    x: 1720, y: 200, 
    radius: 15, 
    sectors: 32, 
    color: 'black', 
    z: 100
  )

  # skapar väggar och hinder

  $block_arr = []

  $block_arr << Rectangle.new(x: 200, y: 200, width: 200, height: 200, color: 'lime') 
  $block_arr << Rectangle.new(x: 400, y: 400, width: 400, height: 680, color: 'lime')    
  $block_arr << Rectangle.new(x: 1200, y: 80, width: 400, height: 720, color: 'lime')  
  $block_arr << Rectangle.new(x: 800, y: 500, width: 200, height: 200, color: 'lime')  
  $block_arr << Rectangle.new(x: 1100, y: 700, width: 100, height: 100, color: 'lime')  

  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20) 
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20) 
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20) 

end

def course_3()
  $ball = Ball.new(200, 640)

  $goal = Circle.new(
    x: 1500, y: 200, 
    radius: 15, 
    sectors: 32, 
    color: 'black', 
    z: 100
  )

  $block_arr = []
  $block_arr << Rectangle.new(x: 80, y: 80, width: 1300, height: 400, color: 'lime') # Hinder 1
  $block_arr << Rectangle.new(x: 1640, y: 80, width: 200, height: 400, color: 'lime')    # Hinder 2
  $block_arr << Rectangle.new(x: 80, y: 800, width: 1760, height: 200, color: 'lime')     # Hinder 3
  $block_arr << Rectangle.new(x: 1000, y: 600, width: 200, height: 200, color: 'lime')  # Hinder 4
  $block_arr << Rectangle.new(x: 500, y: 450, width: 200, height: 200, color: 'lime')  # Kant

  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
end

def course_4()
  $ball = Ball.new(200, 875)

  $goal = Circle.new(
    x: 1780, y: 140, 
    radius: 15, 
    sectors: 32, 
    color: 'black', 
    z: 100
  )

  $block_arr = []

  $block_arr << Rectangle.new(x: 80, y: 550, width: 1500, height: 200, color: 'lime') # Hinder 1
  $block_arr << Rectangle.new(x: 300, y: 200, width: 1540, height: 200, color: 'lime')    # Hinder 2
  
  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
end

def course_5()
  $ball = Ball.new(120, 875)

  $goal = Circle.new(
    x: 1780, y: 140, 
    radius: 15, 
    sectors: 32, 
    color: 'black', 
    z: 100
  )

  $block_arr = []

  $block_arr << Rectangle.new(x: 1100, y: 100, width: 300, height: 400, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 180, y: 780, width: 70, height: 400, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 600, y: 500, width: 400, height: 100, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 1000, y: 450, width: 50, height: 30, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 1100, y: 700, width: 600, height: 50, color: 'lime') # Hinder
  $block_arr << Rectangle.new(x: 1600, y: 80, width: 100, height: 300, color: 'lime') # Hinder
  $block_arr << Rectangle.new(x: 800, y: 300, width: 100, height: 600, color: 'lime') # Hinder
  $block_arr << Rectangle.new(x: 150, y: 400, width: 400, height: 50, color: 'lime') # Hinder 
  
  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
end

def course_6()
  $ball = Ball.new(200, 900)

  $goal = Circle.new(
    x: 1750, y: 900, 
    radius: 15, 
    sectors: 32, 
    color: 'fuchsia', 
    z: 100
  )

  $block_arr = []

  $block_arr << Rectangle.new(x: 80, y: 80, width: 320, height: 720, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 400, y: 80, width: 400, height: 400, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 600, y: 650, width: 400, height: 350, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 1000, y: 250, width: 500, height: 750, color: 'lime') # Hinder 
  $block_arr << Rectangle.new(x: 1600, y: 600, width: 150, height: 200, color: 'lime') # Hinder 

  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
end

def course_7()
  $ball = Ball.new(1000, 500) # Starting position of the ball

  $goal = Circle.new(
    x: 240, y: 240, 
    radius: 15, 
    sectors: 32, 
    color: 'fuchsia', 
    z: 100
  )

  $block_arr = []

  $block_arr << Rectangle.new(x: 400, y: 80, width: 400, height: 720, color: 'lime') # Hinder
  $block_arr << Rectangle.new(x: 800, y: 700, width: 400, height: 100, color: 'lime') # Hinder
  $block_arr << Rectangle.new(x: 1200, y: 300, width: 200, height: 500, color: 'lime') # Hinder
  $block_arr << Rectangle.new(x: 1700, y: 80, width: 140, height: 920, color: 'lime') # Hinder

  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  
end

def course_8()
  $ball = Ball.new(200, 640)

  $goal = Circle.new(
    x: 1500, y: 200, 
    radius: 15, 
    sectors: 32, 
    color: 'fuchsia', 
    z: 100
  )

  $block_arr = []

  
  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
end

def course_9()
  $ball = Ball.new(200, 640)

  $goal = Circle.new(
    x: 1500, y: 200, 
    radius: 15, 
    sectors: 32, 
    color: 'fuchsia', 
    z: 100
  )

  $block_arr = []

  
  $block_arr << Rectangle.new(x: 0, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 0, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 1840, y: 0, width: 80, height: 1080, color: 'lime', z: 20)  # Kant
  $block_arr << Rectangle.new(x: 0, y: 1000, width: 1920, height: 80, color: 'lime', z: 20)  # Kant
end

def menu()
  $menu = true
  $playing = false
  $main_menu = false
  @dragging = false
  @dotted_line.each(&:remove)
  @dotted_line.clear
  @opposite_line&.remove

  $back_to_game = Rectangle.new(x: 850, y: 100, width: 320, height: 100, color: 'white', z: 20)
  $options = Rectangle.new(x: 850, y: 250, width: 320, height: 100, color: 'white', z: 20)
  $main_menu_block = Rectangle.new(x: 850, y: 400, width: 320, height: 100, color: 'white', z: 20)
  $close_window = Rectangle.new(x: 850, y: 550, width: 320, height: 100, color: 'white', z: 20)

  $back_to_game_text = Text.new('Back to game', x: 920, y: 130, size: 30, color: 'black', z: 30)
  $options_text = Text.new('Options', x: 960, y: 280, size: 30, color: 'black', z: 30)
  $main_menu_text = Text.new('Main Menu', x: 940, y: 430, size: 30, color: 'black', z: 30)
  $close_window_text = Text.new('Exit Game', x: 950, y: 580, size: 30, color: 'black', z: 30)
end

def win(hits)
  win_sound = Sound.new('yippee-tbh.mp3')
  win_sound.play
  $win_text_1 = Text.new(
    'You Won',
    x: 150, y: 170,
    style: 'bold',
    size: 50,
    color: 'blue',
    z: 20
  )
  $win_text_2 = Text.new(
    "You used #{hits} hits ",
    x: 150, y: 270,
    style: 'bold',
    size: 50,
    color: 'blue',
    z: 20
  )
  $playing = false
end

def options()
  $menu = false
  @options = true

  $back_to_game.remove
  $options.remove
  $main_menu_block.remove
  $close_window.remove

  $back_to_game_text.remove
  $options_text.remove
  $main_menu_text.remove
  $close_window_text.remove

  $music = Rectangle.new(x: 850, y:100, width: 320, height: 100, color: 'white', z: 20)
  $master_volume = Rectangle.new(x: 850, y:250, width: 320, height: 100, color: 'white', z: 20)
  $back = Rectangle.new(x: 850, y:400, width: 320, height: 100, color: 'white', z: 20)

  $music_text = Text.new("Music: #{$music_on ? 'On' : 'Off'}", x: 920, y: 130, size: 30, color: 'black', z: 30)
  $back_text = Text.new('back', x: 950, y: 430, size: 30, color: 'black', z: 30)

  $slider_bar = Rectangle.new(x: 850, y: 250, width: 320, height: 10, color: 'gray', z: 20)
  $slider_knob = Rectangle.new(x: 850 + $background_music.volume * 3, y: 240, width: 20, height: 30, color: 'white', z: 30)
  $volume_text = Text.new("Volume: #{($background_music.volume).to_i}%", x: 920, y: 280, size: 30, color: 'black', z: 30)
end

def main_menu(block_arr)
  $hits = 0
  $menu = false
  $playing = false
  $main_menu = true

  # Remove previous menu elements
  $back_to_game&.remove
  $options&.remove
  $main_menu_block&.remove
  $close_window&.remove
  $back_to_game_text&.remove
  $options_text&.remove
  $main_menu_text&.remove
  $close_window_text&.remove

  block_arr.each(&:remove)
  $ball.ball.remove
  $goal.remove

  # Define grid layout for courses
  courses = [
    { name: 'Course 1', action: -> { course_1() } },
    { name: 'Course 2', action: -> { course_2() } },
    { name: 'Course 3', action: -> { course_3() } },
    { name: 'Course 4', action: -> { course_4() } },
    { name: 'Course 5', action: -> { course_5() } },
    { name: 'Course 6', action: -> { course_6() } },
    { name: 'Course 7', action: -> { course_7() } },
    { name: 'Course 8', action: -> { course_8() } },
    { name: 'Course 9', action: -> { course_9() } }
  ]

  # Grid settings
  grid_columns = 3
  button_width = 300
  button_height = 100
  button_spacing = 50
  start_x = 460
  start_y = 250

  # buttons for each course
  $buttons = []
  courses.each_with_index do |course, index|
    row = index / grid_columns
    col = index % grid_columns

    x = start_x + col * (button_width + button_spacing)
    y = start_y + row * (button_height + button_spacing)

    button = Rectangle.new(x: x, y: y, width: button_width, height: button_height, color: 'white', z: 20)
    text = Text.new(course[:name], x: x + 50, y: y + 30, size: 30, color: 'black', z: 30)

    $buttons << { button: button, text: text, action: course[:action] }  #create a hash for each button
  end

  # Exit button
  exit_button = Rectangle.new(x: (start_x + button_width + button_spacing), y: start_y + 3.5 * (button_height + button_spacing), width: button_width, height: button_height, color: 'white', z: 20)
  exit_text = Text.new('Exit Game', x: (start_x + 50 + button_width + button_spacing), y: start_y + 3.5 * (button_height + button_spacing) + 30, size: 30, color: 'black', z: 30)

  $exit_button = {button: exit_button, text: exit_text, action: -> {close}} #create a hash for the exit button and text
  
end


# Mouse Release Event (Stop Dragging)
on :mouse_up do |event|
  if event.button == :left && @dragging && $playing
    $ball.hit($ball.x, $ball.y, event.x, event.y)

    @dragging = false

    # Remove existing lines when releasing mouse button
    @dotted_line.each(&:remove)
    @dotted_line.clear
    @opposite_line&.remove
    @opposite_line = nil
  end

  @dragging_slider = false
end

# Mouse Drag Event (Update Lines)
on :mouse_move do |event|
  if @dragging && $playing
    # Remove old lines
    @dotted_line.each(&:remove)
    @dotted_line.clear
    @opposite_line&.remove

    # Calculate opposite point (1.5x distance)
    dx = event.x - $ball.x
    dy = event.y - $ball.y
    opposite_x = $ball.x - 1.5 * dx
    opposite_y = $ball.y - 1.5 * dy

    # Draw a solid red line (1.5x longer in the opposite direction)
    @opposite_line = Line.new(
      x1: $ball.x, y1: $ball.y,
      x2: opposite_x, y2: opposite_y,
      width: 3,
      color: 'red',
      z: 20
    )

    # Draw a dotted yellow line (from mouse to ball)
    dot_count = 8
    step_x = dx / dot_count.to_f
    step_y = dy / dot_count.to_f

    dot_count.times do |i|
      @dotted_line << Circle.new(
        x: $ball.x + step_x * i,
        y: $ball.y + step_y * i,
        radius: 3,
        color: 'yellow',
        z: 15
      )
    end
  elsif @dragging_slider
    # Constrain the slider knob within the slider bar
    new_x = [[event.x, $slider_bar.x].max, $slider_bar.x + $slider_bar.width - $slider_knob.width].min
    $slider_knob.x = new_x

    # Calculate the volume based on the knob's position
    $background_music.volume = (($slider_knob.x - $slider_bar.x) / ($slider_bar.width - $slider_knob.width).to_f) * 100.0

    # Update the volume text
    $volume_text.text = "Volume: #{($background_music.volume).to_i}%"
  end
end

on :key_down do |event|
  if event.key == 'escape'
    if $menu
      $menu = false
      $playing = true
      $back_to_game.remove
      $options.remove
      $main_menu_block.remove
      $close_window.remove

      $back_to_game_text.remove
      $options_text.remove
      $main_menu_text.remove
      $close_window_text.remove
    elsif $playing || $won
      if $won
        $win_text_1.remove
        $win_text_2.remove
      end
      menu()
      $won = false

    elsif @options
      @options = false
      $music.remove
      $back.remove
      $music_text.remove
      $back_text.remove
      $slider_bar.remove
      $slider_knob.remove
      $volume_text.remove
      $master_volume.remove

      menu()
    end
  end
end


on :mouse_down do |event|

  if  event.button == :left && ((event.x - $ball.x) ** 2 + (event.y - $ball.y) ** 2 <= $ball.radius ** 2) && $playing
    @dragging = true
  elsif event.button == :left && $menu
    if $back_to_game.contains?(event.x, event.y)
      $menu = false
      $playing = true

      $back_to_game.remove
      $options.remove
      $main_menu_block.remove
      $close_window.remove

      $back_to_game_text.remove
      $options_text.remove
      $main_menu_text.remove
      $close_window_text.remove

    elsif $options.contains?(event.x, event.y)
      options()
    elsif $main_menu_block.contains?(event.x, event.y)
      main_menu($block_arr)
    elsif $close_window.contains?(event.x, event.y)
      close()
    end
  elsif event.button == :left && @options

    if $music.contains?(event.x, event.y)
      # Toggle music on/off
      $music_on = !$music_on
      if $music_on
        $background_music.play
      else
        $background_music.pause
      end
      $music_text.text = "Music: #{$music_on ? 'On' : 'Off'}"

    elsif $back.contains?(event.x, event.y)
      # Go back to the menu
      @options = false
      $music.remove
      $back.remove
      $music_text.remove
      $back_text.remove
      $slider_bar.remove
      $slider_knob.remove
      $volume_text.remove
      $master_volume.remove
      menu()

    elsif $slider_knob.contains?(event.x, event.y)
      @dragging_slider = true
    end
  elsif event.button == :left && $main_menu
    # Check if any course button is clicked
    $buttons.each do |btn|
      if btn[:button].contains?(event.x, event.y)
        # Remove all menu elements
        $buttons.each do |btn|
          btn[:button].remove
          btn[:text].remove
        end
        $exit_button[:button].remove
        $exit_button[:text].remove

        # change course 
        $main_menu = false
        $playing = true
        block_arr = btn[:action].call
        
      elsif $exit_button[:button].contains?(event.x, event.y)
        $exit_button[:action].call #exit the game
      end
    end
  end
end

course_1()

update do
  if $goal.contains?($ball.x, $ball.y) && $ball.speed < 4 && $playing
    win($ball.hits)
    $ball.set_position($goal.x, $goal.y)
    $ball.stop
    $won = true
  end
  $ball.update($block_arr)
end
show