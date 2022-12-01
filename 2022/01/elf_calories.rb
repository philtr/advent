module ElfCalories
  ELF_SEP = "\n\n"

  class << self

    def top(input, n=1) = process_input(input).max(n).sum

    private

    def process_input(input) = input
      .split(ELF_SEP)
      .map(&method(:process_elf))

    def process_elf(elf_input) = elf_input
      .split
      .sum(&:to_i)

  end
end
