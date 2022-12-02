#!/usr/bin/env ruby

                        # Annotated from this wild 54 byte golf from reddit
                        # https://www.reddit.com/r/adventofcode/comments/z9ezjb/comment/iygtai7/


$/ *= 2                 # `$/` is the stdin input record separator and uses the
                        # value "\n" by default. This doubles it to "\n\n"

x = $<                  # `$<` is an alias for ARGF to read from stdin IO stream

  .map {                # IO streams are enumerable, so this will map over the
                        # records split by the record separator ("\n\n")

    _1                  # This is using the numbered argument syntax for enumerators

      .split            # Split each record string by "\n". This behavior appears
                        # to be undocumented:
                        #
                        # https://ruby-doc.org/core-3.1.2/String.html#method-i-split
                        #
      .sum &:to_i       # Array#sum optionally takes in a block to apply to each
                        # element before summing
  }

  .max(3)               # Array#max can return the top n elements of an arary if
                        # this argument is provided

p x[0], x.sum           # print the value of the highest element and the sum of the top 3
