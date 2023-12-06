times = [53,89,76,98]
distances = [313,1090,1214,1201]

function travel(time,hold_time)
    return (time - hold_time) * hold_time
end

tot = 1
for i in range(1,4)
    values = []
    for ht in range(1,times[i])
        push!(values,travel(times[i],ht))
    end
    filter!(e->e>distances[i],values)
    tot *= size(values)[1]
end
print(String("Part 1: $(tot)"))

time = 53897698
distance = 313109012141201

# Binary Search Start
start = 1
while travel(time,start) <= distance
    start *= 2
end
while travel(time,start) > distance
    start -= 1
end
start = start + 1

# Binary Search Last
last = time
while travel(time,last) <= distance
     last /= 2
end
while travel(time,last) > distance
    last += 1
end
last = last - 1

# Get Range
print(String("Part 2: $(last - start + 1)"))
