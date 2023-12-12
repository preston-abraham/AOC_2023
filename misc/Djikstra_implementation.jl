function mindist(distances, visited, graph_size)
    min = Inf 
    index = 0
    for i in 1:graph_size
        if distances[i] < min && !visited[i]
            min = distances[i]
            index = i
        end
    end
    return index
end

function djikstra(graph,vertex)
    graph_size = size(graph)[1]
    visited = [false for i in 1:graph_size]
    distances = [Inf for i in 1:graph_size]
    distances[vertex] = 0
    
    for i in 1:graph_size
        
        min_distance_index = mindist(distances, visited, graph_size)
    
        for j in 1:graph_size
            if graph[min_distance_index][j] > 0 && !visited[j] && distances[j] > distances[min_distance_index] + graph[min_distance_index][j]
                distances[j] = distances[min_distance_index] + graph[min_distance_index][j]
            end
        end
        visited[min_distance_index] = true
    end
    for (i , j) in enumerate(distances)
        println(i, " | ", j)
    end
end
