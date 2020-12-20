function main!(r::Robot)
    num_south = moves!(r,Sud)
    num_west = moves!(r, West)
 # in left lower corner
    goback!(r)
 
    c = 0
    while isborder(r, Nord) == false
         paintline!(r, c)
         c += 1
         goback!(r)
         move!(r, Nord)
    end
    
 #without high level
    while isborder(r, West) == false
         paintline!(r, c)
    end
 #with high level
    while isborder(r, Sud) == false
         move!(r, Sud)
     end
 #in left lower
    moves!(r, Ost, num_west)
    moves!(r, Nord, num_south)
 #in start point
    
    
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
    putmarkers!(r, West)
    

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
