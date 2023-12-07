input = open(io->read(io, String), "inputs/day7.txt")
lines = split.(split(input,"\n")," ")
cards = [i[1] for i in lines]
bets = Dict(i[1]=>parse(Int64,i[2]) for i in lines)

card_values = Dict('A'=>14,'K'=>13,'Q'=>12,'X'=>11,'T'=>10,'9'=>9,'8'=>8,'7'=>7,'6'=>6,'5'=>5,'4'=>4,'3'=>3,'2'=>2,'J'=>1)
values = Dict("five"=>6,"four"=>5,"full"=>4,"three"=>3,"two pair"=>2,"pair"=>1,"cardhigh"=>0)

function joker_count(card)
    jokers = 0
    for c in card
        if c == 'J'
            jokers += 1
        end
    end
    return jokers
end

function most_frequent_char(card_items)
    max_apps = 0
    max_char = ""
    freqs = Dict(i=>0 for i in union(card_items))
    for i in card_items
        if i != "J"
            freqs[i] += 1
            if freqs[i] > max_apps
                max_apps = freqs[i]
                max_char = i
            end
        end
    end
    return((max_char,max_apps))
end  


function card_type(card)
    card_items = split(card,"")
    number_of_jokers = joker_count(card)
    num_uniques = size(union(card_items))[1]
    
    if most_frequent_char(card_items)[1] != ""
        card_items = replace(card_items,"J"=>most_frequent_char(card_items)[1])
    end
    
    num_uniques = size(union(card_items))[1]
    
    
    if num_uniques == 1
        return "five"
    end
    if num_uniques == 2
        if most_frequent_char(card_items)[2] == 4
            return "four"
        else
            return "full"
        end
    end
    if num_uniques == 3
        if most_frequent_char(card_items)[2] == 2
            return "two pair"
        else
            return "three"
        end
    end
    if num_uniques == 4
        return "pair"
    end
        
    if num_uniques == 5
        return "cardhigh"
    end
end

function card_is_less(card1,card2)
    
    if values[card_type(card1)] < values[card_type(card2)]
        return true
    end
    
    if values[card_type(card1)] > values[card_type(card2)]
        return false
    end
    
    for i in range(1,5)
        if card_values[card1[i]] < card_values[card2[i]]
            return true
        end
        if card_values[card1[i]] > card_values[card2[i]]
            return false
        end
    end
    return "error"
end

cards_p1 = replace.(cards,"J"=>"X")
sorted_cards_p1 = replace.(sort(cards_p1,lt=card_is_less),"X"=>"J")


print(String("Part 1: $(sum([i * bets[sorted_cards_p1[i]] for i in range(1,size(cards)[1])]))"))


sorted_cards = sort(cards,lt=card_is_less)
print(String("\nPart 2: $(sum([i * bets[sorted_cards[i]] for i in range(1,size(cards)[1])]))"))
