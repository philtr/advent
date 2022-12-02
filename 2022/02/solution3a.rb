A=X=1;B=Y=2;C=Z=3;p $<.reduce(0){|s,m|m=m.split(" ").map{eval(_1)};d=(n=m[1])-m[0];s+(d==0 ? n+3 : ([1,-2].any?(d) ? n+6 : n))}
