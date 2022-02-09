/*   In C

A supercollider rendition of Terry Riley's In C that follows Riley's score instructions as closely as possible
*/

/* Basic elements of Riley's score, as per his own instructions:

1.  53 melodic patterns
2.  Patterns are to be played consecutively with each
    performer having the freedom to determine how many times
    he or she will repeat each pattern before moving on to the next.
3.  To keep the performance between 45 min and an hour eache pattern
    should be repeated between 45 seconds and a minute and a half or longer
4.  A group of about 35 instrumentalist is desired but smaller
    or larger groups can work too.
5.  Any instrument can play
6.  Each pattern can be played in unison or canonically
    in any alignment with itself or with its neighboring patterns.
7.  As the performance progresses, performers should stay
    within 2 or 3 patterns of each other. It is important not
    to race too far ahead or to lag too far behind.
8.  The ensemble can be aided by the means of an eighth note pulse
    played on the high c’s of the piano or on a mallet instrument.
9.  It is also possible to use improvised percussion in strict rhythm
    (drum set, cymbals, bells, etc.), if it is carefully done
    and  doesn’t overpower the ensemble.
10. Tempo is left to the discretion of the performers, not too slow
11. It is OK to transpose patterns by an octave, especially to transpose up.
12. Transposing down by octaves works best on the patterns
    containing notes of long durations.
13. Augmentation of rhythmic values can also be effective.
14. In C is ended in this way: when each performer arrives at figure #53,
    he or she stays on it until the entire ensemble has arrived there.
15. The group then makes a large crescendo and diminuendo a few times
    and each player drops out as he or she wishes.
*/


/* Phase 1: minimal test with:
- 3 melodic patterns (first three)
- 2 instruments
- no transposition
*/


/******************************
*** 0- General setup          *
*******************************/

/*
All data and algorithms of In C are contained in three main objects:

- MelodicPatterns
  The repository of melody cells

- Performance
  Contains parameters about number of players, duration, and tempo (for now)

- Players
  Data about the players, including their scores and instruments

In this first test, the three main objects are represented by environment variables:

   -- ~melPatterns
    - ~performance
    - ~player

Refactoring to proper classes will happen later. Performance is the main object. It has:

 - an instance of melodic patterns (melPatterns)
 - a set of performance parameters
 - a collection of players instantiated on the basis of the performance parameters
 - an actual score generated on the basis of performance parameters (possibly. See notes on payesr below)

Refactoring will translate the above to classes, of course.
*/


/******************************
*** 1-A creating the patterns *
*******************************

- Patterns are coded as a dictionary of two vectors, containing, respectively, pitches and durations (we are using dictionary to leave open the possibility to add more features later)
- The pattern dictionaries are then stored in a vector containing all the melodic patterns (melCells)
- Pitches are specified in degrees
- Durations are indicated in fraction of a beat
*/

(
~createMelPatterns = {
	// Create all the 53 melodic patterns in Riley's "In C"
	// Return a vector of dictionaries, one per pattern
	var m01, m02, m03, m04, m05, m06, m07, m08, m09, m10;
	var m11, m12, m13, m14, m15, m16, m17, m18, m19, m20;
	var m21, m22, m23, m24, m25, m26, m27, m28, m29, m30;
	var m31, m32, m33, m34, m35, m36, m37, m38, m39, m40;
	var m41, m42, m43, m44, m45, m46, m47, m48, m49, m50;
	var m51, m52, m53;
	var melCells;


// Pattern 1
m01 = Dictionary();
m01.put(\pitches, [1,3,1,3,1,3]);
//Acciaccatura to a quarter note rendered as 1/32 note (1/8 of a beat):
m01.put(\durs, [0.125, 0.875, 0.125, 0.875, 0.125, 0.875]);

// Pattern 2

m02 = Dictionary();
m02.put(\pitches, [1,3,4,3]);
//Acciaccatura to an eighth note rendered as 1/64 note (1/16 of a beat):
m02.put(\durs, [0.0625, 0.9375, 0.5, 1]);


// Pattern 3
m03 = Dictionary();
m03.put(\pitches, [Rest(),3,4,3]);   // pattern starts with a rest
m03.put(\durs, [0.5, 0.5 , 0.5, 0.5]);

// Vector with all melodic patterns
melCells.postln;
melCells = [m01,m02,m03];
}
)
//testing
(
a = ~createMelPatterns.value;
a.inspect;
)
/***********************************************
*** 1-B Setting up a performance's parameters  *
************************************************/

// 1-B-1 Setting up general performance parameters
//TO DO:  Using a function for all performance-related parameters for now, will fix later with a proper class.

(
~createPerformance = {
  /* - Setup performance parameters: performance length, tempo, number of players, instruments
  // - Also setup environment (initialize Midi connections, setup midi ports, etc.)
  // Return a dictionary.
  //
  // Parameters
  // - playersNum (self-explanatory)
  // - length in minutes (Riley's instructions say 45 to 90', but we default to 5)
  // - tempo (In standard bpm. Riley is rather vague about tempo)
  // - patternsFunction is a function that creates the vector of melodic cells.
        It the only parameters that does not have a default and must always be passed.
        It will eventually be replaced with a proper method to the MelodicCells class
  */
    |playersNum = 2 , performLength = 5, tempo = 120, patternsFunction |
    var performance = Dictionary.new;
    patternsFunction.postln;
    if (patternsFunction.isNil, {"Error: Performance needs a vector of melody cells to be instantiated".postln});

    performance[\tempo]=tempo;
    performance[\playersNum]=playersNum;
    performance[\performLength]=performLength;
    performance[\basicScore]=[patternsFunction.value];
    performance[\players]=playersNum.collect{
        |item i|
        ~createPlayer.value(performance[\basicScore], performLength, tempo, nil)};
    //return the performance object
    ^performance;
}
)
//testing
p=~createPerformance.value(patternsFunction:~createMelPatterns);

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
   some interaction with the performance suring execution, but it is also more complex.

I will start with the simpler (a) options first.
*/

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

(
~createPlayer = {
    /* Return a player object (aDictionary) with a full instantiated score constructed
       from melCells and lengths, plus an instrument to play it with
       melCells is the dictionary of melodic cells,
       perfLength is desired performance length in minutes
       tempo in bpm
       instrument is still to be decided, most likely a synthDef,
                  unless the output is redirected to Ardour via MIDI
                 (see docs: Using patterns for sending MIDI events, Pattern Guide Cookbook 4.
                            It seems all it's needed is a midi port and a midi channel)*/

        | melCells perfLength tempo instrument|

    var desLengthBeats, actualScore, player;
    actualScore = Array.new(melCells.size);
    player = Dictionary.new();

    desLengthBeats = (((perfLength * 60) / melCells.size)*(tempo/60)).round;  //appr. desired lengths in beats of each cell
    melCells.do{
        |item i|
        var cellBeats, reps, cell;
        cell = Dictionary.new;
        cellBeats = item[\durs].sum;
        reps = ((desLengthBeats/cellBeats)+0.5).round; //approximate number of reps needed, minimum of 1
        cell[\pitches]  = item[\pitches];
        cell[\durs] = item[\durs];
        cell[\reps]=reps;
        // we may want to add some more stuff here in the future,
        // such as likelihood of octave jumps, slight push/drag, etc.
        actualScore.add(cell); //add the computed cell to the player's actual score array
        // "I am here".postln;
        // actualScore.postln;
       };
    player[\score]=actualScore;
    // not implemented yet
    player[\instrument]=0;
    };
//)

//(
//testing player creation
a = ~createMelPatterns.value;
//a.class;
b = ~createPlayer.value(melCells:a, perfLength:5, tempo:100, instrument:nil);
b.inspect;
)

/* :
/********************************************************************************
*** 1-C Create the score (Compute the number of desired repetitions per pattern *
********************************************************************************
*/

/*
    - We divide the desired performance length in seconds by the number of patterns
      to get an appr. length for each performed pattern
    - run over the duration vectors of each pattern and
       - compute the pattern length in seconds (duration in beats / beats per seconds)
       - divide the approx length in sec by the pattern lengths in sec to get the needed reps
       - Put the number in the pattern's dictionary

*/

(~addRepsToCells = {
   // Compute the average number of reps per pattern (cells)
   // needed to (approximately) reach desired performance length
   // in minutes (minMaxLengths) at given tempo in bpm (perfTempo)
   // add the computed reps to the cells's dictionary'

	//TODO: redo completely on the basis of notes above
	// Now it is all wrong

   |cells  minMaxLengths perfTempo|
   var beatLength, totSecsLength, minMaxBeatLengths;
   beatLength = cells.collect({
            |item i|
            item[\durs].sum}).sum;
    totSecsLength = beatLength / (perfTempo/60);
    minMaxBeatLengths= [((minMaxLengths[0]*60)/totSecsLength)          .round.asInteger;,
                       ((minMaxLengths[1]*60)/totSecsLength).round.asInteger];
   cells.do({|item i|
		     var cellSecsLenghts;
		cellSecLengths[0]= minMaxLengths[0]*60*(item.[\dur].sum / beatLength);
		cellSecLengths[1]= minMaxLengths[1]*60*(item.[\dur].sum / beatLength);
		     item.put(\reps,minMaxReps); });
    }
);

*/

/*********************************
*** 1-D Performing the score     *
**********************************/



// 1-D-2 Start the performance


// 1-D-3 Cleanup afterwards


/************************************************
*** 1-E  Helper functions and code snippets     *
*************************************************/


(
// Testing the created patterns
~testMelPatterns = {
	| patterns tempo|
	// Play all melodic patterns in sequence at tempo, with a little rest in between
	// Use fork passed to a routine (indicated with {} ) to pause between Pbinds
	{
		patterns.do({ |item i|
			Pbind(\degree, Pseq(item.at(\pitches),1),
				  \dur,    Pseq(item.at(\durs),1)).play;
			2.wait;})
	    }.fork(TempoClock(tempo/60));
	};
~testMelPatterns.value(~createMelPatterns.value,60);
);

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


20.10.rand2;
rrand(24, 48)

 Quarks.gui 