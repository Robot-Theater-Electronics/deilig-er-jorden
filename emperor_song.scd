// Emperor song
t = TempoClock.default;
~funcs = ();

(
r = Routine{
	inf.do{
		s.bind{
			// audio
			~funcs.do{|f| f.(); };
		};
		4.wait; // must be dynamic
	}
}.play;
);

Jeg liker nye klær, nye nye klær, jeg liker nye klær, jeg liker nye klær
Jeg liker liker liker liker liker nye klær

/// v1 (raeggeton)
t.tempo_(74/60);

c = {Synth(\sampleNarcode, [\buf, ~buffers['bd'], \amp, 1, \out, 6])};

p = PZ_machine(s);
a = PZ_machine(s);
p.beats;
p.loop;
p.routine;
p.routine.play;
p.routine.stop;

n = PZ_layer(c, nil);
n.item = c;
~funcs['a'] = { n.rhythm(1,4,0,1); };


// keizer sound
~keizer = {arg chord, amp=0.05, rel=0.1, dec=99; Ndef(\h, {[GVerb.ar(Saw.ar(chord*4)*EnvGen.kr(Env.perc(0.1, rel)), 78, dec)].sum.sum*amp}).play(6,2);} //99

// v2 club
~keizer = {arg chord, amp=0.05; Ndef(\h, {[CombN.ar(SinGrain.ar(Impulse.kr(t.tempo*8), 0.1, chord*[2,4], mul:2) ring2: PinkNoise.ar(0.8)*EnvGen.kr(Env.perc(0.1, 0.1)), t.tempo/4, t.tempo/16, 4)].sum.sum*amp}).play(6,2);} //99

// keizer bass v2
~keizerb = {arg note, start=(21/12), dec=0.2, amp=0.01; {SinOsc.ar(note*Line.kr(start, 1, dec)).distort*EnvGen.kr(Env.perc(0.01, 1), doneAction:2)*amp}.play(s, 11);};

// v3 party
~keizerb = {arg note, start=(21/12), dec=0.2, amp=0.01, end=1, rel=4; {LPF.ar(Saw.ar(note*Line.kr(start, end, dec))+SinOsc.ar(note*Line.kr(start, end, dec)).distort, 180)*EnvGen.kr(Env.perc(0.01, rel), doneAction:2)*amp}.play(s, 11);};

// keizer reaggeton
~keizerr = {arg chord, amp=0.05, rel=1; {GVerb.ar(Saw.ar([chord.next, chord.next*LFSaw.kr(t.tempo/8).range(1,4)])*EnvGen.kr(Env.perc(0.1, 0.1)), 87, 1).sum.sum*amp*EnvGen.kr(Env.perc(0.01, rel), doneAction:2)}.play(s,60,2);}

/// v1 (club techno)
t.tempo_(130/60);

p = PZ_machine(s);
a = PZ_machine(s);
p.beats=4; // cool for silences
a.beats=8; /// beach pop
p.loop;
p.routine;
a.loop;
p.routine.play.quant_(4);
a.routine.play.quant_(4);
p.routine.source = {	inf.do{
		s.bind{
			// audio
			~funcs.do{|f| f.(); };
		};
		(p.beats).wait; // must be dynamic
	} };

a.routine.source = {	inf.do{
		s.bind{
			// audio
			~funcs_a.do{|f| f.(); };
		};
		(a.beats).wait; // must be dynamic
	} };

a.routine.stop;

n = PZ_layer(c, nil);
n.item = c;

// v1 (130bpm)
~bass = { ~keizerb.(~notes.next;, 12/12, t.tempo/4, 1); };
~notes = Pseq([["g1".namecps, "g1".namecps(15)], ["b1".namecps, "b1".namecps(15)]].stutter(16), inf).asStream;

~chords = {~keizer.(~prog.next); };
~funcs['bd'] = { PZ_layer(~bd).rhythm([1],1,1,[0,1]);};
~funcs['hh'] = {PZ_layer(~hh).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['sn'] = {PZ_layer(~sn).rhythm(0,[0],0,[1])};
~funcs_a['harmony'] = {PZ_layer(~chords).rhythm(1,0,0,0)};
Ndef(\vac, {0.2*BPF.ar(WhiteNoise.ar(1)*LFPulse.kr(t.tempo*4).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4, 3));}).play(6,2);

(
~funcs['sn'] = nil;
~funcs['hh'] = nil;
~funcs['bd'] = nil;
~funcs_a['harmony'] = nil;
);

~funcs_a['harmony'] = {PZ_layer(~chords).rhythm(1,0,0,0)};

~chords = {~keizer.(~prog.next); };
~prog = Pseq([Pfuncn({~gM7M},1), Pfuncn({~gM9M},1), Pfuncn({~cM7},1), Pfuncn({~dM7},1)], inf).asStream;
~progb = Pseq([Pfuncn({~fM},1), Pfuncn({~em},1), Pfuncn({~eb},1), Pfuncn({~dM7},1)], inf).asStream;

Ndef(\vac, {BPF.ar(WhiteNoise.ar(0.1)*LFPulse.kr(t.tempo*2).range(0,1), Line.kr(100,5666, 10), Line.kr(1, 0.1, 10))*EnvGen.kr(Env.perc(4, 3));}).play(6,2);

~prog = Pseq([Pfuncn({~gm7M},1), Pfuncn({~gm9M},1), Pfuncn({~cm7},1), Pfuncn({~dm7},1)], inf).asStream;


Tdef(\k1, {
	loop{
		~keizer.(~gm7M);
		4.wait;
		~keizer.(~gm9M);
		4.wait;
		~keizer.(~cm7);

	}
}).stop;


Tdef(\k1, {
	var wait=4;
	loop{
~keizer.(~fM); wait.wait;
~keizer.(~em);		wait.wait;
~keizer.(~eb);		wait.wait;
~keizer.(~dM7);		wait.wait;
~keizer.(~am7);		wait.wait;
~keizer.(~c_dM7);		wait.wait;
~keizer.(~d_dM7);		wait.wait;
~keizer.(~d_dM7);		wait.wait;
		// ~keizer.(~g_g);		wait.wait;
	}
}).play.quant_(4);

Tdef(\k1).stop;
// v2 reaggeton
~funcs=();~funcs_a=();

~reag = { ~keizerr.(~r_notes.next, 1, 1); };
~r_notes = Pseq(~gm7M*2, inf).asStream;

~bass = { ~keizerb.(~notes.next;, 14/12, t.tempo/4, 1); };
~notes = Pseq([["c1".namecps, "c0".namecps(15)], ["g0".namecps, "g0".namecps(15)]], inf).asStream;
t.tempo_(90/60);
~funcs['bd'] = { n.rhythm(1,1,1,1);};
~funcs['hh'] = {PZ_layer(~hh).rhythm([0,0,1,0], [0,0,1,0], [0], [0,0,1,0]);};
~funcs['sn'] = {PZ_layer(~sn).rhythm([0,0,0,1], [0,0,1,0], [0,0,0,1], [0,0,1,1])};
~funcs['bass'] = { PZ_layer(~bass).rhythm([1],0,0,1) };
~funcs['reag'] = { PZ_layer(~reag).rhythm(1,0,0,0) };
~funcs['bass'] = nil;
~funcs['reag'] = nil;

/// v3 party club techno
/// v3 soul sexy
t.tempo_(67/60);
p.routine.play;
a.routine.play;
a.beats=8;
a.routine.play;
~funcs['bd'] = { n.rhythm(1,1,1,1);};
~funcs['hh'] = {PZ_layer(~hh).rhythm(0, 1, [0,0,0,1], 0);};
~funcs['sn'] = {PZ_layer(~sn).rhythm(0,1,0,1)};
~funcs['lead'] = { PZ_layer(~lead).rhythm([1],[1],[1],[0, 1]) };
~funcs_a['lead2'] = { PZ_layer(~lead2).rhythm([0,1],[0,1],[0,1],[0, 1]) };
~funcs_a['bass'] = { PZ_layer(~bass).rhythm([1],0,0,1) };
~funcs['bass2'] = { PZ_layer(~bass2).rhythm([1],0,1,0) };
~funcs_a['bass'] = nil;
~funcs_a['lead2'] = nil;
~bass = { ~keizerb.(~notes.next, 21/12, t.tempo/2, 1, 1/2, 4); }; // soul* | club /
~bass2 = { ~keizerb.(["d-1".namecps, "d-1".namecps(15)], 21/12, t.tempo/2, 1, 1/2, 0.3); };
~notes = Pseq([["g0".namecps, "g0".namecps(15)], ["f0".namecps, "f0".namecps(15)]].stutter(2), inf).asStream;
~funcs_a['harmony'] = {PZ_layer(~chords).rhythm([0,1],[1,1],0,0)};
~chords = {~keizer.(~progc.next); };
~progc = Pseq([Pfuncn({~fM},1), Pfuncn({~gM9M},1)], inf).asStream;
~funcs_a['harmony'] = nil;
~funcs_a['lead2'] = nil;
~funcs_a['bass2'] = nil;
~keizer_lead = {arg note, start=(21/12), end=1, rate=1, amp=0.1, filter_rate=(1/4), out=6; {BPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.1, 0.01)))+Saw.ar(note*LFSaw.kr(rate).range(start, end))+Saw.ar(note*LFSaw.kr(rate).range(start, end)).distort, LFSaw.kr(t.tempo*filter_rate).range(230, 2334), LFSaw.kr(t.tempo*filter_rate).range(1, 0.001))*EnvGen.kr(Env.perc(0.1, 1), doneAction:2)*amp}.play(s, out);};
~lead = {~keizer_lead.(~leadnotes.next*2, 1/4, 2, t.tempo*1, 0.2, 1/4, ~leadout.next)};
~lead2 = {~keizer_lead.(~leadnotes.next*4, 1, 2, t.tempo*1/2, 0.1, 4, 7)};
~leadnotes = Pseq(["d3".namecps, "c1".namecps, "b3".namecps, "a1".namecps], inf).asStream;
~leadnotes2 = Pseq(["g2".namecps, "eb2".namecps, "d2".namecps, "c2".namecps], inf).asStream;
~leadout=Pseq([60,0,0,0,0,0,0,6], inf).asStream;
Ndef(\del, {CombN.ar(In.ar(60), t.tempo, t.tempo/8, t.tempo*2)*1}).play(6,2);

Tdef(\k1, {
	loop{
		4.do{
		~keizer.(~gm7M);
			(4).wait;
		};
	}
}).play.quant_(4);

Tdef(\k1, {
	var wait=(4);
	loop{
~keizer.(~fM); wait.wait;
~keizer.(~em);		wait.wait;
~keizer.(~eb);		wait.wait;
~keizer.(~dM7);		wait.wait;
/*~keizer.(~am7);		wait.wait;
~keizer.(~c_dM7);		wait.wait;
~keizer.(~d_dM7);		wait.wait;
~keizer.(~d_dM7);		wait.wait;
		// ~keizer.(~g_g);		wait.wait;*/
	}
}).play.quant_(4);

Tdef(\k1).stop;

~funcs['bd'] = { PZ_layer(~bd).rhythm([0],[0],[0],[0,0]);};
~funcs['hh'] = {PZ_layer(~hh).rhythm([0,0,0],[0,0],[0,0,0],[0,0])};
~funcs['sn'] = {PZ_layer(~sn).rhythm(0,[0],0,[0])};
~funcs_a['harmony'] = {PZ_layer(~chords).rhythm(0,0,0,0)};