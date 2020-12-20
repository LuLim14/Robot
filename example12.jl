X_COORD = 0
Y_COORD = 0
CELL_SIZE = 0 

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function moves!(r::Robot,side::HorizonSide)
    num_steps = 0
    while isborder(r, side) == false
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function solve!(r::Robot, n::Int)
    global CELL_SIZE, X_COORD, Y_COORD
    CELL_SIZE = n
    num_ver = moves!(r, Sud)
    num_hor = moves!(r, West)

    #in lower left


    mark_chess(r)
    #done

    go_back(r, Sud, Y_COORD - num_ver)
    go_back(r, West, X_COORD - num_hor)
    #in start pos
end

function mark_chess(r::Robot)
    mark_row(r, Ost)
    side = West
    while isborder(r, Nord) == false
        move_decart!(r, Nord)
        mark_row(r, side)
        side = inverse(side)
    end
end

function mark_row(r::Robot,side::HorizonSide)
    putmarker_chess!(r)
    while isborder(r, side) == false
        move_decart!(r, side)
        putmarker_chess!(r)
    end
end
        
function putmarker_chess!(r::Robot)
    
    if ((mod(X_COORD, 2 * CELL_SIZE) in 0: CELL_SIZE - 1) && (mod(Y_COORD, 2 * CELL_SIZE) in 0: CELL_SIZE - 1))
        putmarker!(r)
    end

    if ((mod(X_COORD, 2 * CELL_SIZE) in CELL_SIZE: 2 * CELL_SIZE - 1) && (mod(Y_COORD, 2 * CELL_SIZE) in CELL_SIZE: 2 * CELL_SIZE - 1))
        putmarker!(r)
    end
end

function move_decart!(r::Robot, side::HorizonSide)
    global X_COORD, Y_COORD
    if side == Sud
        Y_COORD -= 1
    elseif side == Nord
        Y_COORD += 1
    elseif side == West
        X_COORD -= 1
    elseif side == Ost
        X_COORD += 1
    end 
    move!(r, side)
end


function go_back(r::Robot, side::HorizonSide, num_steps::Int)
    if (num_steps < 0) == true
        side = inverse(side)
        num_steps *= -1
    end
    for _ in 1: num_steps
        move!(r, side)
    end
end

