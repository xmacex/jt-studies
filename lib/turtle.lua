local Turtle = {}

Turtle.DIRS = {"n", "e", "s", "w"}
--- construction

function Turtle:new(o)
   o=o or {}
   setmetatable(o,self)
   self.__index=self
   o:init()
   return o
end

function Turtle:init(x, y, dir, speed)
   self.x      = x or 1
   self.y      = y or 1
   self._dir   = dir or "e"
   self._speed = speed or 0
   self.viz    = false
   self.echo   = false
   self.f      = {x=4, y=1, w=4, h=1}
   self._p     = {{0,0,0,0}}
end

--- public methods
function Turtle:fence(p, x, y, w, h)
   self._p=p or nil
   self.f.x=x
   self.f.y=y
   self.f.w=w
   self.f.h=h
end

function Turtle:dir(dir)
   if dir then
      self._dir = dir
   else
      return self._dir
   end
end

function Turtle:speed(speed)
   if speed then
      self._speed = speed
   else
      return self._speed
   end
end

function Turtle:step()
   if self._dir == "e" then
      self.x = self.x + self._speed
   elseif self._dir == "w" then
      self.x = self.x - self._speed
   elseif self._dir == "s" then
      self.y = self.y + self._speed
   elseif self._dir == "n" then
      self.y = self.y - self._speed
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

   if self.viz then
      self:visualize()
   end

   if self.echo then
      print(self:value())
   end
end

-- function Turtle:speed(speed)
--    self._speed = speed
-- end

function Turtle:value()
   local v = 0
   if self._p[self.x] and self._p[self.x][self.y] then
      v = self._p[self.x][self.y]
   end
   return v
end


function Turtle:visualize()
   for y=1,self.f.h do
      local row = ""
      for x=1,self.f.w do
	 if y == self.y and x == self.x then
	    -- row = row.."t"
	    -- row = row..self._dir
	    if self._dir == "n" then row = row.."^"
	    elseif self._dir == "e" then row = row..">"
	    elseif self._dir == "s" then row = row.."v"
	    elseif self._dir == "w" then row = row.."<"
	    end
	 else
	    -- if self._p[x] and self._p[x][y ]then
	    --    row = row..self._p[x][y]
	    -- else
	    --    row = row.."."
	    -- end
	    row = row.."."
	 end
      end
      print(row)
   end
   print()
end

function Turtle:test()
   t=Turtle:new()
   t:init(3, 2)
   p = { {1,2,3,4}, {5,6,7,8} }
   t:fence(p, 0,0,4,2)
   -- t._dir   = "s"
   t:dir("s")
   t._speed = 1
   t.viz    = true
   t.echo   = true
   tab.print(t)
end

return Turtle
