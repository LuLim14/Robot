function mark_angles(r)
    cnt = []
    while isborder(r,Sud) == false || isborder(r,West) == false #while outside the south-west angle
        push!(cnt, moves!(r, West)) 
        push!(cnt, moves!(r, Sud))
    end
   
    for side in (Nord, Ost, Sud, West)
        moves!(r, side) 
        putmarker!(r)
    end
    
    for (i, n) in enumerate(reverse!(cnt)) 
        side = isodd(i) ? Nord : Ost 
        moves!(r, side, n)
    end

end

function moves!(r,side)
    num_steps = 0
    while isborder(r, side) == false
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function moves!(r,side,num_steps)
    for _ in 1: num_steps move!(r,side) end
end
