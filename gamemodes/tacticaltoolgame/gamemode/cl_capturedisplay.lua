local needtodisplay = false
local curcaptime = 0
local fulltime = TIME_TO_CAPTURE

local function CaptureTimeHud()

	local function  CaptureUpdate(num)
		curcaptime =  num:ReadString()
	end
	usermessage.Hook("CaptureUpdate", CaptureUpdate)


	local function IfCaptureOn(bool)
		 needtodisplay = bool:ReadBool()
	end
	usermessage.Hook("IfCaptureOn", IfCaptureOn)
	
	
	
	if needtodisplay then 
	
		local white = Color(255,255, 255, 255)
		local barwidth = 200-((curcaptime/fulltime)*200)
		
		//dark grey background box
		draw.RoundedBox(8, ScrW()/2 - 112, 175, 220, 70, Color(50,50,50,255))	
		
		//the grey box behind the capture time display
		draw.RoundedBox(8, ScrW()/2 - 102, 185, 200, 50, Color(70,70,70,255))
		
		//moving bar representing how much time is left
		draw.RoundedBox(8, ScrW()/2 - 102, 185, barwidth, 50, white)
	end
	
	
end
hook.Add("HUDPaint", "CaptureTimeHud", CaptureTimeHud)