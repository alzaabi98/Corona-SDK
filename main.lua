display.setStatusBar( display.HiddenStatusBar )

display.setDefault( "anchorX",  0)
display.setDefault( "anchorY", 0)
local horse
local function fitImage( displayObject, fitWidth, fitHeight, enlarge )
  --
  -- first determine which edge is out of bounds
  --
  local scaleFactor = fitHeight / displayObject.height 
  local newWidth = displayObject.width * scaleFactor
  if newWidth > fitWidth then
    scaleFactor = fitWidth / displayObject.width 
  end
  if not enlarge and scaleFactor > 1 then
    return
  end
  displayObject:scale( scaleFactor, scaleFactor )
end


--[[
local temp = display.newImage( "horse.jpeg")
temp.x = 50
temp.y = 50
local w = temp.width
print(w)
--print (temp.width)

fitImage( temp, 50, 50, false )
]]


local function networkListener( event )
    if ( event.isError ) then
        print ( "Network error - download failed" )
    else
        event.target.alpha = 0.5
        --fitImage( horse, 50, 50, false )
        transition.to( event.target, { alpha = 1.0 } )

    end

    print ( "event.response.fullPath: ", event.response.fullPath )
    print ( "event.response.filename: ", event.response.filename )
    print ( "event.response.baseDirectory: ", event.response.baseDirectory )

end

horse = display.loadRemoteImage( "http://omanevents.net/OmanEventsApp/oeImages/horse.png", "GET", networkListener, "horseCopy.png", system.TemporaryDirectory)





local physics = require ("physics")
physics.start()
physics.setDrawMode("hybrid")

local numberSmiles = 4 --local variable; amount can be changed

local function touchSmile( thisSmile )
    --print (thisSmile.type)
    print(thisSmile.target.type)
    display.remove( thisSmile.target ) ; thisSmile.target = nil
end

local function clearSmile( thisSmile )
   display.remove( thisSmile ) ; thisSmile = nil
end

local function spawnSmiles()

   for i=1,numberSmiles do
      local smile = display.newImageRect("smile.png", 45, 45);
      -- smile:setReferencePoint(display.CenterReferencePoint);  --not necessary; center is default
      smile.x = math.random(-10, 400);
      smile.y = -40;
      smile.type = "monkey"..i
      transition.to( smile, { time=math.random(2000,8000), x=math.random(-10,400) , y=600, onComplete=clearSmile } );
      physics.addBody( smile, "dynamic", { density=0.1, bounce=0.1, friction=0.1, radius=20 } );

      --Adding touch event
      smile:addEventListener( "touch", touchSmile );
   end

end

timer.performWithDelay( 5000, spawnSmiles, 0 )  --fire every 10 seconds

