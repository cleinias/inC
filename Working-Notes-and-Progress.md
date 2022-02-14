#              In C - Working notes

## A - Basic plan


### Phase 1 - Minimal working prototype

| Step                                                                  | Progress |
|-----------------------------------------------------------------------|----------|

1. Write general program structure as functions                          DONE
2. Write patterns-generating function                                    DONE
3. Write performance generating function:
      - General setup                                                    DONE
      - Create individual *randomized* scores for player                 DONE //but as a beforehand computation
        according to performance parameters
      - Add random cell transposition
      - Create instruments and assign to players:
        - As internal SynthDefs, as MIDI, as samples, etc.

4. Write performance executing function(s):
      - As simple as possible with internal default PBind instrument     DONE
      - Slightly more complex with different internal instruments
      - With MIDI out to synth (possibly Carla-hosted Kontakt)
      - With MIDI out to Ardour (controlled from Ardour)


### Phase 2 - Refactor into classes


### Phase 3 - Add complete scores and full instrument set



### Phase 4 - Add Riley's additional (and not so additional) options:
- Pulse instrument
- Improvised percussions
- Ending with repeat crescendo and diminuendo and instruments' randomly dropping off


### Phase 5 - Explore live performance interaction with algorithm


### Phase 6 - Add minimal GUI to control performance at run time



## B -  Scattered notes

### To create a random number of pattern repetitions:

- Still unclear


### Instruments and PBind
(See SC's _Patterns guide_, sec. 3 for extended discussion, plus SC's book. Here is the basic gist)

Pbind's 'play' method creates an event and plays according to an event prototype:

- using a default SynthDef, and
- passing to the SynthDef all the *indentically named* _patterns_ passed to the PBind itself (but see caveats in docs)
- to change instruments, you define an appropriate SynthDef and then pass its symbol to the PBind with the `\instrument` key.

Example from the docs:
```
SynthDef(\harpsi, { |outbus = 0, freq = 440, amp = 0.1, gate = 1|
    var out;
    out = EnvGen.ar(Env.adsr, gate, doneAction: Done.freeSelf) * amp *
        Pulse.ar(freq, 0.25, 0.75);
    Out.ar(outbus, out ! 2);
}).add;    // see below for more on .add

p = Pbind(
        // Use \harpsi, not \default
    \instrument, \harpsi,
    \degree, Pseries(0, 1, 8),
    \dur, 0.25
).play;
```
```
test
test
```
