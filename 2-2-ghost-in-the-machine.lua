---Part 2. Nudge Nudge
--         Ghost in the machine
--
-- start with jf in shape/cycle
-- & knobs at 12
--
-- shape/cycle RUN = VOLLEY
--
-- The original Teletype version
--
-- JF.RMODE 1  ← activate RUN mode
-- JF.RUN V 0  ← RUN voltage = 0V
-- JF.TR 0 1   ← TRIGGER all channels, 6 repetitions
-- JF.RUN V -1 ← RUN voltage = -1V
-- JF.TR 1 1   ← TRIGGER channel 1, 4 repetitions
-- JF.RUN V 4  ← RUN voltage = 4V
-- JF.TR 2 1   ← TRIGGER channel 2, 25 repetitions
-- JF.RUN vv -50 ← RUN voltage = -0.5V
-- JF.TR 3 1   ← TRIGGER channel 3, 5 repetitions

s = require('sequins')

steps = s{
   {v=1,  ch=0},
   {v=-1, ch=1},
   {v=4,   ch=2},
   {v=0.5, ch=3}
}

function init()
   crow.ii.jf.run_mode(1) 	-- volley mode
   crow.ii.jf.trigger(1, 0)
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
   screen.text("Ghost in the")
   screen.move_rel(-screen.text_extents("machine"), 14)
   screen.text("machine")
   screen.update()
end

function key(k, z)
   if k == 3 and z == 1 then
      local step = steps()
      tab.print(step)
      print("🎵")
      crow.ii.jf.run(step.v)
      crow.ii.jf.trigger(step.ch, 1)
   end
end


-- Panel query callback

crow.ii.jf.event = function( e, value )
   if e.name == 'run_mode' or e.name == 'run' then
      tab.print(e)
      print(value)
   elseif e.name == 'run' then
      tab.print(e)
      print(value)
   end
end
