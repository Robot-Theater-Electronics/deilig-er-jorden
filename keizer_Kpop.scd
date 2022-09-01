//// K-pop

a = PZ_machine(s);
p = PZ_machine(s);
p.beats=4; // cool for silences
a.beats=24;
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

// Intro (medieval electronic)
~keizer_medieval = {arg chord, amp=0.1, at=0.2, rl=0.1, out=6; {SinOsc.ar(chord).sum*amp*EnvGen.kr(Env.perc(at, rl), doneAction:2); }.play(s, out) };
~keizer_medieval_dist = {arg chord, amp=0.1, at=0.2, rl=0.1, out=6; {SinOsc.ar(chord).sum.distort*amp*EnvGen.kr(Env.perc(at, rl), doneAction:2); }.play(s, out) };

~medieval_chord.(~g5, 0.1, 0.1);
~prog_m = Pseq([~g5, ~a5, ~g5, ~g5, ~c5, ~g5, ~fs5, ~b5], inf).asStream;

~rev = {|in=60, amp=0.1, dec=88| GVerb.ar(In.ar(in), 120, dec)*amp};
~fx = {|in=16, amp=0.1, dec=160, dur=2| CombN.ar(PitchShifter.ar(In.ar(in), 3, dur, 2,1,0.001), 0.1, 2/t.tempo, dec)*amp};

~revs[60] = ~rev.play(s,6,2);
~revs[60].free;
~fxs[60] = ~fx.play(s, 60,2);
~fxs[60].free;
//
// ~fxs[60].set(\dec, 160, \dur, 2);
// ~medieval.();
// ~funcs_a['medieval'] = {PZ_layer(~medieval).rhythm(1,0,0,0)};
// ~medieval = {~medieval_chord.(~prog_m.next)};
// a.beats=8;
// ~revs[60].set(\dec, 2);~fxs[60].set(\dec, 20);

~funcs = ();
~funcs_a = ();

// lead
t.tempo_(150/60);
~keizer_techno = {arg chord, amp=0.1, at=0.2, rl=0.1, out=6; {Saw.ar(chord*2).sum*amp*EnvGen.kr(Env.perc(at, rl), doneAction:2); }.play(s, out) };
// bass
~keizer_technob = {arg note, start=(21/12), dec=0.2, amp=0.01, end=1, rel=4; {LPF.ar(Saw.ar(note*Line.kr(start, end, dec))+SinOsc.ar(note*Line.kr(start, end, dec)).distort, 180)*EnvGen.kr(Env.perc(0.01, rel), doneAction:2)*amp}.play(s, 11);};

~keizer_techno.(~gM7M);

~chords = {~keizer_techno.(~progk.next); };
~progk = Pseq([~em, ~dM7, ~cM7, ~gM7M].stutter(8)*2, inf).asStream;

~chords2 = {~keizer_techno.(~progk2.next, 0.1, 0.1, 0.1, 7);};
~progk2 = Pseq([["B0".namecps, "B1".namecps]], inf).asStream;

~bass = { ~keizerb.(~notes.next, 21/12, t.tempo/8, 0.7, 1/2, 4); }; // soul* | club /
~notes = Pseq([["g0".namecps, "g0".namecps(15)], ["d0".namecps, "d0".namecps(15)]].stutter(2), inf).asStream; // work on bass...

// MEDIEVAL INTRO
a.beats = 24;
~revs[60].set(\dec, 88);~fxs[60].set(\dec, 160);
~prog_m = Pseq([~g5, ~a5, ~g5, ~e5, ~c5, ~fs5, ~a5, ~b5], inf).asStream;
~medieval = {~medieval_chord.(~prog_m.next, )};
~funcs_a['medieval'] = {PZ_layer(~medieval).rhythm(1,0,0,0)};

(
Tdef(\structure, {
	var bar=4; //intro x16 (?)
	~bd = { Synth(\sampleNarcode, [\buf, ~buffers['bd'], \amp, 1, \out, 8])};
	~funcs['lead'] = {PZ_layer(~chords).rhythm([2],[2],[2],[2])};
	(3*bar*p.beats).wait; //
~prog_m = Pseq([~e5, ~d5, ~c5, ~g5].stutter(4)*1, inf).asStream;
~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,1,1)};
~medieval = {~medieval_chord.(~prog_m.next, 0.01, 0.2)};
		Tdef(\intro).play;
	(bar*p.beats).wait;
	a.beats=4;
// verse x16
~funcs_a['medieval']=nil;
~bd = { Synth(\sampleNarcode, [\buf, ~buffers['bd'], \amp, 1, \out, 8]); ~keizer_technob.(~progk2.next, 4, 0.1, 0.5, 1, 1);};
~revs[60].set(\dec, 2);~fxs[60].set(\dec, 2, \dur, 0.01);
~funcs['sn'] = nil;
~funcs['lead'] = nil;
~funcs['leadb'] = {PZ_layer(~chords2).rhythm([0,1],[0,1],[0,1],[0,1])};
	// ~funcs_a['medieval'] = {PZ_layer(~medieval).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,1,1)};
~funcs['hh'] = {PZ_layer(~hh).rhythm(1,[0],[0],[0])};
	(bar*p.beats).wait; //1
	~funcs['hh'] = {PZ_layer(~hh).rhythm(1,[0],[1],[0])};
	(bar*p.beats).wait; //2
	// verse 1.2
		~funcs['hh'] = {PZ_layer(~hh).rhythm([1],[0],[2],[0])};
	(bar*p.beats).wait; //3
	(2*p.beats).wait; //4.1
	Tdef(\hhbreak).play;
	(2*p.beats).wait; //4.3

	// chorus
~funcs_a['medieval'] = {PZ_layer(~medieval).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['lead'] = {PZ_layer(~chords).rhythm([2],[2],[2],[2])};
~funcs['leadb'] = {PZ_layer(~chords2).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,1,1)};
~funcs['sn'] = {PZ_layer(~sn).rhythm(0,[1],0,[2])};
~funcs['hh'] = {PZ_layer(~hh).rhythm(1,[0],1,[0,2])};
~funcs['bass'] = nil;
	(7*bar*p.beats).wait; //8
	Tdef(\intro).play;
	(bar*p.beats).wait; //to verse

	// verse 2
~funcs['sn'] = nil;
~funcs_a['medieval'] = nil;
~funcs['bass'] = nil;
~funcs['lead'] = nil;
~funcs['leadb'] = nil;
~funcs['hh'] = {PZ_layer(~hh).rhythm(1,[0],[2],[0])};
~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,1,1)};
	(bar*p.beats).wait; //1
~funcs['leadb'] = {PZ_layer(~chords2).rhythm([0,1],[0,1],[0,1],[0,1])};
	(bar*p.beats).wait; //2
~funcs['bass'] = {PZ_layer(~bass).rhythm(1,0,0,0)};
	(bar*p.beats).wait; //3

	// verse 2.2
~funcs['bass'] = {PZ_layer(~bass).rhythm(1,0,0,1)};
	(2*p.beats).wait; //4.1
	Tdef(\hhbreak).play;
	(2*p.beats).wait; //4.3

// chorus 2
~funcs_a['medieval'] = {PZ_layer(~medieval).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['lead'] = {PZ_layer(~chords).rhythm([2],[2],[2],[2])};
~funcs['leadb'] = {PZ_layer(~chords2).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,1,1)};
~funcs['sn'] = {PZ_layer(~sn).rhythm(0,[1],0,[2])};
~funcs['hh'] = {PZ_layer(~hh).rhythm(1,[0],1,[0,2])};
~funcs['bass'] = nil;
	(7*bar*p.beats).wait; //8
	Tdef(\intro).play;
	(bar*p.beats).wait; //to verse

	// verse 3 (outro)
~funcs['sn'] = nil;
~funcs['bass'] = nil;
~funcs['leadb'] = nil;
~funcs['hh'] = nil;
~funcs['bd'] = nil;
(8*bar*p.beats).wait; //
~funcs['lead'] = nil;
~funcs_a['medieval'] = nil;
}).play;
);

Tdef(\intro, {
	(3*p.beats).wait;
	~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,0,[2])};
	~funcs['sn'] = {PZ_layer(~sn).rhythm(0,0, 1,[2])};
	~funcs['leadb'] = nil;
	~funcs['hh'] = nil;
	2.wait;
	Ndef(\vac, {BPF.ar(WhiteNoise.ar(0.5)*LFPulse.kr(t.tempo*4).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4/t.tempo*2.1/4, 1));}).play(6,2);
});

Tdef(\hhbreak, {
	(1*p.beats).wait;
	~funcs['leadb'] = nil;
	~funcs_a['medieval'] = nil;
	~funcs['bd'] = {PZ_layer(~bd).rhythm(0,0,0,[2])};
	~funcs['hh'] = {PZ_layer(~hh).rhythm(0,[0],[2],[0,1])};
		Ndef(\vac, {BPF.ar(WhiteNoise.ar(0.5)*LFPulse.kr(t.tempo*4).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4/t.tempo*2.1/4, 1));}).play(6,2);
/*	Ndef(\vac, {BPF.ar(WhiteNoise.ar(0.5)*LFPulse.kr(t.tempo*4).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4/t.tempo, 1));}).play(6,2);*/
});

Tdef(\structure).stop;
(t.playNextBar{
	~funcs['lead'] = nil;
~funcs['leadb'] = nil;
~funcs['bd'] = nil;
~funcs['sn'] = nil;
~funcs['hh'] = nil;
~funcs['bass'] = nil;
~funcs_a['medieval'] = nil;
});