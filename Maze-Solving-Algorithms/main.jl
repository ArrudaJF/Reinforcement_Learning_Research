include("/home/rabaribobo/IC/Grid.jl") 
using Random

function makeGrid()
    grid = zeros(Float64, 5, 5)
    grid[25] = 5
    grid[8] = -0.5
    grid[10] = -0.5
    grid[17] = -0.5
    grid[19] = -0.5
    return grid
end

function reward(s::Int64, a::Int64)
    if s + a == 25
        return -1
    else 
        return -1
    end
end

for k in range(1, 10)
    for i in range(1, 24)

        if mod(i, 5) == 0
            actDOWN = -10000
        elseif grid[i + 1] == 5
            actDOWN = reward(i, 1)
        else
            if grid[i + 1] == -0.5 
                actDOWN = reward(i, 1) + 0.8*grid[i]
            else
                actDOWN = reward(i, 1) + 0.8*grid[i + 1]
            end
        end
        
        if mod(i, 5) == 1
            actUP = -10000
        else
            if grid[i - 1] == -0.5
                actUP = reward(i, -1) + 0.8*grid[i]
            else
                actUP = reward(i, -1) + 0.8*grid[i - 1]
            end
        end
        
        if i in range(21, 24)
            actRIGHT = -10000
        elseif grid[i + 5] == 5
            actRIGHT = reward(i, 5)
        else
            if grid[i + 5] == -0.5
                actRIGHT = reward(i, 5) + 0.8*grid[i]
            else
                actRIGHT = reward(i, 5) + 0.8*grid[i + 5]
            end
        end
        
        a = -5
        if i in range(1, 5)
            actLEFT = -10000
        else
            if grid[i - 5] == -0.5
                actLEFT = reward(i, -5) + 0.8*grid[i]
            else
                actLEFT = reward(i, -5) + 0.8*grid[i - 5]
            end
        end

        setActions = [actRIGHT, actLEFT, actDOWN, actUP]
        if grid[i] == -0.5
            nothing
        else
            grid[i] = findmax(setActions)[1]
            #print(findmax(setActions)[2])
        end
    end
end

grid = makeGrid()