order = 5
grid = zeros(Float64, order, order)
grid[1] = 0
grid[order*order] = 2
grid[8] = -0.5
grid[10] = -0.5
grid[17] = -0.5
grid[19] = -0.5

delta = 0.0

for k in range(1, 15)
    for i in range(1, order*order - 1)
        grid[i] = maxVal(i)
    end
end

function maxVal(i::Int64)
    gamma = 1

    if mod(i, order) == 0
        actDOWN = -10000
    elseif grid[i + 1] > 0
        actDOWN = -1
    else
        if grid[i + 1] == -0.5 
            actDOWN = -1 + gamma*grid[i]
        else
            actDOWN = -1 + gamma*grid[i + 1]
        end
    end
    
    if mod(i, order) == 1
        actUP = -10000
    elseif grid[i - 1] > 0
        actUP = -1
    else
        if grid[i - 1] == -0.5
            actUP = -1 + gamma*grid[i]
        else
            actUP = -1 + gamma*grid[i - 1]
        end
    end
    
    if i in range(order*(order -1) + 1, order*order - 1)
        actRIGHT = -10000
    elseif grid[i + order] > 0
        actRIGHT = -1
    else
        if grid[i + order] == -0.5
            actRIGHT = -1 + gamma*grid[i]
        else
            actRIGHT = -1 + gamma*grid[i + order]
        end
    end
    
    if i in range(1, order)
        actLEFT = -10000
    elseif grid[i - order] > 0
        actLEFT = -1
    else
        if grid[i - order] == -0.5
            actLEFT = -1 + gamma*grid[i]
        else
            actLEFT = -1 + gamma*grid[i - order]
        end
    end

    setActions = [actRIGHT, actLEFT, actDOWN, actUP]
    if grid[i] == -0.5
        return -0.5
    else
        return findmax(setActions)[1]
    end
end