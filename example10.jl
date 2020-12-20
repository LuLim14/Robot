function solve!(r)

    cnt = 0
    sum = 0
    direct = Ost
    #in  left corner

    while (isborder(r, Nord) == false || isborder(r, Ost) == false)
            if ismarker(r)
                cnt += 1
                sum += temperature(r)
            end

            if isborder(r, West) && !(isborder(r, West) && isborder(r, Sud)) || isborder(r, Ost)
                direct = inverse(direct)
                move!(r, Nord)
            end

            move!(r, direct)


    end

    print(sum / cnt)

end

inverse(side::HorizonSide) = HorizonSide(mod(Int(side)+2, 4))