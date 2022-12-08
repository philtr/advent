require "matrix"

# using a matrix allows us to easily get the column. it's probably overkill
# f - forest
f = Matrix.rows($<.map{ _1.chomp.split('').map(&:to_i) })

# == part 1 ===================================================================
p (
  # find how many trees are visible from outside the grid
  f.to_a.reduce([0,0]) {|(n,i), r|
    # n - accumulated count of visible trees
    # i - current row index
    # r - current row array of numbers

    # all of this row is vilible if it's the first or last row
    next [n+r.size, i+1] if i==0 || i==(f.row_count-1)

    n = r.reduce([n,0]) {|(n,j), t|
      # n - still the total accumulated trees
      # j - current column index
      # t - current tree

      # get an array that represents the current column
      c = f.column(j).to_a

      next [n+1,j+1] if j==0||j==(c.size-1)

      # s - all trees in each direction
      s = [
        c[0..(i-1)],  # all trees north of here
        r[(j+1)..-1], # all trees east of here
        c[(i+1)..-1], # all trees south of here
        r[0..(j-1)],  # all trees west of here
      ]

      # this tree is considered to be visible if all of the trees in any
      # direction are shorter than this tree
      if s.any? {|d| d.all? { _1<t } }
        # if it's visible, add it to the count
        [n+1, j+1]
      else
        # move on to the next tree in this row
        [n, j+1]
      end
    }[0]

    # move on to the next row of trees in the forest
    [n, i+1]
  }[0]
)

# == part 2 ===================================================================
p (
  # find the tree with the highest scenic score
  f.to_a.reduce([0,0]) {|(max, i), r|
    # max - accumulated highest scenic score for any tree
    w = r.reduce([max,0]) {|(max,j), th|
      # max - accumulated highest scenic score for any tree
      # j   - current column index
      # th  - current tree height
      c = f.column(j).to_a

      next [max, j+1] if (j==0 || j==(c.size-1) || i==0 || i==(r.size-1))

      # s - all trees in each direction
      s = [
        c[0..(i-1)].reverse,  # all trees north of here
        r[(j+1)..-1],         # all trees east of here
        c[(i+1)..-1],         # all trees south of here
        r[0..(j-1)].reverse,  # all trees west of here
      ]

      # calculate scenic score for this tree by finding the product of the
      # viewing distance in each direction
      v = s.map {
        trees = _1.reduce([]) {|ts, t|
          # ts - accumulated visible trees looking this direction
          # t  - tree height of the next tree in this direction

          # add the next tree to the visible trees
          ts << t

          # break if it's the same height or taller than the current tree
          break ts if t >= th

          # keep accumulating
          ts
        }

        # the viewing distance for the current tree (th)
        trees.size
      }

      # scenic score is the product of the viewing distances in each direction
      ss = v.reduce(&:*)

      # take either the current score, or the max, whichever is larger, and move
      # on to the next tree in the row
      [[max,ss].max, j+1]
    }[0]

    # take either the highest score from this row or the max, whichever is
    # larger, and move on to the next row
    [[max,w].max, i+1]
  }[0]
)

