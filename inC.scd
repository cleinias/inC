/*   In C

A SuperCollider rendition of Terry Riley's In C that follows Riley's score instructions as closely as possible
*/

/* Basic elements of Riley's score, as per his own instructions:

1.  53 melodic patterns
2.  Patterns are to be played consecutively with each
    performer having the freedom to determine how many times
    he or she will repeat each pattern before moving on to the next.
3.  To keep the performance between 45 min and an hour eache pattern
    should be repeated between 45 seconds and a minute and a half or longer
4.  A group of about 35 instrumentalists is desired but smaller
    or larger groups can work too.
5.  Any instrument can play
6.  Each pattern can be played in unison or canonically
    in any alignment with itself or with its neighboring patterns.
7.  As the performance progresses, performers should stay
    within 2 or 3 patterns of each other. It is important not
    to race too far ahead or to lag too far behind.
8.  The ensemble can be aided by the means of an eighth note pulse
    played on the high C’s of the piano or on a mallet instrument.
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
*** 0 - General setup         *
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
*/  z=Dictionary.newFR

(
~createMelPatterns = {
	// Create all the 53 melodic patterns in Riley's "In C"
	// Return a vector of dictionaries, one per pattern

	var melCells;
    melCells= [
    //1-10
    //Acciaccatura to a quarter note rendered as 1/32 note (1/8 of a beat):
    Dictionary.newFrom([\pitches, [1,3,1,3,1,3],\durs, [0.125, 0.875, 0.125, 0.875, 0.125, 0.875]]),
    //Acciaccatura to an eighth note rendered as 1/64 note (1/16 of a beat):
    Dictionary.newFrom([\pitches, [1,3,4,3],\durs, [0.0625, 0.9375, 0.5, 1]]),
    Dictionary.newFrom([\pitches, [Rest(),3,4,3],\durs, [0.5, 0.5 , 0.5, 0.5,0.5]]),   // pattern starts with a rest
    Dictionary.newFrom([\pitches,[Rest(),3,4,5],\durs,[0.5,0.5,0.5,]]),
    Dictionary.newFrom([\pitches,[3,4,5,Rest()],\durs,[0.5,0.5,0.5,0.5]]),
    Dictionary.newFrom([\pitches,[8,8],\durs,[4,4]]),
        Dictionary.newFrom([\pitches,[Rest(),Rest(),Rest(),Rest(),1,1,1,Rest(),Rest(),Rest(),Rest(),Rest],\durs,[1,1,1,0.5,0.5,0.5,0.5,0.5,1,1,1,1]]),
    Dictionary.newFrom([\pitches,[5,4,4],\durs,[4,4,4]]),
Dictionary.newFrom([\pitches,[7,5,Rest(),Rest(),Rest(),Rest()],\durs,[0.25,0.25,0.5,1,1,1]]),
Dictionary.newFrom([\pitches,[7,5],\durs,[0.25,0.25]])
    ];
    //11-20
    // m11=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m12=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m13=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m14=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m15=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m16=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m17=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m18=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m19=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m20=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m21=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m22=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m23=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m24=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m25=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m26=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m27=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m28=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m29=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m30=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m31=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m32=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m33=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m34=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m35=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m36=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m37=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m38=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m39=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m40=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m41=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m42=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m43=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m44=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m45=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m46=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m47=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m48=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m49=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m50=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m51=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m52=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // m53=Dictionary.newFrom([\pitches,[]],\drus,[]);
    // ]
// Vector with all melodic patterns
    // melCells = [m01,m02,m03];
}
)
//testing
(
a = ~createMelPatterns.value;
a.do({|item i| [i+1, "-> ",item[\pitches].size,item[\durs].size,item[\pitches],item[\durs]].postln;});
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
  // Return a dictionary with tempo, payersNum, performLength, basicScore, and an array of players
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
    var performance = Dictionary.new, players = Array.new;
    //patternsFunction.postln;
    if (patternsFunction.isNil, {"Error: Performance needs a vector of melody cells to be instantiated".postln});

    performance[\tempo]=tempo;
    performance[\playersNum]=playersNum;
    performance[\performLength]=performLength;
    performance[\basicScore]=patternsFunction.value;
    //get an array of players with individualized scores
    performance[\players]=playersNum.collect{
        |item i|
        ~createPlayerScoreInAdvance.value(performance[\basicScore], performLength, tempo, nil)};
    //return the performance object
    performance;
}
)
//testing
(
p=~createPerformance.value(playersNum: 5, performLength:5, patternsFunction:~createMelPatterns);
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

- There also different options on the actual instruments.

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
                  unless the output is redirected to Ardour via MIDI
                 (see docs: Using patterns for sending MIDI events, Pattern Guide Cookbook 4.
                            It seems all it's needed is a midi port and a midi channel)*/

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
*** 1-C Performing the score     *
**********************************/

// 1-C-1 Setup
// 1-C-11 General setup if needed (SynthDef definition, Midi connections, etc)
// 1-C-12 Create the performance (with playersNum = 2 , performLength = 5, tempo = 120, patternsFunction )
   ~perf = p=~createPerformance.value(patternsFunction:~createMelPatterns);

// 1-C-2 Execute the performance
~executePerformance = {
    /*
    Create Pbind patterns from the info about the players contained in the performance object
    */
    | performance |
    var pbins=List.new;
    pbins=performance[\players].collect({
        | item i|
        Pbind(\degree, Pseq(item[\score][\pitches]), \dur, Pseq(item[\score][\durs]));
        });
    Ppar(pbins).play;
};

//testing

(
p=~createPerformance.value(playersNum: 5, performLength:0.15, patternsFunction:~createMelPatterns);
q=~executePerformance.value(p);
// t= Ppar(q).play;
//p[\players].size.postln;
//p[\players].do({|item i|item[\score][\pitches].size.postln});
// t=q[0].play;
)
q.stop
// 1-C-3 Cleanup afterwards


/************************************************
*** 1-D  Helper functions and code snippets     *
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