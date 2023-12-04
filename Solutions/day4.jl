input = open(io->read(io, String), "inputs/day4.txt")
lines = split.(split(input,"\n"),":")
cards = [i[2] for i in lines]
cards = split.(cards,"|")
player_numbers = [filter!(e->e != "",split(c[1]," ")) for c in cards]
winning_numbers = [filter!(e->e != "",split(c[2]," ")) for c in cards]

function score(card_index)
    matches = size(findall(in(winning_numbers[card_index]),player_numbers[card_index]))[1]
    if matches > 0
        return (2 ^ (matches - 1))
    end
    return 0
end

function raw_score(card_index)
    return size(findall(in(winning_numbers[card_index]),player_numbers[card_index]))[1]
end

function extra_cards(index)
    points = raw_score(index)
    return filter!(e->e <= 206,[index + i for i in range(1,points)])
end

print(String("Part 1: $(sum(score.(range(1,206))))"))

number_of_copies = [1 for i in range(1,206)]
for i in range(1,206)
    copies = number_of_copies[i]
    winnings = extra_cards(i)
    for card in winnings
        number_of_copies[card] += copies
    end
end
print(String("\nPart 2: $(sum(number_of_copies))"))
        
