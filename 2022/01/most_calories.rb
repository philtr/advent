#!/usr/bin/env ruby

require_relative "elf_calories"

input = File.read("input_a.txt")

puts ElfCalories.most_calories(input)
