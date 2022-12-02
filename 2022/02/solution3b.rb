A=1;B=2;C=3;X=[0,-1];Y=[3,0];Z=[6,1];p $<.reduce(0){|s,m|m=m.split(" ").map{eval(_1)};s+m[1][0]+(a=(1..3).cycle(3).to_a)[a.index(m[0])+3+m[1][1]]}
