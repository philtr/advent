I=$<.map{eval"[#{_1.gsub ?-,".."}]"}
p I.count{|a,b|a.cover?(b)||b.cover?(a)}
p I.count{_1.map(&:to_a).reduce(&:&).any?}
