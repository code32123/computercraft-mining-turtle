local distance = 0
local distanceDigged = 0
local stripMineDistance = 0

local placeTorch = false
local stripMine = false
local fuelNeeded = false

local fuelSlot = 1
local torchSlot = 2
local chestSlot = 3
local blockSlot = 4

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

local function placeChestIfNeeded()
    -- Checking for Chest count
    if turtle.getItemCount(chestSlot) > 0 then 
        if turtle.getItemCount(16) > 0 then
            
        end
    end
end

local function digForward()

end

print("How far do you want your Mine?")
input = io.read()
distance = tonumber(input)

askStripMine()

repeat
    checkTorchAndPlace() -- remove
    checkFuelAndRefill()
    placeBlockBelow()
    placeChestIfNeeded()
    digForward()

    distanceDigged = distanceDigged + 1
    distance = distance - 1

    if distanceDigged == 10 then
        checkTorchAndPlace()
    end

    sleep(0.5)
until distance == 0
