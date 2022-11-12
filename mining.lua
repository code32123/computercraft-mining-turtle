---@diagnostic disable: undefined-global

local distance = 0
local distanceDigged = 0
local distanceDiggedTorchDistance = 0
local stripMineDistance = 0
local stripMineDistanceDigged = 0
local stripMineLength = 0
local stripMineLengthDigged = 0
local stripMineLengthTorchDistance = 0

local stripMine = false
local isLeft = false

local fuelSlot = 1
local torchSlot = 2
local chestSlot = 3
local blockSlot = 4
print("Fuel  slot:", fuelSlot)
print("Torch slot:", torchSlot)
print("Chest slot:", chestSlot)
print("Block slot:", blockSlot)

local function askStripMine()
    print("Do you want Strip Mining? \n 0(no) or 1(yes)")
    input = io.read()
    inputNumber = tonumber(input)
    if inputNumber == 0 then
        stripMine = false
    elseif inputNumber == 1 then
        stripMine = true
    else
        print("Please Just Enter 0 or 1 ! >.<")
        sleep(1.5)
        askStripMine()
    end 
end

local function checkFuelAndRefill()
    fuelLevel = turtle.getFuelLevel()
    if fuelLevel ~= 0 then
        if fuelLevel < 100 then
            turtle.select(fuelSlot)
            if not turtle.refuel(turtle.getItemCount(fuelSlot)) then
                print("Low on Fuel please Refill!")
            end
        else
            print("Enough Fuel for now.")
            print("Current Fuel level:", fuelLevel)
        end 
    end
end

local function checkTorchAndPlace()
    -- Check Torch Count
    if turtle.getItemCount(torchSlot) > 0 then
        turtle.turnLeft()
        turtle.turnLeft()
        turtle.select(torchSlot)
        turtle.place()
        turtle.turnRight()
        turtle.turnRight()
    else
        print("No Torch, no Light. :(")
    end
end

local function checkTorchAndPlace_2()
    -- Check Torch Count
    if turtle.getItemCount(torchSlot) > 0 then
        turtle.turnLeft()
        turtle.select(torchSlot)
        turtle.place()
        turtle.turnRight()
    else
        print("No Torch, no Light. :(")
    end
end

local function placeBlockBelow()
    if not turtle.detectDown() then
        
        -- Check Block Count
        if turtle.getItemCount(blockSlot) > 0 then
            turtle.select(blockSlot)
            turtle.placeDown()
            print("Placed a Block under me.")
        else
            print("No Blocks in Slot 4, i will be floating like jesus :)")
        end
    else
        print("There is a Block under me, nothing to Place.")
    end
end

local function digForward()
    if turtle.detect() then
        turtle.dig()
        turtle.forward()

        if turtle.detectUp() then 
            turtle.digUp()
        end
    else
        turtle.forward()

        if turtle.detectUp() then 
            turtle.digUp()
        end
    end
end

local function placeChestIfNeeded()
    -- Checking for Chest count
    if turtle.getItemCount(chestSlot) > 0 then
        -- Checking last item slot to check if inventory is full
        if turtle.getItemCount(16) > 0 then
            turtle.select(chestSlot) 

            if stripMine then
                if stripMineLengthDigged > 0 then
                    turtle.turnLeft()
                    turtle.turnLeft()

                    for block = 0, stripMineLengthDigged - 1 do
                        digForward()
                    end

                    print("Need a chest!")
                    turtle.digDown()
                    turtle.placeDown()
                    print("Placed a chest.")

                    for slot = 5, 16 do
                        turtle.select(slot)
                        turtle.dropDown(turtle.getItemCount())
                    end

                    turtle.turnLeft()
                    turtle.turnLeft()

                    for block = 0, stripMineLengthDigged - 1 do
                        digForward()
                    end
                else
                    print("Need a chest!")
                    turtle.digDown()
                    turtle.placeDown()
                    print("Placed a chest.")

                    for slot = 5, 16 do
                        turtle.select(slot)
                        turtle.dropDown(turtle.getItemCount())
                    end
                end
            else
                print("Need a chest!")
                turtle.digDown()
                turtle.placeDown()
                print("Placed a chest.")

                for slot = 5, 16 do
                    turtle.select(slot)
                    turtle.dropDown(turtle.getItemCount())
                end
            end

           
            print("Placed all items into the Chest.")
        end
    else 
        print("No chest shutting down to prevent Overload.")
        if turtle.getItemCount(16) > 0 then
            os.shutdown()
        end
    end

    turtle.select(fuelSlot)
end

local function digStripMiningHallway()
    turtle.turnLeft()

    -- Setting direction in witch the turtle is looking
    isLeft = true

    repeat
        checkFuelAndRefill()
        placeBlockBelow()
        placeChestIfNeeded()
        digForward()
        
        if stripMineLengthDigged % 10 == 9 then
            checkTorchAndPlace_2()
        end

        stripMineLengthDigged = stripMineLengthDigged + 1
    until stripMineLengthDigged == stripMineLength

    turtle.turnLeft()
    turtle.turnLeft()

    repeat
        digForward()
        stripMineLengthDigged = stripMineLengthDigged - 1
    until stripMineLengthDigged == 0

    -- Setting direction in witch the turtle is looking
    isLeft = false
    
    repeat
        checkFuelAndRefill()
        placeBlockBelow()
        placeChestIfNeeded()
        digForward()
        
        if stripMineLengthDigged % 10 == 9 then
            checkTorchAndPlace_2()
        end

        stripMineLengthDigged = stripMineLengthDigged + 1
    until stripMineLengthDigged == stripMineLength
   
    turtle.turnLeft()
    turtle.turnLeft()

    repeat
        digForward()
        stripMineLengthDigged = stripMineLengthDigged - 1
    until stripMineLengthDigged == 0

    turtle.turnRight() 
end

print("How far do you want your Mine?")
input = io.read()
distance = tonumber(input)

askStripMine()

if stripMine then 
    print("Length of Strip mine hallway:")
    input = io.read()
    stripMineLength = tonumber(input)
    
    print("Distance between Strip mine hallways:")
    input = io.read()
    stripMineDistance = tonumber(input) + 1
end

repeat
    checkFuelAndRefill()
    placeBlockBelow()
    placeChestIfNeeded()
    digForward()
    
    distanceDigged = distanceDigged + 1
    distanceDiggedTorchDistance = distanceDiggedTorchDistance + 1

    if stripMine then
        stripMineDistanceDigged = stripMineDistanceDigged + 1

        if stripMineDistanceDigged == stripMineDistance then
            digStripMiningHallway()
            stripMineDistanceDigged = 0
        end
    end

    if distanceDiggedTorchDistance == 7 then
        checkTorchAndPlace()
        distanceDiggedTorchDistance = 0
    end

until distance == distanceDigged
