X,O,F=[40,?#,?.]
C,S,_=(1..240).reduce([[0,1],[],[0]]){|(c,s,a),i|m=(c[i]+1)%X
s<<(((m-1)..(m+1)).cover?(i%X)?O : F)
a.any?||a.push(*[0,$<.gets[/-?\d+/].to_i].uniq)
c[i+1]=c[i]+a.pop
[c,s,a]}
puts [((20..220).step(X)).map{C[_1]*_1}.reduce(&:+),S.each_slice(X).map(&:join)]
