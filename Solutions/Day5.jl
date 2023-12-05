input = open(io->read(io, String), "inputs/day5.txt")
maps = split(input,"\n\n")
seeds = parse.(Int64,split(split(maps[1],": ")[2]," "))

function numeric_map(text_map)
    return filter!(e->e!=" ",split(replace(text_map,r"[^0-9 \n]"=>""),"\n"))
end

function cross_walk(numeric_map)
    cross_walk_map = split.(numeric_map," ")
    starts = [parse(Int64,i[2]) for i in cross_walk_map]
    ends = [parse(Int64,i[2]) + parse(Int64,i[3]) for i in cross_walk_map]
    shifts =  [parse(Int64,i[1]) for i in cross_walk_map]
    return [starts,ends,shifts]
end

seed_to_soil = cross_walk(numeric_map(maps[2]))
soil_to_fertilizer = cross_walk(numeric_map(maps[3]))
fertilizer_to_water = cross_walk(numeric_map(maps[4]))
water_to_light = cross_walk(numeric_map(maps[5]))
light_to_temp = cross_walk(numeric_map(maps[6]))
temp_to_humidity = cross_walk(numeric_map(maps[7]))
humidity_to_location = cross_walk(numeric_map(maps[8]))

function walk(value,cross_walk)
    starts = cross_walk[1]
    ends = cross_walk[2]
    shifts = cross_walk[3]
    for i in range(1,size(starts)[1])
        if value >= starts[i] && value < ends[i]
            return shifts[i] + (value - starts[i])
        end
    end
    return value
end

function seed_to_location(seed)
    soil = walk(seed,seed_to_soil)
    fert = walk(soil,soil_to_fertilizer)
    water = walk(fert,fertilizer_to_water)
    light = walk(water,water_to_light)
    temp = walk(light,light_to_temp)
    humidity = walk(temp,temp_to_humidity)
    return(walk(humidity,humidity_to_location))
end
    
print(String("Part 1: $(minimum(seed_to_location.(seeds)))"))

# Kinda Brute-Forcey, not so happy with this. Takes 6-7 minutes on my input
seed_ranges = [(range(seeds[2*i + 1],seeds[2 * i + 1]+seeds[2 * i + 2])) for i in range(0,9)]
mins = []
Threads.@threads for i in seed_ranges
    push!(mins,minimum(seed_to_location.(i)))
end
print(String("Part 2: $(minimum(mins))"))
