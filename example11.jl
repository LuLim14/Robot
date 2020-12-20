function solve!(r)
    horiz_cnt = 0
    vert_cnt = 0

    steps = []
 
    while (isborder(r,West) == false || isborder(r,Sud) == false )
        if (isborder(r, Sud) == false)
            vert_cnt += 1
            push!(steps, 1)
            move!(r, Sud)
        end

        if (isborder(r, West) == false)
            horiz_cnt += 1
            push!(steps, 0)
            move!(r, West)
        end
    end
    #in left corner
   



    for side in (Nord, Ost, Sud, West)
        if (side == Sud || side == Nord)
            vert_cnt = get_move!(r, side, vert_cnt)
        else
            horiz_cnt = get_move!(r, side, horiz_cnt)

        end
    end

    for i in reverse(steps)
        if (i == 1)
            move!(r, Nord)
        elseif (i == 0)
            move!(r, Ost)
        end
    end

    #in start position


end



function get_move!(r, side,  t)

    while (t > 0)
        move!(r, side)
        t -= 1
    end
    putmarker!(r)

    while !isborder(r, side)
        move!(r, side)
        t += 1
    end

    return t
end