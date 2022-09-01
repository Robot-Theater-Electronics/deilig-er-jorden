/// keizer rap/hip-hop
t.tempo_(95/60);
p.routine.play; // no need to ref routine.
a.routine.play;

a.beats=8; // 16 also cool

~funcs = ();
~funcs_a = ();
~funcs['hh'] = { PZ_layer(~hh).rhythm(1,[2],1,[0,1,0,1]) };
~funcs_a['hh2'] = { PZ_layer(~hh2).rhythm(0,[0,4],0,[0,1,0,4]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,[2],0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,1,0,[1]) };
~funcs_a['bass'] = { PZ_layer(~bass).rhythm(1,0,1,0) };


~chords = {~keizer.(~progkr.next*1/8, 0.1, 0.01, 0.01); };
~progkr = Pseq([~c7M, ~em, ~gM7M].stutter(1), inf).asStream;
// ~funcs['bass'] = {PZ_layer(~bass).rhythm(1,0,1,0)};

~keizerb = {arg note, start=(21/12), dec=0.2, amp=0.01, rel=1; {SinOsc.ar(note*Line.kr(start, 1, dec)).distort*EnvGen.kr(Env.perc(0.01, rel), doneAction:2)*amp}.play(s, 11);};

~bass = { ~keizerb.(~notes.next*1, 1, 2, 0.8, 6); }; //4
~notes = Pseq([["f0".namecps, "f0".namecps(15)], ["a0".namecps, "a0".namecps(15)]].stutter(2), inf).asStream;


~keizer = {arg chord, amp=0.05, rel=0.1, dec=99; Ndef(\h, {[GVerb.ar(Saw.ar(chord*4)*EnvGen.kr(Env.perc(0.1, rel)), 78, dec)].sum.sum*amp}).play(6,2);} //99

~fx = {|in=16, amp=0.1, dec=160, dur=2| CombN.ar(PitchShifter.ar(In.ar(in), 2, dur, 2,1,0.001), 0.1, 2/t.tempo, dec)*amp};
~fxs[60] = ~fx.play(s, 60,2);
~fxs[60].free;
~revs[60] = ~rev.play(s,6,2);

~revs[60].set(\dec, 1, \amp, 0.05); ~fxs[60].set(\dec, 1, \amp, 0.1);
~prog_m = Pseq([~fM, ~gm7M, ~dm, ~fM].stutter(4)*2, inf).asStream;
~medieval = {~medieval_chord.(~prog_m.next, 0.01, 0.1)};
~funcs['medieval'] = {PZ_layer(~medieval).rhythm([4,0],[0],0,[0])};

(
~funcs['bd'] = nil;
~funcs['sn'] = nil;
~funcs['hh'] = nil;
~funcs_a['hh2'] = nil;
// ~funcs['hh'] = { PZ_layer(~hh).rhythm(1,1,1,1) };
// ~funcs['hh'] = nil;
// ~funcs_a['bass'] = nil;
~funcs_a['bass'] = nil;
);

~funcs['medieval'] = nil;

(
~funcs['hh'] = { PZ_layer(~hh).rhythm(1,[2],1,[0,1,0,1]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,[2],0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,1,0,[1]) };
// ~funcs_a['bass'] = { PZ_layer(~bass).rhythm(1,0,1,0) };
);

// struct
~funcs['hh'] = { PZ_layer(~hh).rhythm(1,[2],1,[0,1,0,1]) };
~funcs_a['hh2'] = { PZ_layer(~hh2).rhythm(0,[0,4],0,[0,1,0,4]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,[2],0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,1,0,[1]) };
~funcs_a['bass'] = { PZ_layer(~bass).rhythm(1,0,1,0) };

( // TODO: count
Tdef(\structure, {
	var bar=4; //intro 2 bars
	~funcs['hh'] = { PZ_layer(~hh).rhythm(1,[2],1,[0,1,0,1]) };
	(bar*p.beats).wait; //
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,[2],0) };
/*~medieval = {~medieval_chord.(~prog_m.next, 0.01, 0.2)};*/
		Tdef(\intro).play;
	(bar*p.beats).wait;
	a.beats=4;
// verse 1
~funcs['hh'] = { PZ_layer(~hh).rhythm(1,[2],1,[0,1,0,1]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,[2],0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,1,0,[1]) };
	(bar*p.beats).wait; //1
~funcs_a['bass'] = { PZ_layer(~bass).rhythm(1,0,1,0) };
~funcs_a['hh2'] = { PZ_layer(~hh2).rhythm(0,[0,4],0,[0,1,0,4]) };
	(bar*p.beats).wait; //2
	(bar*p.beats).wait; //3
	(2*p.beats).wait; //4.1
	Tdef(\hhbreak).play;
	(1*p.beats).wait; //4.3
	~funcs['medieval'] = {PZ_layer(~medieval).rhythm([4,0],[0],0,[0])};
	(1*p.beats).wait; //4.3

	// chorus
	(7*bar*p.beats).wait; //8
	Tdef(\intro).play;
	~funcs_a['bass'] = nil;
	(bar*p.beats).wait; //to verse

	// verse 2
~funcs['hh'] = { PZ_layer(~hh).rhythm(1,[2],1,[0,1,0,1]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,[2],0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,1,0,[1]) };
	(bar*p.beats).wait; //1
	(bar*p.beats).wait; //2
~funcs_a['bass'] = { PZ_layer(~bass).rhythm(1,0,1,0) };
~funcs_a['hh2'] = { PZ_layer(~hh2).rhythm(0,[0,4],0,[0,1,0,4]) };
	(bar*p.beats).wait; //3

	// verse 2.2
	(2*p.beats).wait; //4.1
	Tdef(\hhbreak).play;
	(2*p.beats).wait; //4.3

// chorus 2
	~funcs['medieval'] = {PZ_layer(~medieval).rhythm([4,0],[0],0,[0])};
~funcs['lead'] = {PZ_layer(~chords).rhythm([2],[2],[2],[2])};
~funcs['leadb'] = {PZ_layer(~chords2).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['bd'] = {PZ_layer(~bd).rhythm(1,1,1,1)};
~funcs['sn'] = {PZ_layer(~sn).rhythm(0,[1],0,[2])};
~funcs['hh'] = {PZ_layer(~hh).rhythm(1,[0],1,[0,2])};
	(7*bar*p.beats).wait; //8
	Tdef(\intro).play;
	~funcs['bass'] = nil;
	(bar*p.beats).wait; //to verse

	// verse 3 (outro)
~funcs['hh'] = { PZ_layer(~hh).rhythm(1,[2],1,[0,1,0,1]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(1,0,[2],0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,1,0,[1]) };
(2*bar*p.beats).wait; //
	~funcs['medieval'] = {PZ_layer(~medieval).rhythm([4,0],[0],0,[0])};
(6*bar*p.beats).wait; //
~funcs['hh'] = nil;
~funcs['hh2'] = nil;
~funcs['bd'] = nil;
~funcs['sn'] = nil;
~funcs_a['medieval'] = nil;
}).play;
)

Tdef(\intro, {
	(3*p.beats).wait;
	~funcs['bd'] = {PZ_layer(~bd).rhythm(1,0,[2],[0,1])};
	~funcs['sn'] = {PZ_layer(~sn).rhythm(0,0, [0,1],[1])};
	2.wait;
	Ndef(\vac, {BPF.ar(WhiteNoise.ar(0.5)*LFPulse.kr(t.tempo*4).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4/t.tempo*2.1/4, 1));}).play(6,2);
});

Tdef(\hhbreak, {
	(1*p.beats).wait;
	~funcs['leadb'] = nil;
	~funcs['medieval'] = nil;
	~funcs['bd'] = {PZ_layer(~bd).rhythm(0,0,0,[2])};
	~funcs['hh'] = {PZ_layer(~hh).rhythm(0,[0],[2],[0,1])};
		Ndef(\vac, {BPF.ar(WhiteNoise.ar(0.5)*LFPulse.kr(t.tempo*4).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4/t.tempo*2.1/4, 1));}).play(6,2);
});