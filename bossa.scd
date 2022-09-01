// bossa nova:
(
Tdef(\bossa, {
t.tempo = 130/60;
(
t.playNextBar{
Tdef(\bossab, {
	var rit = Pseq([1.5, 0.5, 1.5, 2, 0.5, 2], inf).asStream;
	loop{
		Ndef(\bassbossa, {~bossaamp* (SinOsc.ar("c1".namecps, mul: 0.2) + LPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.01, 0.01))),1930)) * EnvGen.kr(Env.perc(0.01, 1)) }).play(8,2);
	(rit.next).wait;
	}
}).play;

Tdef(\bossas, {
	inf.do{|i|
		1.wait;
		Ndef(\snarebossa, {~bossaamp*(LPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.01, 0.1))), 467)) * EnvGen.kr(Env.perc(0.01, 0.2)) }).play(60);
	1.5.wait;
					Ndef(\snarebossa, {~bossaamp*(LPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.01, 0.1))), 467)) * EnvGen.kr(Env.perc(0.01, 0.2)) }).play(60);
	1.5.wait;
					Ndef(\snarebossa, {~bossaamp*(LPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.01, 0.1))), 367)) * EnvGen.kr(Env.perc(0.01, 0.2)) }).play(60);
	1.5.wait;
					Ndef(\snarebossa, {~bossaamp*(LPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.01, 0.1))), 567)) * EnvGen.kr(Env.perc(0.01, 0.2)) }).play(60);
	1.5.wait;
					Ndef(\snarebossa, {~bossaamp*(LPF.ar(WhiteNoise.ar(EnvGen.kr(Env.perc(0.01, 0.1))), 567)) * EnvGen.kr(Env.perc(0.01, 0.2)) }).play(60);
	1.wait;
			if (i==0) {
						Ndef(\snareverb, {~bossaamp*In.ar(60)+GVerb.ar(In.ar(60), 30, 0.2, mul:0.3)*1}).play(9,2);
			}
	};
}).play;

Tdef(\bossamelb, {
		var mel = Pseq([Pseq([Pseq(["c4".namecps], 11), Pseq(["e5".namecps, "c4".namecps, "c4".namecps]*1/2, 1)], 1), Pseq([Pseq(["c4".namecps], 11), Pseq(["E4".namecps, "D4".namecps, "c4".namecps]*1, 1)], 1)], inf).asStream;
		var rit = Pseq([Pseq([1/2,1,1/2], 2), Pseq([1/2,1/2], 4)]*4, inf).asStream;
	loop{
			Ndef(\mackmelb, {|amp=2| ~bossaamp*SinOsc.ar([mel.next]*1/8)*0.4*EnvGen.kr(Env.perc(0.01, 5))}).play(11,2);
			(rit.next).wait;
	}
}).play;

Tdef(\bossamel, {
		var mel = Pxrand([Pseq([Pseq(["c4".namecps], 11), Pseq(["B3".namecps, "B3".namecps, "B3".namecps]*1/2, 1)], 1), Pseq([Pseq(["c4".namecps], 11), Pseq(["e4".namecps, "e4".namecps, "e4".namecps]*1, 1)], 1)], inf).asStream;
		var rit = Pseq([Pseq([1,2/3,1/3], 2), Pseq([2/3,1/3], 4)]*1, inf).asStream;
	loop{
			Ndef(\mackmel, {|amp=1| ~bossaamp*SinOsc.ar([mel.next]*[1])*0.03*EnvGen.kr(Env.perc(0.1, 1))}).play(6,2);
			(rit.next).wait;
	}
}).play;

	Tdef(\bossah, {
	var rit = Pseq([2/3, 1/3], inf).asStream;
	loop{
		(rit.next).wait;
		Ndef(\hibossa, {(~bossaamp*HPF.ar(WhiteNoise.ar(0.4), 14867)) * EnvGen.kr(Env.perc(0.01, 0.045)) }).play(10);
	(rit.next).wait;
	}
}).play;
}
);
});

//stop
Tdef(\bossa_stop, {
	t.clear;
	Tdef(\bossa).stop;
Tdef(\bossah).stop;	Tdef(\bossamelb).stop;
	Tdef(\bossamel).stop;
	Tdef(\bossas).stop;Tdef(\bossab).stop;
	Ndef(\snareverb).clear;
});
)

~bossaamp = 0.02;
Tdef(\bossa).play
Tdef(\bossa_stop).play;