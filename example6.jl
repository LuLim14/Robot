function mark_innerrectangle_perimetr!(r::Robot)
    num_steps = fill(0,3) 
    for (i, side) in enumerate((Sud, West, Sud))
        num_steps[i] = moves!(r, side)
    end
    # in left-under corner

    side = find_border!(r, Ost, Nord)
    #near with right border

    
    for i in (Sud, Ost, Nord, West)
        while isborder(r, HorizonSide(mod(Int(i) + 1, 4))) && !(ismarker(r))
            putmarker!(r)
            move!(r, i)
        end
        if !(ismarker(r))
            putmarker!(r)
            move!(r, HorizonSide(mod(Int(i) + 1, 4)))
        end
    end 
    
    #again near with right border and paint cells

    moves!(r, Sud)
    moves!(r, West)
    #near with right border

    for (i,side) in enumerate((Nord,Ost,Nord))
        moves!(r,side, num_steps[i])
    end
    #in start position
end



function moves!(r::Robot, side::HorizonSide)
    num_steps = 0
    while isborder(r, side) == false
        move!(r, side)
        num_steps += 1
    end
    return num_steps
end

function find_border!(r::Robot, direction_to_border::HorizonSide, direction_of_movement::HorizonSide)
    while isborder(r, direction_to_border) == false  
        if isborder(r, direction_of_movement) == false
            move!(r, direction_of_movement)
        else
            move!(r, direction_to_border)
            direction_of_movement = inverse(direction_of_movement)
        end
    end
    return direction_to_border
       
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))

function putmarkers!(r::Robot, direction_of_movement::HorizonSide, direction_to_border::HorizonSide)
    while isborder(r, direction_to_border) == true
        putmarker!(r)
        move!(r, direction_of_movement)
    end
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for i in 1:num_steps
        move!(r, side)
    end
end