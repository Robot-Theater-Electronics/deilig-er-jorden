// fx

~revfree = {FreeVerb.ar(In.ar(90)+In.ar(90), 0.4, 0.8)};
~revkeizer = {|in=60, amp=0.1, dec=88| GVerb.ar(In.ar(in), 120, dec)*amp};
~fx = {|in=16, amp=0.1, dec=160, dur=2| CombN.ar(PitchShifter.ar(In.ar(in), 3, dur, 2,1,0.001), 0.1, 2/t.tempo, dec)*amp};

~rev[90] = ~revfree.play(s,6,1);
~rev[90].free;
~revs[60] = ~revkeizer.play(s,6,2);
~revs[60].free;
~fxs[60] = ~fx.play(s, 60,2);
~fxs[60].free;

