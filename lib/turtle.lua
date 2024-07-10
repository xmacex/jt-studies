local Turtle = {}

--- construction

function Turtle:new(o)
   o=o or {}
   setmetatable(o,self)
   self.__index=self
   o:init()
   return o
end

function Turtle:init(x, y, dir, speed)
   self.x     = x
   self.y     = y
   self.dir   = dir or nil
   self.speed = speed or nil
   self.show  = false
   self.f     = {x=nil, y=nil, w=nil, h=nil}
end

--- public methods
function Turtle:fence(x, y, w, h)
   self.f.x=x
   self.f.y=y
   self.f.w=w
   self.f.h=h
end

-- Turtle:f = Turtle:fence

function Turtle:step()
   if self.dir == "e" then
      self.x = self.x + self.speed
   elseif self.dir == "w" then
      self.x = self.x - self.speed
   elseif self.dir == "s" then
      self.y = self.y + self.speed
   elseif self.dir == "n" then
      self.y = self.y - self.speed
   end

   -- wrap horizontal
   if self.x < 1 then
      self.x = self.f.w
   end
   if self.x > self.f.w then
      self.x = 1
   end
   -- wrap vertical
      if self.y < 1 then
      self.y = self.f.h
   end
   if self.y > self.f.h then
      self.y = 1
   end

   if self.show then
      self:visualize()
   end
end

-- function Turtle:speed(speed)
--    self.speed = speed
-- end

function Turtle:visualize()
   for y=1,self.f.h do
      row = ""
      for x=1,self.f.w do
	 if y == self.y and x == self.x then
	    row = row.."t"
	 else
	    row = row.."."
	 end
      end
      print(row)
   end
end

function Turtle:test()
   t=Turtle:new()
   t:init(3, 2)
   t:fence(0,0,6,4)
   t.dir   = "s"
   t.speed = 1
   t.show  = true
   tab.print(t)
end

return Turtle
