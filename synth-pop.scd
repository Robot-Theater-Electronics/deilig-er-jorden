//// synth-pop

t.tempo_(110/60);
p.beats=4;
a.beats=16;
p.routine.play;
a.routine.play;
// sounds
(
~sn80 = {Synth(\sampleNarcode, [\buf, ~buffers['sn'], \out, ~snareout.next, \rl, 1])};
~snareout = Pseq([9, 90], inf).asStream;
// bass
~keizer80b = {arg note, amp=0.01, rel=0.2; {LPF.ar(Saw.ar(note.namecps)+Saw.ar(note.namecps(34)), 180)*EnvGen.kr(Env.perc(0.01, rel), doneAction:2)*amp}.play(s, 11);};
~keizer80b.("g1", 1);
~bass80 = {~keizer80b.(~progb.next, 1); };
~progb = Pseq(["g1", "c1", "e1", "d1"].stutter(2), inf).asStream;
// synth
~keizer80 = {arg chord, oct=4, amp=0.1, at=0.2, rl=0.1, out=6; {Saw.ar(chord*oct).sum*amp*EnvGen.kr(Env.perc(at, rl), doneAction:2); }.play(s, out) };
~keizer80.(~gM7M, at: 0.1, rl:4);
~chords = {~keizer80.(~prog80.next, ~oct.next, 0.2, 0.01, 0.2, out:90); };
~chords2 = {~keizer80.(~prog80.next, 4, 0.1, 0.1, 0.1, out:90); };
~prog80 = Pseq([~gM7M, ~cM7, ~gM7M, ~cM7, ~em, ~dM7].stutter(4)*1, inf).asStream; // stut 12
~oct = Pseq([2,8,4], inf).asStream;
// synth mel
~keizer80m = {arg chord, oct=4, amp=0.1, at=0.2, rl=0.1, out=6; {Saw.ar(chord*oct)*amp*EnvGen.kr(Env.perc(at, rl), doneAction:2); }.play(s, out) };
~mel80 = {~keizer80m.(~prog80m.next, 1, 0.1, 0.01, 1, out:90); };
~prog80m = Pseq(~frase1++~frase2, inf).asStream;
~frase1 = ["g3".namecps, "g3".namecps, "a3".namecps, "d3".namecps, "c3".namecps];
~frase2 = ["c4".namecps, "c4".namecps, "B3".namecps, "a3".namecps, "a3".namecps];
~mel802 = {~keizer80m.("d4".namecps, 1, 0.1, 0.01, 1, out:90); };
);
// fx
~rev = {FreeVerb.ar(In.ar(90)+In.ar(90), 0.4, 0.8)};
~rev.().play(s,9,2);
~rev.().free;
~rev = ();

a.beats=16;
~funcs_a=();

~funcs['bd'] = {PZ_layer(~bd).rhythm(1,0,1,0)};
~funcs['sn'] = {PZ_layer(~sn80).rhythm(0,1,0,1)};
~funcs['hh'] = {PZ_layer(~hh).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['bass'] = {PZ_layer(~bass80).rhythm([0,1],[0,1],[0,1],[0,1])};
~funcs['lead'] = {PZ_layer(~chords).rhythm([0,2],[4], 0,0)};
~funcs_a['mel'] = {PZ_layer(~mel80).rhythm([2],1,[2],0)};
~funcs_a['mel2'] = {PZ_layer(~mel802).rhythm(0,0,0,[0,~ting.next])};

~funcs_a['lead2'] = {PZ_layer(~chords2).rhythm(0,[4],0,[4]);};

~ting = Pseq([0,1], inf).asStream;


~funcs=();
~funcs['lead2'] = nil;
~funcs['lead'] = nil;

~funcs['sn'] = nil;
~funcs['bass'] = nil;