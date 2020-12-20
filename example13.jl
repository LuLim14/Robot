function solve!(r)
    

    for side in ((Nord, West), (Nord, Ost), (Sud, Ost), (Sud, West))
        put_diag!(r, side)
        back!(r, side)
    end

    putmarker!(r)


end


function put_diag!(r, side::NTuple{2, HorizonSide})
    while (isborder(r, side[1]) == false && isborder(r, side[2]) == false)
        move!(r, side[1])
        move!(r, side[2])
        putmarker!(r)
    end
end

function back!(r, side) 
    while (ismarker(r)) 
        move!(r, inverse(side[1]))
        move!(r, inverse(side[2]))
    end
end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side) + 2, 4))