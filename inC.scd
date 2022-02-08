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
14. IN C is ended in this way: when each performer arrives at figure #53,
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
*** 1-A creating the patterns *
*******************************

- Patterns are coded as a dictionary of two vectors, containing, respectively, pitches and durations (we are using dictionary to leave open the possibility to add more features later)
- The pattern dictionaries are then stored in a vector containing all the melodic patterns (melCells)
- Pitches are specified in degrees
- Durations are indicated in fraction of a beat
*/


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
melCells = [m01,m02,m03];
}


/****************************************************************
*** 1-B Computing the number of desired repetitions per pattern *
*****************************************************************/

/* We run over the duration vectors of each pattern  and
   - compute length in beats,
   - convert beats length to seconds on the basis of tempo
   - divide and round expected pattern min and max total lengths
   - Finally put values of min and max repetitions into each pattern's dictionary
*/

(~addRepsToCells = {
   // Compute the average number of reps per pattern (cells)
   // needed to reach desired min and max performance lengths
   // in minutes (minMaxLengths) at given tempo in bpm (perfTempo)
   // add the computed reps to the cells's dictionary'
   |cells  minMaxLengths perfTempo|
   var beatLength, secsLength, minMaxReps;
   beatLength = cells.collect({
            |item i|
            item[\durs].sum}).sum;
    secsLength = beatLength / (perfTempo/60);
    minMaxReps = [((minMaxLengths[0]*60)/secsLength).round.asInteger;,
                  ((minMaxLengths[1]*60)/secsLength).round.asInteger];
   cells.do({|item i| item.put(\reps,minMaxReps); });
    }
);
/*********************************
*** 1-C Creating the players *
**********************************/

/*

- Every player is a function containing a Pbind pattern controlled by a few parameters
- Two possible options (looking forward to full implementation):
   a - Create every player individually, and customize them one by one
   b - Instantiate a random number of players into a vector, then customize them

    I will start with the simpler option first
*/

/*
A player must:
  1. Create a score by choosing a variable number of repeats for each patterns, within the allowed limits
  2. Set up an instrument to play the created score
  3. more?
*/

/* Create the score:

*/

/*********************************
*** 1-D Performing the score     *
**********************************/

// 1-D-1 Setting up performance parameters
//TO DO:  Using global variables for now, will fix later.

(
  // - Setup performance parameters: performance length, tempo, number of players, instruments
  //Performance basic time parameters


   var performLength = [2, 3];  // Riley's instructions say 45 to 90'
   var perfTempo = 100; // In standard bpm. Riley is rather vague about tempo
   var players = 2;     // Typically 35, as per score's instructions
   ~addRepsToCells.value(~melCells, performLength,  perfTempo);


   //- Create melodic cells
   ~melCells = ~createMelPatterns.value;


   // - Create required players with associated instruments
    ~players = 2    ;
);


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
	"tempo".postln;
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
~pitches = Pseq(
	~cells.collect({
		|item i|
		var reps;
		reps = rrand(~minMax[0], ~minMax[1]);
		item ! reps;
	}).postln;
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
Pflatten(1, Pdup(Pwhite(2, 5, inf), Pseq(~cells, inf)))
.asStream.nextN(50)
)


20.10.rand2;
rrand(24, 48)