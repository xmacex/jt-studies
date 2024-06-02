--- Part 1. Practical Magic
--- The Teletype version
-- #1
-- EVERY 3: JF.TR 1 1
-- EVERY 5: JF.TR 3 1
-- EVERY 4: JF.TR 4 1
-- EVERY 2: JF.TR 5 1
-- EVERY 7: JF.TR 6 1
-- EVERY 2: JF.TR 0 0

-- #2

-- #3

-- #4

-- #5

-- #6

-- #7

-- #8

-- #M
-- @STEP; @DIR RRAND -180 180
-- CV 1 N @; SCRIPT 1
-- EVERY 30: CV 2 V RAND 10

-- #I
-- M 120
-- @F 0 0 4 4; @SPEED 300
-- CV.SLEW 2 3000

-- #P
-- 4   16  19  11
-- 7   7   0   12
-- 0   12  11  16
-- 11  7   4   23
-- 19  23  7   19

s = require('sequins')

function init_s1()
   function seq1fn() crow.ii.jf.trigger(1, 1) end
   function seq2fn() crow.ii.jf.trigger(3, 1) end
   function seq3fn() crow.ii.jf.trigger(4, 1) end
   function seq4fn() crow.ii.jf.trigger(5, 1) end
   function seq5fn() crow.ii.jf.trigger(6, 1) end
   function seq6fn() crow.ii.jf.trigger(0, 0) end
   seq1 = s{seq1fn}:every(3)
   seq2 = s{seq2fn}:every(5)
   seq3 = s{seq3fn}:every(4)
   seq4 = s{seq4fn}:every(2)
   seq5 = s{seq5fn}:every(7)
   seq6 = s{seq6fn}:every(2)
end

function s1()
   local step_1 = seq1()
   if step_1 ~= "skip" then step_1() end
   local step_2 = seq2()
   if step_2 ~= "skip" then step_2() end
   local step_3 = seq3()
   if step_3 ~= "skip" then step_3() end
   local step_4 = seq4()
   if step_4 ~= "skip" then step_4() end
   local step_5 = seq5()
   if step_5 ~= "skip" then step_5() end
   local step_6 = seq6()
   if step_6 ~= "skip" then step_6() end
end

function init_m()
   function mfn(v) crow.output[2].volts = v end
   seqm = s{mfn}:every(30)
end

function m()
   step_m = seqm()
   if step_m ~= 'skip' then step_m(math.random(10)) end
   s1()
end

function i()
   crow.output[2].slew = 3
end

-- Norns lifecycle things

function init()
   redraw()
   init_s1()
   init_m()
   i()
   clock.run(m_runner)
end

function m_runner()
   while true do
      clock.sync(1/4)
      m()
   end
end

-- TODO the whole turtle thing, on crow output 1

--- UI

function redraw()
   screen.clear()
   screen.aa(1)
   screen.move(0, 30)
   screen.font_face(1)
   screen.font_size(8)
   screen.text("study 1")
   screen.font_face(10)
   screen.font_size(14)
   screen.move(5, 43)
   screen.text("Practical Magic")
   screen.update()
end
