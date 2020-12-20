function solve!(r)
    way = []
    cnt = 0

    while !((isborder(r, Sud)) && (isborder(r, West)))
        cnt += 2
        push!(way, moves!(r, West))
        push!(way, moves!(r, Sud))
    end

    putmarker!(r)
    while !isborder(r, Ost)
        move!(r, Ost)
        putmarker!(r)
    end

    cnt_mk = moves!(r, West)
    while (cnt_mk > 0 && !isborder(r, Nord))
        mk = cnt_mk
        move!(r, Nord)
        while mk > 0
            putmarker!(r)
            mk -= specific_move!(r, Ost)
        end

        go_back(r, West)
        cnt_mk -= 1
    end

    moves!(r, Sud)
    while (cnt > 0)
        side = isodd(cnt) ? Ost : Nord
        for i in 1: way[cnt]
            move!(r, side)
        end
        cnt -= 1
    end
end

function go_back(r::Robot, side::HorizonSide)
    swapp = 1
    while swapp != 0
        swapp = specific_move!(r, side)
    end
end

function specific_move!(r::Robot, side::HorizonSide)
    num_steps = 0
    while (!isborder(r, next(side)) && isborder(r, side))
        move!(r, next(side))
        num_steps += 1
    end

    swapp = 0
    if !isborder(r, side)
        move!(r, side)
        swapp += 1
    end

    if num_steps != 0
        while isborder(r, inverse(next(side)))
            move!(r, side)
            swapp += 1
        end
        for i in 1: num_steps
            move!(r, inverse(next(side)))
        end
    end
    
    return swapp
end

function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    while !isborder(r, side)
        move!(r, side)
        num_steps += 1
    end

    return num_steps
end

inverse(side::HorizonSide) = (HorizonSide(mod(Int(side) + 2, 4)))
next(side::HorizonSide) = (HorizonSide(mod(Int(side) + 1, 4)))
