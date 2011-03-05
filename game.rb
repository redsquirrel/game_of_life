require "set"

def step(living)
  universe = all_cells(living)
  dead = universe - living
  new_living = dead.select(&find_zombies(living))
  new_living += living.select(&find_survivors(living))
  Set.new(new_living)
end

def all_cells(living)
  living.inject(Set.new) do |universe, cell|
    universe + neighbors_for(cell) + [cell]
  end
end

def find_zombies(living)
  find_living_cells(living, false)
end

def find_survivors(living)
  find_living_cells(living, true)
end

def find_living_cells(living, currently_alive)
  lambda { |cell| alive?(live_neighbor_count(cell, living), currently_alive) }
end

def alive?(live_neighbor_count, currently_alive)
  if currently_alive
    live_neighbor_count == 2 || live_neighbor_count == 3
  else
    live_neighbor_count == 3
  end
end

def live_neighbor_count(cell, living)
  Set.new(neighbors_for(cell)).intersection(living).size
end

def neighbors_for(cell)
  x, y = cell
  [ [x - 1, y - 1],
    [x,     y - 1],
    [x + 1, y - 1],
    [x - 1, y],
    [x + 1, y],
    [x - 1, y + 1],
    [x,     y + 1],
    [x + 1, y + 1] ]
end
