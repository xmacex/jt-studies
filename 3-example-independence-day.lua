---Part 3. Freedom
--   Example: Independence Day
--
-- jf set to sustain/sound
-- for PLUME. Intone full CW.
-- Patch jf 3N, 5N and 6N.
--
-- https://monome.org/docs/teletype/jt-3/#example-independence-day
--
-- The Teletype version
--
-- #1
-- JF.SHIFT N PN.NEXT 0
-- EVERY 7: JF.TUNE 5 10 3
-- EVERY 10: JF.TUNE 5 20 3
-- EVERY 19: JF.TUNE 5 10 2
-- IF TOSS: JF.TUNE 3 3 1
-- ELSE: JF.TUNE 3 4 1

-- #M
-- SCRIPT 1
-- JF.TR 0 1
-- DEL / M X: JF.TR 0 0

-- #I
-- JF.SHIFT N 0
-- JF.RMODE 1
-- X 5

-- #P
-- -2	0	0	0
-- -3	0	0	0
-- -2	0	0	0
--  5	0	0	0
--  3	0	0	0
--  2	0	0	0

s = require('sequins')

DEBUG = true

p = {
   s{-2,-3,-2,5,3,2}
}

function init()
   crow.input[1].mode('stream', 0.01)
   crow.input[1].stream = function(v) x = util.clamp(v, 0.01, 5) end
   i()
   clock.run(m_runner)
end

function m_runner()
   while true do
      clock.sync(1)
      m()
   end
end

function cleanup()
   crow.ii.jf.retune(0,0,0)
   crow.ii.jf.transpose(0)
   crow.ii.jf.rmode(0)
end

--- Teletype scripts

function s1()
   -- log("s1")
   crow.ii.jf.transpose(p[1]()/12) -- it is N not V
   every( 7, function() crow.ii.jf.retune(5,10,3) end)
   every(10, function() crow.ii.jf.retune(5,20,3) end)
   every(19, function() crow.ii.jf.retune(5,10,2) end)
   if toss() then
      crow.ii.jf.retune(3,3,1)
   else
      crow.ii.jf.retune(3,4,1)
   end
end

function m()
   s1()
   crow.ii.jf.trigger(0,1)
   -- crow.ii.jf.trigger(0,0) -- TODO delay this
   clock.run(function()
	 clock.sync(1/x)
	 crow.ii.jf.trigger(0,0)
   end)
end

function i()
   crow.ii.jf.transpose(0)
   crow.ii.jf.rmode(1)
   x = 5
end

--- UI

function redraw()
   screen.clear()
   screen.aa(1)
   screen.move(0, 30)
   screen.font_face(1)
   screen.font_size(8)
   screen.level(1)
   screen.text("part 3. Freedom")

   screen.font_face(10)
   screen.font_size(14)
   screen.level(10)
   screen.move(5, 43)
   screen.text("Independence Day")
   screen.update()
end

--- Teletype language. Could put it int a library

function every(n, f)
   if util.round(clock.get_beats()) % n == 0 then f() end
end

function toss()
   return math.random() > 0.5
end

--- Utils

function log(s)
   if DEBUG then print(s) end
end

-- Query callback

crow.ii.jf.event = function(e, value)
   if e.name == 'retune' then
      print(e.name..": "..value)
   end
end

-- Local Variables:
-- flycheck-luacheck-standards: ("lua51" "norns"))
-- End:
