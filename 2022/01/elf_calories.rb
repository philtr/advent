module ElfCalories
  ELF_SEP, ITEM_SEP = ["\n\n", "\n"]

  class << self

    def most_calories(input) = process_input(input).max
    def top(input, n) = process_input(input).max(3).sum

    private

    def process_input(input) = input
      .split(ELF_SEP)
      .map(&method(:process_elf))

    def process_elf(elf_input) = elf_input
      .split(ITEM_SEP)
      .map(&:to_i)
      .sum

  end
end
