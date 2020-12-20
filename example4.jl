function main!(r::Robot)
   
    num_vert = moves!(r, Sud)
    num_hor = moves!(r, West)
    #в левом нижнем

    cnt = 0
    goback!(r)
    while isborder(r, Nord) == false 
           if isborder(r, West) == false
                paintline!(r, cnt)
                goback!(r)
                if isborder(r, Nord) == false
                    move!(r, Nord)
                end
                cnt += 1
            end
    end


    paintline!(r, cnt)

    while isborder(r, Sud) == false
         move!(r, Sud)
    end

    moves!(r, Ost, num_hor)
    moves!(r, Nord, num_vert)


    # поддерживаю количество незкарашенных клеток в текущей строке(начинаем с 0), на каждой новой строке ++, затем на каждой похожу это 
    #кол-во, не помечая клетки, затем крашу. Пока не дойдём до правого верхнего. Спускаюсь и иду в начальну клетку

    
end


    

function goback!(r::Robot)
    while isborder(r, Ost) == false
        move!(r, Ost)
    end
    
end

function paintline!(r::Robot, cnt::Int)
   while cnt > 0
        if isborder(r, West) == false 
            move!(r, West)
        end
        cnt -= 1       
   end
    
   putmarker!(r)
    while isborder(r, West) == false
        putmarkers!(r, West)
    end

end

function moves!(r::Robot,side::HorizonSide)
    num_steps=0
    while isborder(r,side)==false
        move!(r,side)
        num_steps+=1
    end
    return num_steps
end

function moves!(r::Robot,side::HorizonSide,num_steps::Int)
    for i in 1:num_steps
        move!(r, side)
    end
end

function putmarkers!(r::Robot, side::HorizonSide)
    while isborder(r,side)==false
        move!(r,side)
        putmarker!(r)
    end
end


