require "matrix"

f = Matrix.rows($<.map{ _1.chomp.split('').map(&:to_i) })

# == part 1 ===================================================================
p (
  f.to_a.reduce([0,0]) {|(n,i), r|
    next [n+r.size,i+1] if i==0||i==(f.column_count-1)

    x = r.reduce([n,0]) {|(n,j),t|
      c = f.column(j).to_a

      next [n+1,j+1] if j==0||j==(c.size-1)

      s = [
        r[0..(j-1)],  # west
        r[(j+1)..-1], # east
        c[0..(i-1)],  # north
        c[(i+1)..-1]  # south
      ]

      s.any?{|d| d.all? { _1<t } } ? [n+1, j+1] : [n, j+1]
    }[0]

    [x, i+1]

  }[0]
)

# == part 2 ===================================================================
p (
  f.to_a.reduce([0,0]) {|(max,i),r|
    w = r.reduce([max,0]) {|(max,j), th|
      c = f.column(j).to_a

      next [max, j+1] if (j==0 || j==(c.size-1) || i==0 || i==(r.size-1))

      s = [
        r[0..(j-1)].reverse,  # west
        r[(j+1)..-1],         # east
        c[0..(i-1)].reverse,  # north
        c[(i+1)..-1]          # south
      ]

      v = s.map {
        _1.reduce([]) {|ts, t| ts << t; break ts if t >= th; ts }.size
      }.reduce(&:*)

      [[max,v].max, j+1]
    }[0]

    [[max,w].max, i+1]
  }[0]
)
