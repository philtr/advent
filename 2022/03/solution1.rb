I=$<.readlines.map{|l|l.chomp.bytes.map{_1-(_1>90?96:38)}}
p I.sum{_1.each_slice(_1.size/2).reduce(&:&)[0]}
p I.each_slice(3).sum{_1.reduce(&:&)[0]}
