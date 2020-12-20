function solve(r)
    side = Ost
    while isborder(r,Nord) == true #in upper line
        putmarker!(r)
        move_by_markers!(r,side)
        side = inverse(side)
    end
end

move_by_markers!(r,side) = while ismarker(r) move!(r,side) end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2,4))