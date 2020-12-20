function solve!(r)
    
    num_steps = []

    take_mark = true
    direct = Ost


    
    while (isborder(r, Sud) == false || isborder(r,West) == false)
        if (isborder(r, West) == false)
            push!(num_steps, 0)
            move!(r, West)
            take_mark = !take_mark
        end

        if (isborder(r, Sud) == false)
            push!(num_steps, 1) 
            move!(r, Sud)
            take_mark = !take_mark
        end
    end
    #in left corner

    #go to right corner and take markers

    while !(isborder(r, Nord) && isborder(r, Ost))
        if (take_mark)
            putmarker!(r)
        end
        
        if  isborder(r, West) && !(isborder(r, Sud) && isborder(r, West)) || isborder(r, Ost)
            move!(r, Nord)
            take_mark = !take_mark

            if (take_mark)
                putmarker!(r)
            end

            direct = inverse(direct)
        end

        move!(r, direct)
        take_mark = !take_mark  
    end
    
    if take_mark
        putmarker!(r)
    end

    #in left corner
    moves!(r, Sud)
    moves!(r, West)

    for i in reverse(num_steps)
        if (i == 0)
            move!(r, Ost)
        elseif (i == 1)
            move!(r, Nord)
        end
    end
    #in start pos

end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end