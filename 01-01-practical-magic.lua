---Part 1. Practical Magic
--
-- start with jf in
--   shape/sustain.
--
-- k2: toggle all
-- k3: 1000ms gate on ch  6

function init()
   -- somehow running jf triggers from
   -- init just trigger them once without leaving them up.
   -- running trigger later is fine either
   -- from REPL or key
end

function step_2()
   crow.ii.jf.trigger(6, 1)
   clock.run(note_off, 6, 1.000)
end

function note_off(ch, sec)
   print("waiting for "..sec.." sec")
   clock.sleep(sec)
   crow.ii.jf.trigger(ch, 0)
end

function key(k, z)
   if k == 2 then
      if z == 1 then
	 crow.ii.jf.trigger(0, 1)
      elseif z == 0 then
	 crow.ii.jf.trigger(0, 0)
      end
   elseif k == 3 and z == 1 then
      step_2()
   end
end

function redraw()
   screen.clear()
   screen.aa(1)
   screen.move(0, 30)
   screen.font_face(1)
   screen.font_size(8)
   screen.text("study 1.1")
   screen.font_face(10)
   screen.font_size(14)
   screen.move(5, 43)
   screen.text("Practical Magic")
   screen.update()
end
