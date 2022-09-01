// robots!

"say -v nor -r 160 hadde".unixCmd;
"say -v hen -r 60 ".unixCmd;

// speech of scene 8 (page 22)

"say -v hen -r 160 jeg, er, en fjernemaskin".unixCmd;
"say -v hen -r 60 alt!".unixCmd;
"say -v hen -r 60 du, ikke, vil, ha".unixCmd;

Ndef(\robotize, {BPF.ar(SoundIn.ar(0,1), 456, 1)*0.8}).play(2,1);

Tdef(\r, {
	loop{
Ndef(\rvoice, {Saw.ar(LFNoise1.kr(LFNoise0.kr(1).range(4, 8)).range(100, 378.rrand(877))*LFPulse.kr(8).range(LFPulse.kr(4.rrand(2)).range(1/2,3),LFPulse.kr(4.rrand(2)).range(1/2,4)))*0.1*EnvGen.kr(Env.perc(0.1, 0.1))}).play(2,1);
		2.wait;
	}
}).play


"say -v hen -r 60 ja!".unixCmd;

Tdef(\bossa).play;
~bossaamp = 0.2;
Tdef(\bossa_stop).play;


Synth(\sampleNarcode, [\buf, ~buffers['hammer'], \amp, 0.4, \rate, 1, \pos, 0.1.rrand(0.8), \at, 2, \rl, 8, \out, 6]);