F,C,V,E=[
                                # F is for FOREST
                                # =================================================================
  $<.map{                       # for each line in STDIN, accumulate the return of this block
    _1                          # numbered argument, in this case the line of input
      .chomp                    # trim any trailing newlines
      .chars                    # turn this line into an array of characters
      .map(&:to_i)              # parse each item into an integer
  },

                                # C is for COLUMN
                                # =================================================================
  ->(j){                        # j - column index
    F.map{                      # for each row in the FOREST
      _1[j]                     #   find the element at the column index j
    }
  },

                                # V is for VIEWS from here
                                # =================================================================
  ->(i,j,r,c){                  # i - current row index
                                # j - current column index
                                # r - current row of trees
                                # c - current column of trees
    [
      r[0..(j-1)].reverse,      # all trees westward (in order of sight)
      r[(j+1)..-1],             # all trees eastward
      c[0..(i-1)].reverse,      # all trees northward (in order of sight)
      c[(i+1)..-1]              # all trees southward
    ]
  },

                                # E is for EDGE
                                # =================================================================
  ->(i,j){                      # i - current row index
                                # j - current column index

                                # this is an edge if:
    i==0 ||                     # we are on the northernmost row of trees
    i==(F.size-1) ||            # we are on the southernmost row of trees
                                #   F.size => FOREST north/south length
    j==0 ||                     # we are on the westernmost column of trees
    j==(F[1].size-1)            # we are on the easternmost column of trees
                                #   F[1].size => FOREST east/west length
  }
]

p [                             # print the inspected object to the screen

                                # PART 1: find the number of visible trees from the edge
                                # =================================================================
  F.reduce([0,0]){|(n,i),r|     # n - accumulated number of visible trees
                                # i - current row index
                                # r - current row of trees

                                # if we are on an EDGE: (postfixed `if`, see below)
    next[                       # go to the next iteration of the reduce, passing:
      n+r.size,                 # the current number of visible trees plus this entire row
      i+1                       # increase the row index
    ]if E.(i,-1);               # postfix condition, call the EDGE lambda with the current row
                                #   - passing -1 for the column because we only care about rows
                                #     right now.

    [
      r.reduce([n,0]){|(n,j),t| # accumulate number of visible trees for this row

                                # if we are on an EDGE (postfix):
        next [                  # go to the next column, returning
          n+1,                  #   - add one to the tree total
          j+1                   #   - increment the column index
        ]if E.(i,j);            # postifx conditional again

        V.(i,j,r,C.(j)).        # get the VIEWS from here
                                #   - C.(j) returns an array of the current column of trees

          any?{|d|              # if, in any direction (notice ternary `if` usage)
            d.all?{_1<t}        #   all the trees are shorter than this one
          } ?                   # then (`?` is ternary if, the next clause is the `then`)
        [n+1,j+1] :             #   add this tree to the visible trees, incerment column index
        [n,j+1]                 # otherwise (`:` is the `else`)
                                #   just increment the column index

      }[0],                     # the first element in the array returned by reduce contains our
                                # total number of visible trees thus far

      i+1                       # increment the row index
    ]

  }[0],                       # the first element in the array returned from `reduce` contains our
                              # total number of visible trees

                              # Part 2: Find the highest possible "scenic score"
                              # ===================================================================
  F.reduce([0,0]){|(m,i),r|   # m - accumulate highest tree score for the FOREST
                              # i - current row index
                              # r - current row of trees

    [[
      m,                      # highesht score so far
      r.reduce([m,0]){        # find the highest of either the current max or the max in this row
        |(m,j),h|             # m - highest score so far
                              # j - current row index
                              # h - height of current tree

        [[
          m,                 # the highest score so far
          V.(i,j,r,C.(j))    # the trees in order in each direction from this tree
          .map{              # find visible distance for each direction
            _1.              # numbered argument

              reduce(0){    # find the visible distance for this direction
                |v,t|       # v - visible distance accumulator
                            # t - next tree height

              t<h||         # keep going if the tree is shorter than the current tree
              (break v+1);  # otherwise this is the last visible tree; break with its distance
              v+1           # increment the visible distance and keep looking
            }
          }.reduce(&:*)     # multiply the distances together to find the scenic score for this tree
        ].max, j+1]         # take whatever is bigger, the past current max or the new current max
                            # and increment the column index

      }[0]                  # the current highest max is returned in the first element
    ].max, i+1]             # take whatever is bigger, the past current max or the new current max
                            # and increment the column index

  }[0]                      # the highest scenic score is found in the first element
]
