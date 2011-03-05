require "set"

def step(living)
  universe = all_cells(living)
  dead = universe - living
  new_living = dead.select(&find_living_cells_among_the_dead(living))
  new_living += living.select(&find_living_cells_among_the_living(living))
  Set.new(new_living)
end

def all_cells(living)
  living.inject(Set.new) do |universe, cell|
    universe + neighbors_for(cell) + [cell]
  end
end

def find_living_cells_among_the_dead(living)
  find_living_cells(living, false)
end

def find_living_cells_among_the_living(living)
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
  my_x, my_y = cell
  neighbors = []
  SHIFTERS.each do |y|
    SHIFTERS.each do |x|
      neighbors << [my_x + x, my_y + y]
    end
  end
  neighbors - [cell]
end

SHIFTERS = [-1, 0, 1]