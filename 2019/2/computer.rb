#!/usr/bin/env ruby

PROGRAM = [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,6,19,23,1,10,23,27,2,27,13,31,1,31,6,35,2,6,35,39,1,39,5,43,1,6,43,47,2,6,47,51,1,51,5,55,2,55,9,59,1,6,59,63,1,9,63,67,1,67,10,71,2,9,71,75,1,6,75,79,1,5,79,83,2,83,10,87,1,87,5,91,1,91,9,95,1,6,95,99,2,99,10,103,1,103,5,107,2,107,6,111,1,111,5,115,1,9,115,119,2,119,10,123,1,6,123,127,2,13,127,131,1,131,6,135,1,135,10,139,1,13,139,143,1,143,13,147,1,5,147,151,1,151,2,155,1,155,5,0,99,2,0,14,0]

TEST_PROGRAM_1 = [1,9,10,3,2,3,11,0,99,30,40,50]
SOLUTION_1 = [3500,9,10,70,2,3,11,0,99,30,40,50]
TEST_PROGRAM_2 = [1,1,1,4,99,5,6,0,99]
SOLUTION_2 = [30,1,1,4,2,5,6,0,99]
TEST_PROGRAM_3 = [2,3,0,3,99]
SOLUTION_3 = [2,3,0,6,99]

ADHOC_TEST = [2, 1, 2, 3,
              1, 5, 6, 7,
              2, 9, 10, 11,
              2, 13, 14, 15,
              99, 17]

OPERATIONS = {
  1 => :+,
  2 => :*,
  99 => :halt
}

def compute(program)
  index = 0
  loop do
    fm = program[index..index + 3]
    puts "Operating on #{fm}, index #{index}"
    #require 'pry-byebug'; byebug
    case fm[0]
    when 1 then operator = :+
    when 2 then operator = :*
    when 99 then puts program.to_s; return program
    else raise 'oh no'
    end
    operand_1 = program[fm[1]]
    operand_2 = program[fm[2]]
    output = operand_1.send operator, operand_2
    #puts "Operands #{operand_1} and #{operand_2}; operator #{operator}"
    #puts "Yielding output #{output} into #{fm[3]} of" 
    #pp program
    #require 'pry-byebug'; byebug
    program[fm[3]] = output
    index += 4
  end
end

def pp(program)
  remaining = program.length
  index = 0
  while remaining > 8
    puts "((#{index})) #{program[index..index + 7].to_s}"
    remaining = remaining - 8
    index += 8
  end
  puts program[index..-1].to_s
end
