local distance = 0
local stripMineDistance = 0

local placeTorch = false
local stripMine = false
local fuelNeeded = false

local fuel = turtle.getItemCount(1)
local torch = turtle.getItemCount(2)
local chest = turtle.getItemCount(3)
local block = turtle.getItemCount(4)

local function askStripMine()
    print("Do you want Strip Mining? 0(no) or 1(yes)")
    input2 = io.read()
    input2Number = tonumber(input2)
    if input2Number == 0 then
        stripMine = false
    elseif input2Number == 1 then
        stripMine = true
    else
        print("Please Just Enter 0 or 1 ! >.<")
        askStripMine()
    end 
end


print("How far do you want your Mine?")
input = io.read()
distance = tonumber(input)

askStripMine()


