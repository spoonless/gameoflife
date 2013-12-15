
local gameoflife = {}
gameoflife.__index = gameoflife

local function new_gameoflife(dimension)
  local gol = {dimension=dimension}
  gol.board = {}
  setmetatable(gol, gameoflife)
  return gol
end

function gameoflife:normalize_position(x, y)
  x = (x - 1 + self.dimension.width) % self.dimension.width
  y = (y - 1 + self.dimension.height) % self.dimension.height
  return x+1, y+1
end

function gameoflife:compute_index(x, y)
  x, y = self:normalize_position(x, y)
  return ((x -1) * self.dimension.height) + y
end

function gameoflife:add_cell(x, y)
    self.board[self:compute_index(x, y)] = true
end

function gameoflife:is_cell(x, y)
    return self.board[self:compute_index(x, y)]
end

function gameoflife:count_neighbours(x, y)
  local count = 0
  
  count = self:is_cell(x-1, y-1) and count+1 or count
  count = self:is_cell(x-1, y) and count+1 or count
  count = self:is_cell(x-1, y+1) and count+1 or count
  count = self:is_cell(x, y-1) and count+1 or count
  count = self:is_cell(x, y+1) and count+1 or count
  count = self:is_cell(x+1, y-1) and count+1 or count
  count = self:is_cell(x+1, y) and count+1 or count
  count = self:is_cell(x+1, y+1) and count+1 or count

  return count
end

function gameoflife:cells()
  local index = nil
  return function ()
    index = next(self.board, index)
    if index then
      return math.floor((index / self.dimension.height) + 1), (index - 1) % self.dimension.height + 1
    end
  end
end

function gameoflife:evolve()
  local new_board = {}
  for x = 1, self.dimension.width do
    for y = 1, self.dimension.height  do
      local nb_neighbours = self:count_neighbours(x, y)
      local index = self:compute_index(x, y)
      if nb_neighbours == 2 then
        new_board[index] = self.board[index]
      elseif nb_neighbours == 3 then
        new_board[index] = true
      end
    end
  end
  self.board = new_board
end

return new_gameoflife