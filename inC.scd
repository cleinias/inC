/********************************************************************************************************************
               In C - Phase one implementation, a minimal working prototype
*********************************************************************************************************************/


/* A minimal test with:
- all 53 melodic patterns
- 5 identical instruments
- no transposition
*/

/**************************************************
*** 1-A Setting up the score and the instruments  *
***************************************************/


(
~createMelPatterns = {
	// Create all the 53 melodic patterns in Riley's "In C"
	// Return a vector of dictionaries, one per pattern

    // Durations are expressed as fraction of a beat, or more precisely as a fraction of a quarter note.
    // TODO: Conversion of durations from beats to millisecond must be carried out when the score is created

	var melCells;
    melCells= [
 //1-10
    //Acciaccatura to a quarter note rendered as 1/32 note (1/8 of a beat):
    Dictionary.newFrom([\pitches, [0,2,0,2,0,2],\durs, [0.125, 0.875, 0.125, 0.875, 0.125, 0.875]]),
    //Acciaccatura to an eighth note rendered as 1/64 note (1/16 of a beat):
    Dictionary.newFrom([\pitches, [0,2,3,2],\durs, [0.0625, 0.9375, 0.5, 1]]),
    Dictionary.newFrom([\pitches, [Rest(),2,3,2],\durs, [0.5, 0.5, 0.5,0.5]]),
    Dictionary.newFrom([\pitches,[Rest(),2,3,4],\durs,[0.5,0.5,0.5,0.5]]),
    Dictionary.newFrom([\pitches,[2,3,4,Rest()],\durs,[0.5,0.5,0.5,0.5]]),
    Dictionary.newFrom([\pitches,[7],\durs,[8]]),
    Dictionary.newFrom([\pitches,[Rest(),Rest(),Rest(),Rest(),0,0,0,Rest(),Rest(),Rest(),Rest(),Rest],
                        \durs, [1,1,1,0.5,0.25,0.25,0.5,0.5,1,1,1,1]]),
    Dictionary.newFrom([\pitches,[4,3],\durs,[6,8]]),
    Dictionary.newFrom([\pitches,[6,4,Rest(),Rest(),Rest(),Rest()],\durs,[0.25,0.25,0.5,1,1,1]]),
    Dictionary.newFrom([\pitches,[6,4],\durs,[0.25,0.25]]),
 // 11-20
   Dictionary.newFrom([\pitches,[3,4,6,4,6,4],\durs,[0.25,0.25, 0.25, 0.25,0.25,0.25]]),
   Dictionary.newFrom([\pitches,[3,4,6,7],\durs,[0.5,0.5,4,1]]),
   Dictionary.newFrom([\pitches,[6,4,4,3,4,Rest(),4],\durs,[0.25, 0.75,0.25,0.25,0.5,0.75,3.25]]),
   Dictionary.newFrom([\pitches,[7,6,4,3.1],\durs,[4,4,4,4]]),
   Dictionary.newFrom([\pitches,[4, Rest(),Rest(),Rest(),Rest()],\durs,[0.25,0.75,1,1,1]]),
   Dictionary.newFrom([\pitches,[4,6,7,6],\durs,[0.25,0.25,0.25,0.25]]),
   Dictionary.newFrom([\pitches,[6,7,6,7,6,Rest()],\durs,[0.25, 0.25, 0.25, 0.25, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[2,3.1,2,3,2,2],\durs,[0.25,0.25,0.25,0.25,0.75,0.25]]),
   Dictionary.newFrom([\pitches,[Rest(),11],\durs,[1.5,1.5]]),
   Dictionary.newFrom([\pitches,[2,3.1,2,3,-3,2,3,2,3,2],\durs,[0.25, 0.25, 0.25, 0.25, 0.75,0.25, 0.25, 0.25, 0.25, 0.25]]),
 // 21-30
   Dictionary.newFrom([\pitches,[3.5],\durs,[3]]),
   Dictionary.newFrom([\pitches,[2, 2, 2, 2, 2, 3.1, 4, 5, 6],\durs,[1.5,1.5,1.5,1.5,1.5,1.5,1.5,1.5,0.5]]),
   Dictionary.newFrom([\pitches,[2, 3.1, 3.1,3.1,3.1,3.1,4,5,6],\durs,[0.5,1.5,1.5,1.5,1.5,1.5,1.5, 1.5,1]]),
   Dictionary.newFrom([\pitches,[2,3.1,4,4,4,4,4,5,6],\durs,[0.5,0.5, 1.5,1.5,1.5,1.5,1.5,1.5,0.5]]),
   Dictionary.newFrom([\pitches,[2, 3.1, 4, 5, 5, 5, 5, 5 ,6],\durs,[0.5,0.5,0.5,1.5,1.5,1.5,1.5,1.5,1.5]]),
   Dictionary.newFrom([\pitches,[2, 3.1,4,5, 6, 6, 6, 6, 6 ],\durs,[0.5,0.5,0.5,0.5,1.5,1.5,1.5,1.5,1.5]]),
   Dictionary.newFrom([\pitches,[2,3.1,2,3.1,4,2,4,3.1,2,3.1,2],\durs,[0.25, 0.25,0.25,0.25, 0.5, 0.25, 0.25,0.25,0.25,0.25,0.25]]),
   Dictionary.newFrom([\pitches,[2,3.1, 2,3.1,2,2,],\durs,[0.25, 0.25, 0.25, 0.25, 0.75,0.25]]),
   Dictionary.newFrom([\pitches,[2,4,7],\durs,[3,3,3]]),
   Dictionary.newFrom([\pitches,[7],\durs,[3]]),
 // 31-40
   Dictionary.newFrom([\pitches,[4,3,4, 6,4,6],\durs,[0.25, 0.25, 0.25, 0.25, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[3,4,3,4,6,3,4],\durs,[0.25, 0.25, 0.25, 0.25, 0.25,  3.25,1.5]]),
   Dictionary.newFrom([\pitches,[4, 3, Rest()],\durs,[0.25, 0.25, 0.5]]),
   Dictionary.newFrom([\pitches,[4, 3],\durs,[0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[3, 4, 6, 4,6,4,6,4, 6, 4, Rest(), Rest(), Rest(), Rest(),
                                 6b, 11, 12, 11,  13, 12,11, 9,11, 10.1, Rest(),  Rest(), Rest(),  10, 11],
                        \durs,  [0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.25, 0.5, 1, 1, 1,
                                  1, 3, 0.5, 1, 0.5, 1.5, 0.5, 3, 0.5, 3.5, 1, 1, 0.5, 3.5, 3 ]]),
   Dictionary.newFrom([\pitches,[3, 4, 6, 4, 6, 4],\durs,[0.25, 0.25, 0.25, 0.25, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[3, 4],\durs,[0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[3, 4, 6],\durs,[0.25, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[6, 4, 3, 4, 6, 7],\durs,[0.25, 0.25, 0.25, 0.25, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[6, 3],\durs,[0.25, 0.25]]),
 // 41-50
   Dictionary.newFrom([\pitches,[6, 4],\durs,[0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[7, 6, 5, 7],\durs,[4, 4, 4, 4]]),
   Dictionary.newFrom([\pitches,[10, 9, 10, 9, 9, 9, 9, 10, 9],\durs,[0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[10, 9, 9, 7],\durs,[0.5, 1, 0.5, 1]]),
   Dictionary.newFrom([\pitches,[8, 8, 4],\durs,[1, 1, 1]]),
   Dictionary.newFrom([\pitches,[4, 8, 9, 8, Rest(), 4, Rest(), 4, Rest(), 4, 4, 8, 9, 8],
                        \durs,[0.25, 0.25, 0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.25, 0.25, 0.25, 0.25, ]]),
   Dictionary.newFrom([\pitches,[8,9,8],\durs,[0.25, 0.25, 0.5]]),
   Dictionary.newFrom([\pitches,[4, 4, 3],\durs,[6, 4, 5]]),
   Dictionary.newFrom([\pitches,[3, 4, 6b, 4, 6b, 4],\durs,[0.25, 0.25, 0.25, 0.25, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[3, 4],\durs,[0.25, 0.25]]),
 //51-53
   Dictionary.newFrom([\pitches,[3, 4, 6b],\durs,[0.25, 0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[4, 6b],\durs,[0.25, 0.25]]),
   Dictionary.newFrom([\pitches,[6b, 4],\durs,[0.25, 0.25]])];
    }
)

(//Testing:
// - all patterns should have equal number of pitches and durations
// - there shoud be 53 patterns
// - total duration should be equal to
a = ~createMelPatterns.value;
['Patterns in score --> ', a.size].postln;
a.do({|item i| [i+1, "-> ",item[\pitches].size,item[\durs].size,'total beats-->',item[\durs].sum,item[\pitches],item[\durs]].postln;});
)

(// Auditory testing:
 //Play each pattern once, wait a second in between
~testMelPatterns = {
	| patterns tempo |
	// Play all melodic patterns in sequence at tempo, with a little rest in between
	// Use fork passed to a routine (indicated with {} ) to pause between Pbinds
	{
		patterns.do({ |item i|
			Pbind(\degree, Pseq(item.at(\pitches),1),
				  \dur,    Pseq(item.at(\durs),1)).play;
			2.wait;})
	    }.fork(TempoClock(tempo/60));
	};
a = ~testMelPatterns.value(~createMelPatterns.value,60);
a.stop;
)

// Create a small collection of some common instruments
// from the SCLOrk quark (Santa Clara Laptop Orchestra Quark)

// TODO: Load a small collection of SCLOrk instruments onto the server,
// put a reference into the following dictionary

/

// TODO: the instruments are not loaded into SynthDefs (in the newt to last line of the function)
(
~commonSclorkInstr = {
     // Load a small selection of SCLOrk common instruments if not loaded already.
     // Return a collection of synthDefs
     var sclorkCommon, synthDefs;
    // Check the SCLork quark is installed, install otherwise
    if (Quarks.isInstalled("SCLOrkSynths"),
        {"SCLorkSynths installed already".postln;},
        {"Installing SCLOrkSynths...".postln;
         Quarks.installQuark(SCLOrkSynths);
         "SCLorkSynths installed".postln;});
    // Choose a few instruments
    sclorkCommon = [\cheapPiano1, \kalimba, \xylophone, \waveguideFlute, \pluck];  /// demo instrs with: SCLOrkSynths.gui
    synthDefs = Array.new(sclorkCommon.size);
    // Check if they are loaded, load them otherwise
    sclorkCommon.do({
        | item i |
        if (SynthDescLib.global.synthDescs.at(item).isNil,
            {"I should load -->".post; item.postln;
             "xx".postln;
             item.post;" loaded".postln;},
            {item.post;" is loaded already".postln;}); // TODO: Here you load the instrument
        synthDefs.add("??");  // TODO: here you pass the synthDef
      });
    // return a collection with the loaded instruments' SynthDefs
    synthDefs;
}
)


// testing: load instruments and play a C maj lydian scale on each one of them in turn
(
var scale = [0,1,2,3.1,4,5,6,7], instrs;
instrs= ~commonSclorkInstr.value();
instrs.inspect;
instrs.do({
    |item i|
    "Now playing ".post; item.postln;
    Pbind(\instr, item,
          \degree, Pseq(scale,1),
          \dur, 0.5).play;});
)

(
    var scale = [0,1,2,3.1,4,5,6,7], pbinds=List.new,instrs;
    instrs= ~commonSclorkInstr.value();
    pbinds=instrs.collect({
        | item i|
         Pbind(\instr, item,
          \degree, Pseq(scale,1),
          \dur, 0.5).play;});
    pbinds.do({|item i| item.play});
)
/***********************************************
*** 1-B Setting up a performance's parameters  *
************************************************/

// 1-B-1 Setting up general performance parameters

(
~createPerformance = {
  /* - Setup performance parameters: performance length, tempo, number of players, instruments
  // - Also setup environment (initialize Midi connections, setup midi ports, etc.)
  // Return a dictionary with tempo, playersNum, performLength, basicScore, and an array of players
  //
  // Parameters
  // - instruments:  an Array of SynthDef that will be used by the players.
  // - length in minutes (Riley's instructions say 45 to 90', but we default to 5)
  // - tempo (In standard bpm. Riley is rather vague about tempo)
  // - patternsFunction is a function that creates the vector of melodic cells.
        It the only parameters that does not have a default and must always be passed.
        It will eventually be replaced with a proper method to the MelodicCells class
  */
    |instruments, performLength = 5, tempo = 120, patternsFunction |
    var performance = Dictionary.new, players = Array.new;
    //patternsFunction.postln;
    if (patternsFunction.isNil, {"Error: Performance needs a vector of melody cells to be instantiated".postln});

    //an empty players argument picks the default instruments (kind and kind as per called function)
    if (instruments.isNil,
        {instruments = ~defaultInstruments.value()});

    performance[\tempo]=tempo;
    performance[\playersNum]=players.size;
    performance[\performLength]=performLength;
    performance[\basicScore]=patternsFunction.value;

    //get an array of players with individualized scores and instruments
    performance[\players]=instruments.collect{
        |item i|
        var score;
        score = ~createPlayerScoreInAdvance.value(performance[\basicScore], performLength, tempo, nil);
        score[\instrument]=item;
    };
    //return the performance object
    performance;
}
)
//testing
(
p=~createPerformance.value(performLength:5, patternsFunction:~createMelPatterns);
p[\players].size.postln;
p[\players].do({|item i|item[\score][\pitches].size.postln});
//p.inspect
)
/*********************************
*** 1-C Creating the players *
**********************************/

/*
A player must:
  1. Create a score by choosing a variable number of repeats for each patterns, within the allowed limits
  2. Set up an instrument to play the created score
  3. more?
*/

/*

- Each player must have, at a minimum, a version of the score and an instrument to play it on.
  Other parameters may be added later.
- There are at least two possible options for player creation (looking forward to full implementation):
   a - Create every player individually, and customize them one by one
   b - Instantiate a random number of players into a vector, then customize them

 - There are also at least two possible options for score creation:
   a - create each player's complete score before executing the performance
   b - have each player instantiate the needed number of repetitions for each melodic cell
       *during* the performance (simulating an actual performance as originally intended)
   Option b is more interesting and leave open the possibility of inserting (later)
   some interaction with the performance during execution, but it is also more complex.

- There are also different options on the actual instruments.

I will start with the simpler (a) options first.
*/

(
~computeCellReps= {
        /*
         Compute the (approx.) number of repetitions a cell need (based on the ratio between single cell and score)
         and the desired total length at a given tempo
        */
    |melCells cell tempo perfLength|
    var desLengthBeats, reps ;
    desLengthBeats = (((perfLength * 60) / melCells.size)*(tempo/60)).round;  //appr. desired *total* length in beats
    reps = ((desLengthBeats/cell[\durs].sum)+0.5).round.asInteger; //approximate number of reps needed, minimum of 1
    reps;
};
)

(
//testing
var melCells = ~createMelPatterns.value();
p = ~computeCellReps.value(melCells, melCells[0],120, 1);
p.postln;
)

(
~createPlayerScoreInAdvance = {
    /* Return a player object (aDictionary) with a full instantiated score constructed
       from melCells and lengths, plus an instrument to play it with.
       melCells is the array of melodic cells,
       perfLength is desired performance length in minutes
       tempo is in bpm
       instrument is still to be decided, most likely a synthDef,
                  unless the output is redirected to a MIDI capable player via MIDIout.
                  Kontakt hosted on Carla works fine, but it needs to be initialized first,
                  and then connected to the MIDIOut instance in Helvum or qpwgraph.
                  Then each player must be assigned a different MIDI channel, corresponding
                  to the instrument loaded into Kontakt. Notice however that MIDI connections
                  may carry a maximum of 16 channels, which means a performance with more than 16
                  instruments will require multiple Kontakt (or similar) instances.
                  Notice also that the MIDI channel should be decided by the performance object
                  by assigning a channel number from the available pool.
                  Or, alternatively, by extracting channel numbers from a dictionary indexed
                  by instrument (and which assumes a suitable arrangement on the Kontakt back-end).
                  (see docs: Using patterns for sending MIDI events, Pattern Guide Cookbook 4.)
                   */

    | melCells perfLength tempo instrument |

    var actualScore, player=Dictionary.new,score, pitches=List.new(), durs=List.new();
    player[\score]=Dictionary.newFrom([\pitches,pitches,\durs, durs]); // Flattened representation of the complete score as [\pitches,\durs]
    score = melCells;
    melCells.do({
        |item i|
        var reps, cell, pitches, durs;
        cell = Dictionary.new;
        reps = ~computeCellReps.value(melCells:score,cell:item, tempo:tempo, perfLength:perfLength);
        // we may want to add some more stuff here in the future,
        // such as likelihood of octave jumps, slight push/drag, etc.
        //
        //Multiply the cell's pitches and durs by a random number of reps
        //and add them to the player's actual score array
        reps = rrand(reps-1,reps+1);  //may have to change to account for cell's length
        player[\score][\pitches].addAll(item[\pitches].dup(reps).flatten);
        player[\score][\durs].addAll(item[\durs].dup(reps).flatten);
        //test
        player[\score][\pitches].size.postln;
        player[\score][\durs].size.postln;
        });
        //testing
        player[\score][\pitches].size.postln;
        player[\score][\durs].size.postln;
    // shouldImplement (instrument selection not implemented yet)
        player[\instrument]=0;
    };
)

(~defaultInstruments={
    |instr=5|
    // Return an array of identical default SynthDefs, defaults to 5

    var synth, instruments;
    synth = SynthDef(\basic_mdapiano, { |out=0, freq=440, gate=1|
        var son = MdaPiano.ar(freq, gate, release: 0.9, stereo: 0.3, sustain: 0);
        DetectSilence.ar(son, 0.01, doneAction:2);
        Out.ar(out, son * 0.1);
    }).add;
    instruments = synth.dup(instr);
    }
)


(
//testing player creation
a = ~createMelPatterns.value;
//a.class;
b = ~createPlayerScoreInAdvance.value(melCells:a, perfLength:35, tempo:100, instrument:nil);
b.class.postln;
b[\score][\pitches].size.postln;
b[\score][\durs].size.postln;
)


/*********************************
*** 1-D Performing the score     *
**********************************/

// 1-D-1 Setup
// 1-D-11 General setup if needed (SynthDef definition, Midi connections, etc)
// 1-D-12 Create the performance (with 0 instruments, will default to 5, performLength = 5, tempo = 120, patternsFunction )
   ~perf = p=~createPerformance.value(patternsFunction:~createMelPatterns);

// 1-C-2 Execute the performance
(
~executePerformance = {
    /*
    Create Pbind patterns from the info about the players contained in the performance object
    */
    | performance |
    var pbinds=List.new;
    pbinds=performance[\players].collect({
        | item i|
        Pbind(\degree, Pseq(item[\score][\pitches]), \dur, Pseq(item[\score][\durs]));
        });
    Ppar(pbinds).play;
};
)
//testing

(
p=~createPerformance.value(performLength:35, tempo: 50, patternsFunction:~createMelPatterns);
q=~executePerformance.value(p);
// t= Ppar(q).play;
//p[\players].size.postln;
//p[\players].do({|item i|item[\score][\pitches].size.postln});
// t=q[0].play;
)
q.stop
// 1-C-3 Cleanup afterwards
// Need to free al the SynthDefs?

/************************************************
*** 1-E  Helper functions and code snippets     *
*************************************************/



/**********************************************************************************************************
**********************************************************************************************************
* Scratch*/
*/

(~scratchBPS = 100; // perf tempo
~scratchTotalBeats = 248.5; // total beats for all 53 patterns
~singleRepLength = ~scratchTotalBeats / (~scratchBPS/60); //total duration in secs of all combined patterns
~scratchDesiredLength = [45,90]; //min and max performance lengths in minutes as per Riley's score
~scratchMinMaxReps = [((~scratchDesiredLength[0]*60)/~singleRepLength).round.asInteger,
	                  ((~scratchDesiredLength[1]*60)/~singleRepLength).round.asInteger];
//Min and max numbers of reps of total 53 patterns to achieve desired performance length
~scratchMinMaxReps.do({ |item i|
	"tempo".postln;do
})
)
(a = [3,5];
b= (a[1]-a[0]).rand + a[0];
b= ((a[1]-a[0]).asFloat.rand.round.asInteger) + a[0];
b.postln;
//a.repeat(2)
//a.postln;
);

(~pitches = [];
~cells = [ [ 1, 3, 5, 7], [1, 3, 2]];
~minMax = [2,5] ;
~pitches = 	~cells.collect({
		|item i|
		var reps;
		reps = rrand(~minMax[0], ~minMax[1]);
		(item ! reps).flatten(0); // ! is a shorcut for Array.dup()
	});
~pitches.flatten(2).postln;
);
)
(
Pswitch(
	~cells.collect { |cell| Pseq(cell, 1) },
	Pdup(
		Pwhite(2, 5, inf),
		Pn(Pseries(0, 1, ~cells.size), inf)
	)
)
.asStream.nextN(50)
)

(
~cells = [ [ 1, 3, 5, 7], [1, 3, 2]];
Pflatten(1, Pdup(Pwhite(2, 5, inf), Pseq(~cells, inf)))
.asStream.nextN(50)
)

m = Pn(Pseq([1,2,3]),2).asStream.nextN(10);
m.next()

(
r = 3; ~cell = [[1, 3, 5,8],[1,0.5,0.5,1]];
n = rrand(r-1,r+1);
b = Pbind(
    \degree, Pseq(~cell[0],n),
    \dur, Pseq(~cell[1],n),
        );
b.play
)
20.10.rand2;
rrand(2,3)
~cell
 Quarks.gui


/*
 The following (simplified) example from the docs works fine (assuming Midi Through is connected to an actual synth,
 I used fluidsynth to test).
 TODO: Not clear how to connect to other midi in ports, though. Check the destination (after init) with:
 MIDIClient.destinations;


// MIDIClient.init;    // if not already done
//

(
// substitute your own device here
var    mOut = MIDIOut.newByName("Midi Through", "Midi Through Port-0").latency_(Server.default.latency);

p = Pbind(
    \type, \midi,
    // this line is optional b/c noteOn is the default
    // just making it explicit here
    \midicmd, \noteOn,
    \midiout, mOut,    // must provide the MIDI target here
    \chan, 0,
    // degree is converted to midinote, not just frequency
    \degree, Pseq([1,3,5,8],1),
    \dur, Pseq([1,1,1,1], inf),
).play(quant: 1);
)

p.stop;
*/

List[1,2].addAll([3])
