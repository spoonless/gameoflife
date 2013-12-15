
function love.conf(t)
  t.console = false                  -- Attach a console (boolean, Windows only)
  t.title = "Game of life" 

  if t.window then
    t.window.title = t.title           -- The window title (string)
    t.window.icon = nil                -- Filepath to an image to use as the window's icon (string)
    t.window.width = 800               -- The window width (number)
    t.window.height = 600              -- The window height (number)
    t.window.resizable = false         -- Let the window be user-resizable (boolean)
    t.window.fullscreen = false        -- Enable fullscreen (boolean)
    t.window.vsync = true              -- Enable vertical sync (boolean)
  end
  
  if t.screen then
    t.screen.width = 800        -- The window width (number)
    t.screen.height = 600       -- The window height (number)
    t.screen.fullscreen = false -- Enable fullscreen (boolean)
    t.screen.vsync = true       -- Enable vertical sync (boolean)
    t.screen.fsaa = 0           -- The number of FSAA-buffers (number)
  end
  
  t.modules.audio = false             -- Enable the audio module (boolean)
  t.modules.event = true             -- Enable the event module (boolean)
  t.modules.graphics = true          -- Enable the graphics module (boolean)
  t.modules.image = true             -- Enable the image module (boolean)
  t.modules.joystick = false          -- Enable the joystick module (boolean)
  t.modules.keyboard = true          -- Enable the keyboard module (boolean)
  t.modules.math = true              -- Enable the math module (boolean)
  t.modules.mouse = true             -- Enable the mouse module (boolean)
  t.modules.physics = false           -- Enable the physics module (boolean)
  t.modules.sound = false             -- Enable the sound module (boolean)
  t.modules.system = true            -- Enable the system module (boolean)
  t.modules.timer = true             -- Enable the timer module (boolean)
  t.modules.window = true            -- Enable the window module (boolean)
end