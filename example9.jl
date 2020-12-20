function find_marker(r::Robot)
    now_steps = 1
    side = Nord
    while ismarker(r) == false
        for _ in 1:2
            find_marker(r, side, now_steps)
            side = next(side)
        end
        now_steps += 1
    end
end

function find_marker(r::Robot, side, now_steps::Int)
    for _ in 1:now_steps
        if ismarker(r)
            return nothing
        end
        move!(r, side)
    end
end

function next(side::HorizonSide)
    HorizonSide(mod(Int(side)+1, 4))
end
