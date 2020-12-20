function solve!(r::Robot)
    move1 = return_steps(r, Sud)
    move2 = return_steps(r, Ost)

    s::HorizonSide  = West

    while isborder(r, Nord) == false
        putmarkers!(r, s)
        move!(r,Nord)
        putmarker!(r)
        if s == West
            s = Ost
        else
            s = West
        end
    end

    #if s == West
    #    s = Ost
    #else 
     #   s = West
    #end
    
    while isborder(r, s) == false
        putmarkers!(r, s)
    end

    while isborder(r, Sud) == false
        move!(r, Sud)
    end

    while isborder(r, Ost) == false
        move!(r, Ost)
    end

    go(r, Nord, move1)
    go(r, West, move2)

end

function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side) == false
        putmarker!(r)
        move!(r, side)
    end
    putmarker!(r)
end

function return_steps(r::Robot, side::HorizonSide)
    cnt = 0
    while isborder(r, side) == false
        cnt += 1
        move!(r, side)
    end
    return cnt
end

function go(r::Robot, side::HorizonSide, cnt::Int64)
    for i in 1:cnt
        move!(r, side)
    end
end