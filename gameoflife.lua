
local gameoflife = {}
gameoflife.__index = gameoflife

local function new_gameoflife(dimension)
  local gol = {dimension=dimension}
  gol.board = {}
  setmetatable(gol, gameoflife)
  return gol
end

function gameoflife:neighbours(i)
  local x = i % self.dimension.width
  local grid_size = self.dimension.width * self.dimension.height
  local left_delta = (x == 0) and self.dimension.width or 0
  local right_delta = (x == self.dimension.width -1) and -self.dimension.width or 0
  
  return {
    (i + grid_size + left_delta - self.dimension.width - 1) % grid_size,
    (i + grid_size - self.dimension.width) % grid_size,
    (i + grid_size + right_delta - self.dimension.width + 1) % grid_size,

    (i + left_delta - 1) % grid_size,
    (i + right_delta + 1) % grid_size,
    
    (i + left_delta + self.dimension.width - 1) % grid_size,
    (i + self.dimension.width) % grid_size,
    (i + right_delta + self.dimension.width + 1) % grid_size,
  }
end

function gameoflife:count_neighbours(i)
  local count = 0
  for _, i in pairs(self:neighbours(i)) do
    if self.board[i] then
      count = count + 1
    end
  end
  return count
end

function gameoflife:compute_index(x, y)
  x = (x + self.dimension.width) % self.dimension.width
  y = (y + self.dimension.height) % self.dimension.height
  return (y * self.dimension.width) + x
end

function gameoflife:add_cell(x, y)
  self.board[self:compute_index(x, y)] = true
end

function gameoflife:is_cell(x, y)
  return self.board[self:compute_index(x, y)]
end

function gameoflife:cells()
  local index = nil
  return function ()
    index = next(self.board, index)
    if index then
      return (index) % self.dimension.width, math.floor((index / self.dimension.width)) 
    end
  end
end

function gameoflife:evolve()
  local new_board = {}
  for i, _ in pairs(self.board) do
    local nb_neighbours = 0
    for _, neighbour_index in pairs(self:neighbours(i)) do
      if self.board[neighbour_index] then
        nb_neighbours = nb_neighbours + 1
      elseif not new_board[neighbour_index] and self:count_neighbours(neighbour_index) == 3 then
        new_board[neighbour_index] = true
      end
    end
    if nb_neighbours == 2 or nb_neighbours == 3 then
      new_board[i] = true
    end
  end
  self.board = new_board
end

return new_gameoflife