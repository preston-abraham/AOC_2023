# Day 1

# Read Input File and Split
input = open(io->read(io, String), "inputs/day1.txt")
lines = split(input, "\n")

#
function value(str)
    tens = parse(Int64,first(str))
    ones = parse(Int64,last(str))
    return 10*tens + ones
end

# Get Values and Print
strings = replace.(lines,r"[^0-9]"=>"")
print(String("Part 1:$(sum(value.(strings)))\n"))

# Define Spelled Numbers for String Replacement
numbers = [["one","o1e"],
            ["two","t2o"],
            ["three","t3e"],
            ["four","f4r"],
            ["five","f5e"],
            ["six","s6x"],
            ["seven","s7n"],
            ["eight","e8t"],
            ["nine","n9e"]]

# Replace String Numbers
for n in numbers
    lines = replace.(lines,n[1]=>n[2])
end

# Get Values and Print
strings = replace.(lines,r"[^0-9]"=>"")
print(String("Part 2:$(sum(value.(strings)))\n"))