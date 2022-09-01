/// keizer reggae
t.tempo_(65/60);
p.routine.play; // TODO: no need to ref routine.
a.routine.play;
a.beats=8;

~funcs = ();
~funcs_a = ();
~funcs['hh'] = { PZ_layer(~hh).rhythm([1,0,1],[1,0,1],[1,0,1],[1,0,1]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(0,0,1,0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,0,1,0) };
~funcs['chords'] = { PZ_layer(~chords).rhythm([0,2],[0,1],[0,2],[0,1]) };
~funcs['bass'] = {PZ_layer(~bass).rhythm(1,0,1,0)};
// ~funcs['bass'] = { PZ_layer(~bass).rhythm(1,0,1,0) };


~chords = {~keizer.(~progkr.next, 0.1, 0.04, 0.01); };
~chordsintro = {~keizer.(~progintro.next, ~ampcrec.next, 0.04, 1); };
~progkr = Pseq([~gm7M, ~am7, ~eb, ~cm7].stutter(6), inf).asStream; // 10 is cool
~progintro = Pseq([~dM7], inf).asStream; // 10 is cool
~ampcrec = Pseq(Array.series(4, 0.0, 0.01), inf).asStream;

~bass = { ~keizerb.(~notes.next*1, 12/12, t.tempo/8, 0.5, 1/2, 8); }; // soul* | club /
~notes = Pseq([["g0".namecps, "g0".namecps(15)], ["g0".namecps, "g0".namecps(15)], ["g0".namecps, "a0".namecps(15)], ["c0".namecps, "c0".namecps(15)]].stutter(4), inf).asStream;

// synth
~keizer = {arg chord, amp=0.05, rel=0.1, dec=99; Ndef(\h, {[GVerb.ar(Saw.ar(chord*4)*EnvGen.kr(Env.perc(0.1, rel)), 78, dec)].sum.sum*amp}).play(6,2);}

// Chorus
~progkr = Pseq([~dM7, ~gM7M, ~gM7M, ~em, ~a7, ~a7], inf).asStream; // v1

// bridge
~progkr = Pseq([~em, ~dM7].stutter(3), inf).asStream; // v2


// medieval intro
a.beats = 8;
~revs[60].set(\dec, 88);~fxs[60].set(\dec, 160);
~prog_m = Pseq([~g5, ~a5, ~g5, ~e5, ~c5, ~fs5, ~a5, ~b5], inf).asStream;
~medieval = {~medieval_chord.(~prog_m.next)};
~funcs_a['medieval'] = {PZ_layer(~medieval).rhythm(1,0,0,0)};

~funcs_a['medieval'] = nil;
(
Tdef(\structure, {
	var bar=4;
	~progkr = Pseq([~gm7M, ~am7, ~eb, ~cm7].stutter(12), inf).asStream; // 10 is cool
	// intro x4
~funcs['hh'] = { PZ_layer(~hh).rhythm([1,0,1],[1,0,1],[1,0,1],[1,0,1]) };
~funcs['bd'] = { PZ_layer(~bd).rhythm(0,0,1,0) };
~funcs['sn'] = { PZ_layer(~sn).rhythm(0,0,1,0) };
~funcs['bass'] = {PZ_layer(~bass).rhythm(1,0,1,0)};
	(3*p.beats).wait;
	~funcs['chordsintro'] = { PZ_layer(~chordsintro).rhythm([0,1],[0,1],[0,1],[0,1]) };
	(1*p.beats).wait;
	// verse1 x8
	~funcs['chordsintro'] = nil;
	~funcs['chords'] = { PZ_layer(~chords).rhythm([0,1],[0,2],[0,1],[0,2]) };
	(2*bar*p.beats).wait;
	// chorus1 x4
	~progkr = Pseq([~am7, ~dM7, ~gM7M, ~gM7M, ~dM7, ~em], inf).asStream; // v2
	(3*bar*p.beats).wait;
	~progkr = Pseq([~em, ~dM7].stutter(3), inf).asStream; // v2
	(1*p.beats).wait;
	// verse2 x8
		~progkr = Pseq([~gm7M, ~am7, ~eb, ~cm7].stutter(12), inf).asStream;
	(2*bar*p.beats).wait;
	// chorus1 x4
	~progkr = Pseq([~am7, ~dM7, ~gM7M, ~gM7M, ~em, ~a7], inf).asStream; // v1
	(3*p.beats).wait;
	~progkr = Pseq([~em, ~dM7].stutter(3), inf).asStream; // v2
	(1*p.beats).wait;
		// verse2 x8
	~progkr = Pseq([~gm7M, ~am7, ~eb, ~cm7].stutter(12), inf).asStream;
	(2*bar*p.beats).wait;
}).play;
);

Tdef(\structure).stop;


	~progkr = Pseq([~em, ~dM7].stutter(3), inf).asStream; // v2