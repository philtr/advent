I=$<.read.each_line.map{|l|l.chomp.chars.map(&:ord).map{_1>90?(_1-96):(_1-38)}}
p(I.sum{|r|r.each_slice(r.size/2).reduce{_1&_2}[0]})
p(I.each_slice(3).sum {|g| g.reduce{_1&_2}[0]})
