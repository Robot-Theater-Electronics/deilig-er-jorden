//// techno party song


p = PZ_machine(s);
p.beats=4; // cool for silences
a.beats=8;
p.routine.play.quant_(4);
a.routine.play.quant_(4);
p.routine.source = {	inf.do{
		s.bind{
			~funcs.do{|f| f.(); };
		};
		(p.beats).wait;
	} };
a.routine.source = {	inf.do{
		s.bind{
			// audio
			~funcs_a.do{|f| f.(); };
		};
		(a.beats).wait; // must be dynamic
	} };

a.routine.play;
p.routine.play;

~funcs = ();
~funcs_a = ();

// lead
t.tempo_(150/60);
~keizer_techno = {arg chord, amp=0.1, at=0.2, rl=0.1, out=6; {Saw.ar(chord*2).sum*amp*EnvGen.kr(Env.perc(at, rl), doneAction:2); }.play(s, out) };
~keizer_techno = {arg chord, amp=0.1, at=0.2, rl=0.1, out=6; {Saw.ar(chord*2).sum*amp*EnvGen.kr(Env.perc(at, rl), doneAction:2); }.play(s, out) };
// bass
~keizer_technob = {arg note, start=(21/12), dec=0.2, amp=0.01, end=1, rel=4; {LPF.ar(Saw.ar(note*Line.kr(start, end, dec))+SinOsc.ar(note*Line.kr(start, end, dec)).distort, 180)*EnvGen.kr(Env.perc(0.01, rel), doneAction:2)*amp}.play(s, 11);};

~keizer_techno.(~gM7M).play(s, 6);

~funcs['lead'] = {PZ_layer(~chords).rhythm([2],[2],[2],[2])};
~funcs['leadb'] = {PZ_layer(~chords2).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,1,1)};
~funcs['sn'] = {PZ_layer(~sn).rhythm(0,[1],0,[2])};
~funcs['hh'] = {PZ_layer(~hh).rhythm(1,[0],1,[0,2])};
~funcs['bass'] = {PZ_layer(~bass).rhythm(1,0,0,1)};

Ndef(\vac, {BPF.ar(WhiteNoise.ar(0.5)*LFPulse.kr(t.tempo*4).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4, 3));}).play(6,2);

~chords = {~keizer_techno.(~progk.next); };
~progk = Pseq([~em, ~dM7, ~cM7, ~gM7M].stutter(8)*2, inf).asStream;

~chords2 = {~keizer_techno.(~progk2.next, 0.1, 0.1, 0.1, 7); };
~progk2 = Pseq([["B0".namecps, "B1".namecps]], inf).asStream;

~bass = { ~keizerb.(~notes.next, 21/12, t.tempo/8, 0.7, 1/2, 4); }; // soul* | club /
~notes = Pseq([["g0".namecps, "g0".namecps(15)], ["d0".namecps, "d0".namecps(15)]].stutter(2), inf).asStream;

t.playNextBar{
~funcs['leadb'] = nil;
~funcs['bd'] = nil;
~funcs['sn'] = nil;
~funcs['hh'] = nil;
~funcs['bass'] = nil;
};


// verse is only leadb and bd