function solve!(r)
    way = []
    cnt = 0
    while !((isborder(r, Sud)) && (isborder(r, West)))
        cnt += 2
        push!(way, moves!(r, West))
        push!(way, moves!(r, Sud))
    end
    side = Nord

    for i in 1: 4
        while !isborder(r, side)
            putmarker!(r)
            move!(r, side)
        end
        side = inverse(next(side))
    end

    while (cnt > 0)
        side = isodd(cnt) ? Ost : Nord

        for i in 1: way[cnt]
            move!(r, side)
        end
        cnt -= 1
    end

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