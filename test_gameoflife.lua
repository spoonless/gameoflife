local luaunit = require("luaunit")
local create_gof = require("gameoflife")

test_gameoflife = {}

function test_gameoflife:setUp()
  self.gof = create_gof{width=10, height=20} 
end

function test_gameoflife:test_add_cell()
  self.gof:add_cell(1,1)
  assert_equals(self.gof:is_cell(1,1), true)

  self.gof:add_cell(2,1)
  assert_equals(self.gof:is_cell(2,1), true)
end

function test_gameoflife:test_add_cell_beyond_boundaries()
  self.gof:add_cell(11,1)
  assert_equals(self.gof:is_cell(1,1), true)

  self.gof:add_cell(0,1)
  assert_equals(self.gof:is_cell(10,1), true)
end

function test_gameoflife:test_count_neighbours()
  self.gof:add_cell(5,5)

  assert_equals(self.gof:count_neighbours(self.gof:compute_index(5,5)), 0)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(4,4)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(4,5)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(4,6)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(5,4)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(5,6)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(6,4)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(6,5)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(6,6)), 1)
end

function test_gameoflife:test_count_neighbours_beyond_boundaries()
  self.gof:add_cell(0,0)

  assert_equals(self.gof:count_neighbours(self.gof:compute_index(0,0)), 0)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(0,1)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(1,0)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(1,1)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(9,19)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(9,0)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(9,1)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(0,19)), 1)
  assert_equals(self.gof:count_neighbours(self.gof:compute_index(1,19)), 1)
end

function test_gameoflife:test_evolve_and_cell_die()
  self.gof:add_cell(1,1)
  self.gof:evolve()
  
  assert_nil(self.gof:is_cell(1,1))
end

function test_gameoflife:test_evolve()
  self.gof:add_cell(4,5)
  self.gof:add_cell(5,5)
  self.gof:add_cell(6,5)

  self.gof:evolve()
  
  assert_nil(self.gof:is_cell(4,5))
  assert_nil(self.gof:is_cell(6,5))
  assert_boolean(self.gof:is_cell(5,5))
  assert_boolean(self.gof:is_cell(5,4))
  assert_boolean(self.gof:is_cell(5,6))
end

luaunit:run()