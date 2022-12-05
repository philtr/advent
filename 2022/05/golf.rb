I=$<.readlines
i=->(s,l){l.scan(/\s{4}|\w/).each_with_index{s[_2]||=[];s[_2].unshift(_1) if _1=~/\w/};s}
m=->(s,l,v){n,f,t=l.scan(/\d+/).map{_1.to_i-1};c=s[f].pop(n+1);s[t].push(*(v ? c : c.reverse));s}
r=->(x=[],p=nil){I.reduce(x){_2=~/\[/?i.(x,_2):(_2=~/\Am/?m.(x,_2,p):_1)}}
[r.([]),r.([],2)].map{p _1.map(&:pop).join}
