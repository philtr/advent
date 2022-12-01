#!/usr/bin/env ruby

require_relative "elf_calories"

input = File.read("input_a.txt")

puts "Part 1: #{ElfCalories.top(input)}"
puts "Part 2: #{ElfCalories.top(input, 3)}"
