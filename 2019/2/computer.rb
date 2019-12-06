#!/usr/bin/env ruby

PROGRAM = [1,12,2,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,10,19,1,6,19,23,1,10,23,27,2,27,13,31,1,31,6,35,2,6,35,39,1,39,5,43,1,6,43,47,2,6,47,51,1,51,5,55,2,55,9,59,1,6,59,63,1,9,63,67,1,67,10,71,2,9,71,75,1,6,75,79,1,5,79,83,2,83,10,87,1,87,5,91,1,91,9,95,1,6,95,99,2,99,10,103,1,103,5,107,2,107,6,111,1,111,5,115,1,9,115,119,2,119,10,123,1,6,123,127,2,13,127,131,1,131,6,135,1,135,10,139,1,13,139,143,1,143,13,147,1,5,147,151,1,151,2,155,1,155,5,0,99,2,0,14,0]

TEST_PROGRAM_1 = [1,9,10,3,2,3,11,0,99,30,40,50]
SOLUTION_1 = [3500,9,10,70,2,3,11,0,99,30,40,50]
TEST_PROGRAM_2 = [1,1,1,4,99,5,6,0,99]
SOLUTION_2 = [30,1,1,4,2,5,6,0,99]
TEST_PROGRAM_3 = [2,3,0,3,99]
SOLUTION_3 = [2,3,0,6,99]

def compute(program)
  index = 0
  loop do
    frame = program[index..index + 3]
    case frame[0]
    when 1 then operator = :+
    when 2 then operator = :*
    when 99 then puts program.to_s; return program
    else raise 'oh no'
    end
    operand_1 = program[frame[1]]
    operand_2 = program[frame[2]]
    output = operand_1.send operator, operand_2
    program[frame[3]] = output
    index += 4
  end
end

#compute(PROGRAM)

def brute_force_find(answer)
  noun = 0
  verb = 0
  while noun <= 99 do
    puts "noun #{noun}"
    program = PROGRAM.dup
    program[1] = noun
    while verb <= 99 do
      subroutine = program.dup
      subroutine[2] = verb
      begin
        result = compute(subroutine)[0]
      rescue # "Just don't write any bugs"
      end
      if result == answer
        return subroutine
      end
      verb += 1
    end
    verb = 0
    noun += 1
  end
end

winning = brute_force_find(19690720)
puts (winning[1]*100 + winning[2])
