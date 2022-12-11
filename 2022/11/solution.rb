PROGRAM = $<.read

class MonkeyBusiness
  def initialize(monkeys, rounds: 1)
    @monkeys = monkeys
    @rounds = rounds
  end

  def monkey_around!
    inspections = Hash.new(0)

    @rounds.times do |r|
      @monkeys.each_with_index do |monkey, i|
        inspections[i] += monkey.items.size
        until monkey.items.empty? do
          id, item = monkey.toss
          @monkeys[id].receive(item)
        end
      end
    end

    p inspections.values.max(2).reduce(:*)
  end
end

class Monkey
  attr_reader :items, :operation, :decide

  def initialize(items:,operation:,decide:)
    @items = items
    @operation = operation
    @decide = decide
  end

  def toss = decide.(operation.(items.shift))
  def receive(item) = items.push(item)
end

monkeys = PROGRAM
  .gsub(/^Monkey \d+:\n/) { "Monkey.new(" }
  .gsub(/\s*Starting items: (?<items>(\d+,?\s?)*)\n/) { "items: [#$1], " }
  .gsub(/\s*Operation: new = (?<arg1>.+?) (?<op>.) (?<arg2>.+?)\n/) { "operation: ->(#$1) { #$1 #$2 #$3 }, " }
  .gsub(/\s*Test: divisible by (?<mod>\d+)\n\s*If true: throw to monkey (?<t>\d+)\n\s*If false: throw to monkey (?<f>\d+)\n/) { "decide: ->(x) { x = x/3; [x % #$1 == 0 ? #$2 : #$3, x] })" }
  .lines.map { eval _1 }
  .compact

MonkeyBusiness.new(monkeys, rounds: 20).monkey_around!

