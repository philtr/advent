u=->(s,n){s.chars.each_cons(n).reduce(0){_2.uniq.size==n ? (return _1+n):_1+1}}
I=$<.read;p u.(I,4),u.(I,14)
