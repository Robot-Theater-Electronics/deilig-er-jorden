// pre-load
s.waitForBoot{
(
~path_samples = thisProcess.nowExecutingPath.dirname ++ "/samples/";
~buffers = ();
~buffers['bd'] = Buffer.read(s, ~path_samples ++ "808bd.wav");
~buffers['hh'] = Buffer.read(s, ~path_samples ++ "808hh.wav");
~buffers['sn'] = Buffer.read(s, ~path_samples ++ "808sd.wav");
);
s.sync;
~buffers['vc'] = Buffer.read(s, ~path_samples ++ "vacuum.aiff");
~buffers['hammer'] = Buffer.read(s, ~path_samples ++ "hammer.wav");
~buffers['vertinna'] = Buffer.read(s, ~path_samples ++ "vertinna.wav");

// chord progression:
(
~gm7M = ["g0".namecps, "b1".namecps, "d1".namecps];
~gm9M = ["g0".namecps, "b1".namecps, "d1".namecps, "a1".namecps];
~cm7 = ["c0".namecps, "b1".namecps, "eb1".namecps];
~gM7M = ["g0".namecps, "B1".namecps, "d1".namecps];
~gM9M = ["g0".namecps, "B1".namecps, "d1".namecps, "a1".namecps];
~cM7 = ["c0".namecps, "B1".namecps, "e1".namecps];
~cM = ["c0".namecps, "g1".namecps, "e1".namecps];
~fM = ["f1".namecps, "a1".namecps, "c2".namecps];
~em = ["e1".namecps, "g1".namecps, "B1".namecps];
~eb = ["eb1".namecps, "g1".namecps, "b1".namecps];
~dm = ["d1".namecps, "f1".namecps, "a1".namecps];
~dM7 = ["d1".namecps, "f#1".namecps, "a1".namecps];
~d7 = ["d1".namecps, "f#1".namecps, "a1".namecps, "c2".namecps];
~am7 = ["c1".namecps, "g1".namecps, "a1".namecps]; ~eb7 = ["c#1".namecps, "g1".namecps, "eb2".namecps];
~c_dM7 = ["c1".namecps, "f#1".namecps, "d2".namecps]; ~ab7 = ["c1".namecps, "g1".namecps, "ab2".namecps];
~d_dM7 = ["d0".namecps, "f#2".namecps, "d2".namecps];
~b_gm7 = ["b0".namecps, "g2".namecps, "d1".namecps];
~a_dM7 = ["a0".namecps, "f#1".namecps, "d1".namecps];
~a7 = ["a0".namecps, "c1".namecps, "e1".namecps, "g1".namecps];
~g_g = ["g0".namecps, "g1".namecps, "g1".namecps];

~g5 = ["g0".namecps, "g1".namecps, "d0".namecps];
~f5 = ["f0".namecps, "f1".namecps, "c0".namecps];
~a5 = ["a0".namecps, "a1".namecps, "e0".namecps];
~c5 = ["c0".namecps, "c1".namecps, "g0".namecps];
~d5 = ["d0".namecps, "d1".namecps, "a0".namecps];
~b5 = ["B0".namecps, "B1".namecps, "f#0".namecps];
~fs5 = ["f#0".namecps, "f#1".namecps, "c#0".namecps];
~a5 = ["a0".namecps, "a1".namecps, "e0".namecps];
~e5 = ["e0".namecps, "e1".namecps, "B0".namecps];
~cs5 = ["c#0".namecps, "c#1".namecps, "g#0".namecps];
);
s.sync;
// beat functions
(
~bd = { Synth(\sampleNarcode, [\buf, ~buffers['bd'], \amp, 1, \out, 8])};
~hh = { Synth(\sampleNarcode, [\buf, ~buffers['hh'], \amp, 1, \out, 10])};
~hh2 = { Synth(\sampleNarcode, [\buf, ~buffers['hh'], \amp, 1, \rate, 0.8, \at, 0.01, \rl, 0.01, \out, 10])};
~sn = { Synth(\sampleNarcode, [\buf, ~buffers['sn'], \amp, 1, \out, 9])};
);
s.sync;
// synths
(
SynthDef(\sampleNarcode, {|out=0, at=0.01, rl=0.1, rate=1, pos=0, amp=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd;
	snd = PlayBuf.ar(1, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*pos)*env;
	Out.ar(out, snd*amp);
}).store;

SynthDef(\surroundNarcode, {|out=0, at=0.01, rl=0.1, rate=1, panpos=0, amp=1, pos=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd, pan;
	snd = PlayBuf.ar(1, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*pos)*env;
	pan = PanAz.ar(4, snd, panpos);
	Out.ar(out, snd*amp);
}).store;

SynthDef(\surroundNarcode, {|out=0, at=0.01, rl=0.1, rate=1, panstart=0, panend=1, amp=1, pos=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd, pan;
	snd = PlayBuf.ar(1, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*pos)*env;
	pan = PanAz.ar(4, snd, LFTri.kr(1).range(panstart, panend));
	Out.ar(out, pan*amp);
}).store;

SynthDef(\surroundNarcode, {|out=0, at=0.01, rl=0.1, rate=1, panpos=0, amp=1, pos=1, buf|
	var env = EnvGen.kr(Env.perc(at, rl), doneAction:2);
	var snd, pan;
	snd = PlayBuf.ar(1, buf, BufRateScale.kr(buf)*rate, 1, BufFrames.kr(buf)*pos)*env;
	pan = PanAz.ar(4, snd, panpos);
	Out.ar(out, pan*amp);
}).store;

s.sync;
~medieval_chord ={arg note, at=4, celloat=1;
~keizer_medieval.(note, 1, 1, at, 60);
~keizer_medieval_dist.(note*4, 0.8, celloat, 0.1, 60);
~keizer_medieval.(note, 1, 1, at, 16);
~keizer_medieval_dist.(note*4, 1, 0.1, 0.1, 16);
};
);
s.sync;
// dics
~revs = ();
~fxs = ();
~funcs = ();
~funcs_a = ();
s.sync;
// globals
~bossaamp = 1;
s.sync;
p = PZ_machine(s);
a = PZ_machine(s);
s.sync;
"Preload complete".postln;
}