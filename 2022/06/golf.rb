u=->s,n{s.chars.each_cons(n).with_index{return _2+n if _1.uniq.size==n}}
I=$<.read;p u.(I,4),u.(I,14)
