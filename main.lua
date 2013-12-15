local create_gof = require("gameoflife")

local gof
local last_tick = 0
local cell_height
local cell_width
local cell_ratio
local speed

local function parse_args(args)
  local args_name = {}
  for i, k in ipairs(args) do
    if (k:match("^\\-\\-")) then
      args_name[k] = args[i+1] or true
    end
  end
  
  if args_name["-h"] or args_name["--help"] then
    print([[
Options:
  --cell-ratio     the maximum cells added at the beginning of the game
  --cell-width     cell width in pixels
  --cell-height    cell height in pixels
  --speed          evolution speed (100 means one evolution per second)
  --help or -h     this message
    ]])
    
    os.exit()
  end

  cell_ratio = tonumber(args_name["--cell-ratio"]) or 33
  cell_width = tonumber(args_name["--cell-width"]) or 15
  cell_height = tonumber(args_name["--cell-height"]) or 15
  speed = tonumber(args_name["--speed"]) or 100
  
end

local function fill_with_cells()
  math.randomseed( os.time() )
  for i = 1, (gof.dimension.width * gof.dimension.width * (cell_ratio/100)) do
    gof:add_cell(math.random(gof.dimension.width),math.random(gof.dimension.width))
  end
end

function love.load(args)
  parse_args(args)
  
  gof = create_gof{
    width=math.floor(love.graphics.getWidth()/cell_width), 
    height=math.floor(love.graphics.getHeight()/cell_height)
  }
  
  fill_with_cells()
  
  love.graphics.setBackgroundColor(250,250,250)
  love.graphics.setColor(191,4,255)
end

function love.update(dt)
  last_tick = last_tick + (100 * dt)
  if last_tick > speed then
    last_tick = last_tick % speed
    gof:evolve()
  end
end

function love.draw()
  for x, y in gof:cells() do
    love.graphics.rectangle("fill", (x-1)*cell_width, (y-1)*cell_height, cell_width, cell_height)
  end
end
