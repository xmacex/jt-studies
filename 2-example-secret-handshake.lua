---Part 2. Nudge Nudge
--   Example: Secret Handshake
--
-- jf set to shape/transient
-- for SHIFT.
--
-- crow out1 and out2 move
-- through a pettern.
--
-- https://monome.org/docs/teletype/jt-2/#example-secret-handshake
--
-- The Teletype version
--
-- #1
-- JF.RUN V -3
-- CV.OFF 1 N -7; CV.OFF 2 N 7
--
-- #2
-- JF.RUN V -1
-- CV.OFF 1 N 7; CV.OFF 2 N 7
--
-- #3
-- JF.RUN VV 1
-- CV.OFF 1 N 0; CV.OFF 2 N 0
--
-- #4
-- JF.RUN V 3
-- CV.OFF 1 N -7
--
-- #5
-- JF.RUN V 1
-- EVERY 2: CV.OFF 2 V 2
-- OTHER: CV.OFF 2 V 0
--
-- #6
--
-- #7
--
-- #8
--
-- #M
-- JF.TR 0 1
-- CV 2 N PN.NEXT 0
-- EVERY 4: CV 1 N PN.NEXT 1
-- EVERY 16: SCRIPT RRAND 1 5
--
-- #I
-- JF.RMODE 1
--
-- #P
-- 0	7	0	0
-- 4	11	0	0
-- 7	14	0 	0
-- 11	18	0	0


s = require('sequins')

DEBUG = false

p = {
   s{0, 4, 7,11},
   s{7,11,14,18}
}

function init()
   i()
   clock.run(m_runner)
end

function m_runner()
   while true do
      clock.sync(1/4)
      m()
   end
end

function cleanup()
   crow.ii.jf.run_mode(0)
end

--- Teletype scripts

function s1()
   log("s1")
   crow.ii.jf.run(-3)
   crow.output[1].volts = -7
   crow.output[2].volts = 7
end

function s2()
   log("s2")
   crow.ii.jf.run(-1)
   crow.output[1].volts = 7
   crow.output[2].volts = 7
end

function s3()
   log("s4")
   crow.ii.jf.run(1)
   crow.output[1].volts = 0
   crow.output[2].volts = 0
end

function s4()
   log("s4")
   crow.ii.jf.run(3)
   crow.output[1].volts = -7
end

function s5()
   log("s5")
   crow.ii.jf.run(-1)
   if util.round(clock.get_beats()) % 2 == 0 then
      log("every")
      crow.output[2].volts = 2
   else
      log("other")
      crow.output[2].volts = 0
   end
end

scripts = {s1, s2, s3, s4, s5}

function m()
   crow.ii.jf.trigger(0,1)
   crow.output[2].volts = p[1]()
   every( 4, function() crow.output[1].volts = p[1]() end)
   every(16, function() scripts[math.random(#scripts)]() end)
end

function i()
   crow.ii.jf.run_mode(1)
end

--- UI

function redraw()
   screen.clear()
   screen.aa(1)
   screen.move(0, 30)
   screen.font_face(1)
   screen.font_size(8)
   screen.level(1)
   screen.text("part 2. Nudge Nudge")

   screen.font_face(10)
   screen.font_size(14)
   screen.level(10)
   screen.move(5, 43)
   screen.text("Secret Handshake")
   screen.update()
end

function key(n, z)
   if n == 2 and z == 1 then
      crow.ii.jf.get('run_mode')
      crow.ii.jf.get('run')
   end
end

--- Utils

function every(n, f)
   if util.round(clock.get_beats()) % n == 0 then f() end
end

function log(s)
   if DEBUG then print(s) end
end

-- Query callback

crow.ii.jf.event = function(e, value)
   if e.name == 'run_mode' or e.name == 'run' then
      print(e.name..": "..value)
   end
end

-- Local Variables:
-- flycheck-luacheck-standards: ("lua51" "norns"))
-- End:
