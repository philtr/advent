f=Hash.new 0
d=($<.reduce([]){|c,l|l[".."]&&(c.pop)||l[/cd ([^\/]+)/]&&(c.push([*c,$1]*?/))||l[/\d+/]&&(z=$&.to_i;f[?/]+=z;c.map{f[_1]+=z});c};f)
p d.sum{_2<1e5?_2:0},d.values.reject{_1<(3e7-7e7+d[?/])}.min
