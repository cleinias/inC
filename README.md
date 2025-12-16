# inC
Self-education project -- replicate Terry Riley's _In C_ with Supercollider (and learn SC's pattern language along the way)

The replica is divided into a number of stages of increasing complexity. Each stage, if it exists,
is fully contained with a Supercollider file named _inC-n.scd_ with n from 1 to 7. Follow the instructions within the file to create and execute a performance of inC at the _n_ level. 


```
/**************************************************
*** 0 - Executing instructions for Phase 1         *
***************************************************/

/* 1. Set up the external MIDI synth player
      1.1 Make sure the synth player's channels
          correspond to the table that ~createInstruments
          produces (see below)

   2. Initialize the MIDIOut connection with
      MIDIOut.init;

   3. Connect Supercollider to the MIDI synth
      (externally, in Carla, qpwgraph, etc.)

   4. Choose players by creating an array of instruments
      names using the symbols used in ~createInstruments,
      e.g.:
      players = [\piano, \piano, \organ, \trumpet, \trumpet];

   5. Choose a performance length in minutes, and a tempo in bpm
      Notice that performance length cannot be shorter than
      scoreLength/tempo, that is 260/tempo. For reference,
      at the tempo of 63bpm of the original perfomance,
      the minimum performance length is 263/63 = 4.17 minutes.

   6. Create the performance with (for instance):
      ~perf = ~createPerformance(players, length , tempo , ~createMelPatterns)

   7. Execute the performance with:
      ~execPerf = ~executePerformance(~perf);

   8. Stop the performance with
     ~ ~execPerf.stop;

*/
```
See docs/Description.md for additional details. 

