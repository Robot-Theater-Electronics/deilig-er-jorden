// girl song

~keizer_girl = {arg chord, name='h2', amp=0.01, at=5, rel=0.1, dec=99, ratio=2, out=6;
	Ndef(name, {[GVerb.ar(Saw.ar(chord*ratio)*EnvGen.kr(Env.perc(at, rel)), 78, dec)].sum.sum*amp}).play(out,1);} //99

// A
~keizer_girl.(~dM7, name:'h2', at:5, amp:0.004, ratio:2); // page 39
~keizer_girl.(~gm9M, at:5, amp:0.01);
~keizer_girl.(~cm7, at:5, amp:0.01);

// complete
t.tempo_(35/60);

(Tdef(\struct, {
	{
		2.do{
~keizer_girl.(~gm7M, at:0.1);
			(1/2).wait;
		};
		1.do{
~keizer_girl.(~gm7M,at:0.1);
			(1/2).wait;
		};
1.do{
~keizer_girl.(~cm7,at:0.1);
	 (1/2).wait;
		};
~keizer_girl.(~gm7M);
		4.wait;
~keizer_girl.(~gm9M);
		4.wait;

~keizer_girl.(~fM);
	 1.wait;
~keizer_girl.(~em);
		1.wait;
~keizer_girl.(~eb);
		1.wait;
~keizer_girl.(~dM7);
		1.wait;
~keizer_girl.(~a7);
		1.wait;
~keizer_girl.(~eb7);
		1.wait;
~keizer_girl.(~ab7);
		1.wait;
~keizer_girl.(~b_gm7);
		1.wait;
~keizer_girl.(~a_dM7);
		1.wait;
~keizer_girl.(~g_g, ratio:2, amp:0.003);
	}.fork;
}).play);

// manual
~keizer_girl.(~gm7M);
~keizer_girl.(~gm9M);
~keizer_girl.(~cm7);

~keizer_girl.(~fM);
~keizer_girl.(~em);
~keizer_girl.(~eb);
~keizer_girl.(~dM7);
~keizer_girl.(~a7);
~keizer_girl.(~eb7);
~keizer_girl.(~ab7);
~keizer_girl.(~b_gm7);
~keizer_girl.(~a_dM7);
~keizer_girl.(~g_g);


/// girl coming in:
~arp=Pseq(~gm9M++(~gm9M*2++(~a_dM7/1)), inf).asStream;
~arp=Pseq(~gm9M, inf).asStream;
// chords
~keizer_girl.(~gm9M, 'h2', 0.1, 0.1, 0.1);

Tdef(\arp, {
	var out = Pseq([4,5,6,7], inf).asStream;
	loop{
		~keizer_girl.(~arp.next, 'arp', 0.01, 0.1, 0.1, out: out);
		(2).wait;
	}
}).play;

Tdef(\arp1, {
	var out = Pseq([4,5,6,7].scramble, inf).asStream;
	loop{
		~keizer_girl.(~arp.next, 'arp2', 0.01, 0.1, 0.1, ratio:1, out:out);
		(4).wait;
	}
}).play;

Tdef(\arp2, {
	var out = Pseq([4,5,6,7].scramble, inf).asStream;
	loop{
		~keizer_girl.(~arp.next, 'arp', 0.01, 0.1, 0.1, out: out, ratio:3);
		(1).wait;
	}
}).play;

Tdef(\arp2).stop;

Tdef(\vc, {
	loop{
		Ndef(\vc2, {LPF.ar(WhiteNoise.ar(0.4), 2234.rrand(7889))*0.1*Line.kr(0, 1, doneAction:2)}).play(6,2);
		4.wait;
	}
}).play;

Tdef(\vc2, {
	loop{
		Ndef(\vc3, {LPF.ar(WhiteNoise.ar(0.4), 2234.rrand(7889))*0.3*LFPulse.kr(3)*Line.kr(0, 1, doneAction:3)}).play(6,2);
		4.wait;
	}
}).play;

~wereld['sf1'] = ~stger.(80, 8, 3).play(s, 6); // TODO: add frequencies
~wereld['sf2'] = ~stgerpop.(12,148,0.7).play(s, 6);

// girl comes in


(
Tdef.all.do{|t| t.stop;};
Synth(\sampleNarcode, [\buf, ~buffers['vc'], \amp, 6, \rate, 0.6, \pos, 0.1.rrand(0.8), \at, 2, \rl, 6, \out, 6]);
);