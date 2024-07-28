---Part 2. Nudge Nudge
--         Presence
--
-- start with jf in shape/cycle
-- & knobs at 12
--
-- shape/cycle RUN = VOLLEY
-- 6 reps for each trigger
--
-- The original Teletype version
--
-- JF.RMODE 1
-- JR.TR 0 1

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
   screen.text("part 2. Nudge Nudge")
   screen.font_face(10)
   screen.font_size(14)
   screen.move(5, 43)
   screen.text("Presence")
   screen.update()
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
