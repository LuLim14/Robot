function solve!(r)
    way = []
    cnt = 0
    side = West

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

    while !isborder(r, Nord)
        move!(r,Nord)
        putmarker!(r)
        swapp = 1
        while swapp != 0
            swapp = specific_move!(r, side)
            putmarker!(r)
        end
        side = inverse(side)
    end

    moves!(r, West)
    moves!(r, Sud)
    while (cnt > 0)
        side = isodd(cnt) ? Ost : Nord
        for i in 1: way[cnt]
            move!(r, side)
        end
        cnt -= 1
    end
end

function specific_move!(r::Robot, side::HorizonSide)
    swapp = 0
    num_steps = 0
    while isborder(r, side) && !isborder(r, next(side))
        move!(r, next(side))
        num_steps += 1
    end

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
