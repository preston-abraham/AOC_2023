times = [53,89,76,98]
distances = [313,1090,1214,1201]

function travel(time,hold_time)
    return (time - hold_time) * hold_time
end

function winning_strats(time,distance)
    values = []
    for ht in range(1,time)
        push!(values,travel(time,ht))
    end
    filter!(e->e>distance,values)
    return(size(values)[1])
end

print(String("Part 1: $(prod([winning_strats(times[i],distances[i]) for i in range(1,4)]))"))

time = 53897698
distance = 313109012141201

print(String("\nPart 2: $(winning_strats(time,distance))"))
