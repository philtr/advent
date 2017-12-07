class SpiralMemory
  HEADINGS = {
    south: [ 0, -1],
    west:  [ 1,  0],
    north: [ 0,  1],
    east:  [-1,  0],
  }

  def initialize(address:)
    @address = address
  end

  def steps
    address_locations[@address-1].map(&:abs).reduce(:+)
  end

  def address_locations
    1.upto(@address).reduce([[], HEADINGS.values, 0, 0, [0,0]]) do |(space, heading, side_length, side_position, location), address|
      space << location

      if side_length == side_position
        heading.rotate!
        side_position = 0

        if [HEADINGS[:west], HEADINGS[:east]].include?(heading.first)
          side_length +=1
        end
      end

      next_location = [location, heading.first].transpose.map { |coord| coord.reduce(:+) }

      [space, heading, side_length, side_position += 1, next_location]
    end[0]
  end
end
