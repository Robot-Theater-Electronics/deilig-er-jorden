/// Deilig er Jorden

// pulse
t.tempo_(10/60);
Ndef(\p, {BPF.ar(WhiteNoise.ar(1), 456)*0.1*LFPulse.kr(t.tempo, width: 0.1)}).play(6,2);

Ndef(\p).quant_(1);
Ndef(\p1).quant_(1);
Ndef(\p2).quant_(2);

Ndef(\p1, {BPF.ar(WhiteNoise.ar(1), LFSaw.kr(1).range(100, 899))*0.1*LFPulse.kr(t.tempo/2, width: 0.3)}).play(6,2);

Tdef(\p2, {
	loop{
Ndef(\p2, {BPF.ar(WhiteNoise.ar(1), LFSaw.kr(2).range(300, 899), 0.1)*0.2*LFPulse.kr(t.tempo*2, width: 0.3)}).play(6,2);
		(2.rrand(4)).wait;
	}
}).stop;

Ndef(\p3, {BPF.ar(BrownNoise.ar(1), LFSaw.kr(2).range(300, 2899))*0.1*LFNoise1.kr(t.tempo/19, width: 1)}).play(6,2);
Ndef(\p1).stop(5);


/// suking spound
~stger = {arg dur=(1/2), dec=0.01, amp=2; {amp*Pan2.ar(Resonz.ar(WhiteNoise.ar(Line.kr(0,0.7,dur)), Line.kr(1).range(8789, 667, dur), 0.1), Line.kr(1,-1,dur))*EnvGen.kr(Env.perc(dur, dec), doneAction:2)} };
~stgerpop = {arg dur=(1/2),dec=0.01,amp=2; {amp*Resonz.ar(WhiteNoise.ar(0.2), 6782, 0.1)*EnvGen.kr(Env.perc(dur, dec), doneAction:2)} };

~wereld = ();
~wereld['sf1'] = ~stger.(80, 8, 3).play(s, 6);
~wereld['sf2'] = ~stgerpop.(12,148,0.7).play(s, 6);

~stgerpop.(1,0.01, 2).play(s, 7);

~wereld['sf1'].set(\amp,0.1);

~wereld['sf2'].free;

Ndef(\vc1, {HPF.ar(BrownNoise.ar(0.5), 234)*0.03*LFNoise1.kr(1/4).range(0.2,1)}).play(6,2);
Ndef(\vc1).stop(2);

// suck BR
Synth(\sampleNarcode, [\buf, ~buffers['vc'], \amp, 0.07, \rate, 0.6, \pos, 0.1.rrand(0.8), \at, 2, \rl, 8, \out, 4]);

// random surround
Synth(\sampleNarcode, [\buf, ~buffers['vc'], \amp, 0.02, \rate, 0.6, \pos, 0.1.rrand(0.8), \at, 2, \rl, 8, \out, 4.rrand(7)]);

~vc = {arg amp=0.04, pan=1, pos=0.1, out=4;Synth(\surroundNarcode, [\buf, ~buffers['vc'], \amp, 0.1, \out, 4, \at, 2, \rl, 6]) };

	~vc.();

Synth(\surroundNarcode, [\buf, ~buffers['vc'], \amp, 0.1, \out, 4, \at, 2, \rl, 6, \panpos, 2]);

Ndef(\srnd, {
var snd=0.1*PlayBuf.ar(1, ~buffers['vc'], BufRateScale.kr(~buffers['vc'])*1,1, BufFrames.kr(~buffers['vc'])*0.2);
PanAz.ar(4, snd, LFTri.kr(1/4).range(-1, 1));
	}).play(4);

Ndef(\srnd).stop(5);

~vc.();
// back L -> 3
// back R -> 4

Tdef(\vc, {
	loop{
		Ndef(\vc2, {WhiteNoise.ar(0.4)*0.2*Line.kr(0, 1, doneAction:2)}).play(6,2);
		1.wait;
	}
}).play;

Tdef(\vc).stop(2);

Ndef(\vc1).fadeTime_(2);

Tdef(\p, {
	var note = Pseq([Pseq(["g6"], 2), "f#5", "g6", Pseq(["b5"], 4)], inf).asStream;
	inf.do{
		Ndef(\sign, {GVerb.ar(SinOsc.ar(note.next.namecps*LFTri.kr(4).range(1/2, 0.2))*EnvGen.kr(Env.perc(0.01,1))*1, 67, 3)}).play(6,1);
				Ndef(\sign2, {GVerb.ar(SinOsc.ar(note.next.namecps*1/5)*EnvGen.kr(Env.perc(0.01,0.1))*0.2, 67, 3)}).play(6,1);
		(8).wait;
	};
}).play;

Tdef(\p).stop(1);

Tdef(\bossa_stop).play;

"say -v nora -r 189 [[freq 545]] ja!".unixCmd;

~text_begin = "Nye klær. Bli inspirert. Genser med delikat mønster og fine detaljer. Den er for deg som synes verden ser bedre ut gjennom et smilehull. Vennlighet er gratis – strø det om deg hvor enn du går. Dette er genseren for deg som vil at de rundt deg skal ha det bra, en genser som vet å ta vare på dem – og deg. Det varme, deilige materialet gjør denne til et plagg du fort blir komfortabel i, bokstavelig talt. Med glidelås er den også lett å smette av og på. La det duse hjertemønsteret minne deg på å alltid lytte til hjertet. Det vet nemlig veien.";

("say -v nora " ++ ~text_begin).unixCmd;

~stem = {arg amp=1; {CombN.ar(SoundIn.ar(0,2)*amp, 1, 0.1, 19)} };
~stemmen = ();
~stemmen[0] = ~stem.(0.1).play(s, 6);
~stemmen[0].free;


// TODO:

// sucking sounds:


// pop & rumble:
~popf = [456,458,450];
~popa = [1,1,1];
~popr = [10,1,1];
~revs[60].set(\dec, 8);~fxs[60].set(\dec, 160);
(Tdef(\pop, {
{HPF.ar(BrownNoise.ar(Line.kr(0,0.6,1/2)), Line.kr(120, 378,0.7, doneAction:2))}.play(s,6,1);
	(1/2).wait;
{Klank.ar(`[~popf-100, ~popa*3, ~popr*0.1], Impulse.ar(EnvGen.kr(Env.perc, doneAction:2)),1,Line.kr(10, 1000, 0.4))}.play(s,60,1);
	{Impulse.ar(Line.kr(100,10,1))*1*EnvGen.kr(Env.perc, doneAction:2)}.play(s,6,1);
		{Impulse.ar(Line.kr(100,10,1))*1*EnvGen.kr(Env.perc, doneAction:2)}.play(s,60,1);
}).play;
);

~rumble = {};

Ndef(\rumble, {LPF.ar(BrownNoise.ar(0.07*LFNoise1.kr(1/8).range(0.2,1)), 80)*1}).play(8,1);
Ndef(\rumble).stop(6);

Ndef(\sweep, {LPF.ar(Saw.ar(Line.kr(100, 1234, 0.1)), 80)*1}).play(8,1);

// page 34 ... deconstruct bossanova
// alarm in robot (chan 2)

Ndef(\vert, {PlayBuf.ar(2, ~buffers['vertinna'], LFNoise0.kr(1/8).range(0.5, 3), 1)}).play(4);
Ndef(\vert).stop(6);

Ndef(\vertsurround, {
	var snd = PlayBuf.ar(2, ~buffers['vertinna'], LFNoise0.kr(1/3).range(1, 1), Impulse.kr(2), BufFrames.kr(~buffers['vertinna'])*0);
PanAz.ar(4, snd, LFTri.kr(1/8).range(-1, 1));
}).play(4);

Ndef(\vert).stop;
Ndef(\vertsurround).stop;

Ndef(\srnd, {
var snd=0.1*PlayBuf.ar(1, ~buffers['vc'], BufRateScale.kr(~buffers['vc'])*1,1, BufFrames.kr(~buffers['vc'])*0.2);
PanAz.ar(4, snd, LFTri.kr(1/4).range(-1, 1));
	}).play(4);
Ndef(\srnd1, {
var snd=0.1*PlayBuf.ar(1, ~buffers['vc'], BufRateScale.kr(~buffers['vc'])*1,1, BufFrames.kr(~buffers['vc'])*0.2);
PanAz.ar(4, snd, LFTri.kr(1/4).range(-1, 1));
	}).play(4);

Ndef(\srndmono).stop(1);

Ndef(\srndmono, { //1chan
var snd=0.2*PlayBuf.ar(1, ~buffers['vc'], BufRateScale.kr(~buffers['vc'])*1,1, BufFrames.kr(~buffers['vc'])*0.2);
PanAz.ar(4, snd, 2/4);
	}).play(5);


(Tdef(\pop, {
{HPF.ar(BrownNoise.ar(Line.kr(0,0.1,1/2)), Line.kr(120, 378,1, doneAction:2))}.play(s,6,1);
	(2).wait;
{Klank.ar(`[~popf-100, ~popa*3, ~popr*0.1], Impulse.ar(EnvGen.kr(Env.perc, doneAction:2)),1,Line.kr(10, 1000, 0.4))}.play(s,60,1);
	{Impulse.ar(Line.kr(100,10,1))*4*EnvGen.kr(Env.perc, doneAction:2)}.play(s,7,1);
	{Impulse.ar(Line.kr(100,10,1))*1*EnvGen.kr(Env.perc, doneAction:2)}.play(s,7,1);
}).play;
);


// press conf
~revs[60] = ~revkeizer.play(s,6,2);
~revs[60].set(\dec, 30); //amp
~revs[60].free;
~konf = {|amp=1| amp * BPF.ar(PitchShift.ar(SoundIn.ar(0,1), 0.2, [1, 0.6, 1/2]), [2856, 345], 0.1)*0.7};

~konfclean = {|amp=1| amp * BPF.ar(SoundIn.ar(0,1), [2856, 345], 0.1)*0.7};

~fxs['konf'] = ~konfclean.play(s, 4,5);
~fxs['konf'].set(\amp, 3);
~fxs['konf'].free

~fxs['konfr'] = ~konf.play(s, 60,2);
~fxs['konfr'].set(\amp, 1);


~alarmkonf = {|amp=1| LPF.ar(HPF.ar(PlayBuf.ar(2, ~buffers['vertinna'], LFSaw.kr(1).range(1, 1.5), Impulse.kr(1)), 578), 800)*amp};
~fxs['konfa'] = ~alarmkonf.play(s, 60,2);
~fxs['konfa'].set(\amp, 1);
~fxs['konfa'].free
