function solve!(r)
    side = Nord

    for i in 1: 4
        swapp = 1
        while swapp != 0
            swapp = specific_move!(r, side)
            putmarker!(r)
        end

        while ismarker(r)
            specific_move!(r, inverse(side))
        end

        side = inverse(next(side))
    end

    putmarker!(r)

end

function specific_move!(r::Robot, side::HorizonSide)
    num_steps = 0
    while !isborder(r, next(side)) && isborder(r, side)
        move!(r, next(side))
        num_steps += 1
    end

    swapp = 0
    if !isborder(r,side)
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

next(side::HorizonSide) = HorizonSide(mod(Int(side) + 1, 4))

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))
