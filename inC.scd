/*******************************************************************************************
               In C - Phase one implementation, a minimal working prototype
********************************************************************************************/


/* A minimal test with:
- all 53 melodic patterns
- 5 identical instruments
- no transposition
*/


/**************************************************
*** 0 - Executing instructions                    *
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
      Performance length in minutes cannot be shorter than
      scoreLength/tempo, that is 260/tempo. For reference,
      at the original tempo if 63bpm of the original perfomance,
      the minimum performance length is 263/63 = 4.17 minutes.

   6. Create the performance with (for instance):
      ~perf = ~createPerformance(players, length , tempo , ~createMelPatterns)

   7. Execute the performance with:
      ~execPerf = ~executePerformance(~perf);

   8. Stop the performance with
     ~ ~execPerf.stop;

*/




/**************************************************
*** 1-A Setting up the score and the instruments  *
***************************************************/


(
~createMelPatterns = {
	// Create all the 53 melodic patterns in Riley's "In C"
	// Return a vector of dictionaries, one per pattern
    // Pitches are expressed as integers starting from 0, representing scale degrees.
    //
    //          Notice that sharps are represented as .1 and flats as .9,
    //          e.g C# = 0.1, while Db = 0.9. See the Literals doc page for details
    //
    // Durations are expressed as fractions of a beat, or more precisely as a fraction of a quarter note.
    // TODO: Conversion of durations from beats to millisecond must be carried out
    //       when the score is created

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
        Dictionary.newFrom([\pitches,[Rest(),Rest(),Rest(),Rest(),0,0,0,Rest(),Rest(),Rest(),Rest(),Rest()],
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


//////////////// Score tests ///////////////////////////////////////

//Testing:
// - all patterns should have equal number of pitches and durations
// - there shoud be 53 patterns
// - total duration should be equal to 260

(var a = ~createMelPatterns.value, scoreSize;
['Patterns in score --> ', a.size].postln;
a.do({|item i| [i+1, "-> ", '# of pitches == # of durations?', (item[\pitches].size == item[\durs].size), 'total beats-->',item[\durs].sum,item[\pitches],item[\durs]].postln;});
scoreSize = a.collect({|cell| cell[\durs]}).flatten.sum;
["score size is equal to 260? ", scoreSize == 260, "--> ", scoreSize].postln;
)
////////////////////////////

a = ~createMelPatterns.value; a.(\pitches).flatten;

 // Auditory testing:
 // Play each pattern once, wait a second in between
(
~testMelPatterns = {
//	| tempo |
	// Play all melodic patterns in sequence at tempo, with a little rest in between
	// Use fork passed to a routine (indicated with {} ) to pause between Pbinds
	var patterns = ~createMelPatterns.value;
    var tempo = 60;
    {
		patterns.do({ |item i|
             [i+1, " --> ", item[\pitches]].postln;
            (Pbind(\degree, Pseq(item.[\pitches],1),
                   \octave, 5,                       // middle C octave
                   \dur,   Pseq(item[\durs],1)).play;
            5.wait;)})
	    }.fork(TempoClock(tempo/60));
       }.value
)

(
~testMelPatterns = {
//	| tempo |
	// Play all melodic patterns in sequence at tempo, with a little rest in between
	// Use fork passed to a routine (indicated with {} ) to pause between Pbinds
	var patterns = ~createMelPatterns.value;
    var tempo = 100;
    {
		patterns.do({ |item i|
             [i+1, " --> ", item[\pitches]].postln;
            (Pbind(\degree, Pseq(item.[\pitches],1),
                   \octave, 5,                       // middle C octave
                   \dur,   Pseq(item[\durs],1)).play;
            5.wait;)})
	    }.fork(TempoClock(tempo/60));
       }.value
)


// Test a specific cell

(
~testSingleCell = {
    //Decrements the argument by one  to let the user
    //refer to pattern numbers as 1 to 53
    // Use legato
    |cellNo=0, octave=5 |
    var cell, patterns = ~createMelPatterns.value, tempo = 60;

    if ((cellNo>patterns.size).or(cellNo < 0))
              {"Required cell number is not present in the score".postln;}
              {cellNo = cellNo - 1;
              cell = patterns[cellNo];
              Pbind(\degree, Pseq(cell[\pitches],1),
                    \octave, octave,
                    \dur, Pseq(cell[\durs], 1),
                    \legato, 1).play}}
)
// example
(~testSingleCell.(24)
);




// Test cells via MIDI
//
// Use external instruments loaded in a plugin host.
// Need to make sure host is already initialized externally with proper instruments
// AND supercollider's' MIDI connection to host is established externally
// with patch manager (qpwgraph, helvum, or similar).
// Notice that this arrangement is Linux-specific

// Remember to run
MIDIClient.init;
//and to connect the output to the synth input (Kontakt, most likely in qpwgraph)

// Test a specific cell via MIDI
// Use legato
// Change tempo outside of the Pbind
(
~testSingleCellMIDI = {
    |cellNo=1, channel=0, amp = 0.3 |
    var mOut, cell, patterns, tempo = 100;
    patterns = ~createMelPatterns.value;
    mOut = MIDIOut(0).latency_(Server.default.latency);
    if ((cellNo>patterns.size).or(cellNo < 0))
              {"Required cell number is not present in the score".postln;}
              {cellNo = cellNo - 1;
              cell = patterns[cellNo];
              Pbind(
              \type, \midi,
              \amp, amp,
              \midicmd, \noteOn,
              \midiout, mOut,
              \chan, channel,
              // degree is converted to midinote, not just frequency
              \degree,  Pseq(cell[\pitches],1),
              \dur, Pseq(cell[\durs], 1),
              \tempo,tempo/60, // Beats per second
              \legato, 1,      // Full length of the notes
              ).play;//(quant: 1);
              }
            }
)

~testSingleCellMIDI.value(8, 2);
// Test all cells via MIDI

(
~testMelPatternsMIDI = {
//	| tempo |
	// Play all melodic patterns in sequence at tempo via MIDI, with a little rest in between
	// Use fork passed to a routine (indicated with {} ) to pause between Pbinds
	| channel = 0, amp = 0.3, octave=5 |
    var mOut, patterns = ~createMelPatterns.value;
    var tempo = 100;
    mOut = MIDIOut(0).latency_(Server.default.latency);
      {
		patterns.do({ |item i|
             [i+1, " --> ", item[\pitches]].postln;
            (Pbind(
                   \type , \midi,
                   \amp, amp,
                   \midimd, \noteOn,
                   \midiout, mOut,
                   \degree, Pseq(item.[\pitches],1),
                   \octave, octave,                       // middle C octave = 5
                   \dur,   Pseq(item[\durs],1)).play;
            5.wait;)})
	    }.fork(TempoClock(tempo/60));
}.value;
)

(
~p = ~testMelPatternsMIDI.value;
)

/**********************************************
*** 1-B Setting up the instruments
***********************************************/
(
// Set up a global variable holding the parameters
// for the different instument to use.
// NOTICE: the \channel parameter indicates a MIDI
//         channel, and the external synth must be
//         set up accordingly
//
// NOTICE ALSO: Only 16 instruments max per MIDI instance,
//              a bigger orchestra requires two external
//              synth instances.
// AND ALSO: the \range parameter indicates the number of
//           octaves from C4 is the lowest C the instrument can play.
//           So, the cello, for instance, has a range of -2,
//           and the double bass has also \range = -2, even though
//           its lowest note is E1.


~createInstruments = {
    var instrument, instruments;
    instruments = Dictionary.new();
    // Piano
    instrument = Dictionary.new();
    instrument[\channel]= 0;
    instrument[\range]= 0;  // Of course
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\piano]= instrument;

    // Flute
    instrument = Dictionary.new();
    instrument[\channel]= 1;
    instrument[\range]= 0;
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\piano]= instrument;

    // Alto sax
    instrument = Dictionary.new();
    instrument[\channel]= 2;
    instrument[\range]= 0;  // Lowest note is Eb3
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\altoSax]= instrument;

    // Tenor Sax
    instrument = Dictionary.new();
    instrument[\channel]= 3;
    instrument[\range]= -1;   // Lowest note Ab3
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\tenSax]= instrument;

    // Cello
    instrument = Dictionary.new();
    instrument[\channel]= 4;
    instrument[\range]= -2;   // Lowest note C2
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\cello]= instrument;

    // Viola
    instrument = Dictionary.new();
    instrument[\channel]= 5;
    instrument[\range]= -1; // Lowest note is C3
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\viola]= instrument;

    // Acoustic (upright or double) bass
    instrument = Dictionary.new();
    instrument[\channel]= 6;
    instrument[\range]= -2;       // Lowest note E1
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\bass]= instrument;

    // Guitar
    instrument = Dictionary.new();
    instrument[\channel]= 7;
    instrument[\range]= -1;   // Lowest note E2
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\guitar]= instrument;

    // Bass clarinet
    instrument = Dictionary.new();
    instrument[\channel]= 8;
    instrument[\range]= 0;
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\bassClarinet]= instrument;

    // Bb Clarinet
    instrument = Dictionary.new();
    instrument[\channel]= 9;
    instrument[\range]= -2;   // Lowest note is Bb1
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\clarinet]= instrument;

    // Tenor Recorder
    instrument = Dictionary.new();
    instrument[\channel]= 10;
    instrument[\range]= 0;  //Lowest note is C4
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\tenRecorder]= instrument;

    // Alto Recorder
    instrument = Dictionary.new();
    instrument[\channel]= 11;
    instrument[\range]= 1;   // Lowest note is F4
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\altoRec]= instrument;

    // Soprano Recorder
    instrument = Dictionary.new();
    instrument[\channel]= 12;
    instrument[\range]= 1;   // Lowest note is C5
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\sopRecorder]= instrument;

    // Sopranino Recorder
    instrument = Dictionary.new();
    instrument[\channel]= 13;
    instrument[\range]= 3 ;   // Lowest note is F5
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\sopraninRecorder]= instrument;

    //
    // // Oboe
    // instrument = Dictionary.new();
    // instrument[\channel]= 14;
    // instrument[\range]= -1;    // Lowest note B3
    // instrument[\legato] =  1;
    // instrument[\pan] = 0; // for now --> all centered
    // instruments[\oboe]= instrument;

    // Trumpet
    instrument = Dictionary.new();
    instrument[\channel]= 14;
    instrument[\range]= 0;   // Lowest note is F#4
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\trumpet]= instrument;

    // Organ
    instrument = Dictionary.new();
    instrument[\channel]= 15;
    instrument[\range]= 0;   // of course
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\organ]= instrument;

/*
    // Trombone
    instrument = Dictionary.new();
    instrument[\channel]= 0;
    instrument[\range]= -1;   // Lowest note is E2
    instrument[\legato] =  1;
    instrument[\pan] = 0; // for now --> all centered
    instruments[\trombone]= instrument;*/
}
)
~createInstruments.value.inspect

/***********************************************
*** 1-C Setting up a performance's parameters  *
************************************************/

// 1-C-1 Setting up general performance parameters

(
~createPerformance = {
  /* - Setup performance parameters: performance length, tempo, number of players, instruments
  // - Also setup environment (initialize Midi connections, setup midi ports, etc.)
  // Return a dictionary with tempo, playersNum, performLength, basicScore, and an array of players
  //
  // Parameters
  // - instruments:  an Array of symbols selecting the instruments that will be used by the
  //                 players.
  // - length in minutes (Riley's instructions say 45 to 90', but we default to 15')
  // - tempo (In standard bpm. Riley is rather vague about tempo)
  // - patternsFunction is a function that creates the vector of melodic cells.
        It the only parameters that does not have a default and must always be passed.
        It will eventually be replaced with a proper method to the MelodicCells class
  */
    |players, performLength = 15, tempo = 100, patternsFunction |
    var performance = Dictionary.new, players = Array.new;
    //patternsFunction.postln;
    if (patternsFunction.isNil, {"Error: Performance needs a vector of melody cells to be instantiated".postln});

    //an empty instruments argument picks the default instruments (a 5 elements array of MDPianos
    if (players.isNil,
        {players = ~defaultInstruments.value()});
    players.size.postln;
    performance[\tempo]=tempo;
    performance[\playersNum]=players.size;
    performance[\performLength]=performLength;
    performance[\basicScore]=patternsFunction.value;
//////////
////////// TODO!!!!
/////////
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
// testing,
// REMEMBER to evaluate the ~defaultInstruments and ~createPlayerScoreInAdvance functions first
(
var p;
p=~createPerformance.value(performLength:15, patternsFunction:~createMelPatterns);
p(\players).size.postln;
p(\players).do({|item i|item[\score][\pitches].size.postln});
p.inspect
)
/*********************************
*** 1-D Creating the players *
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
~computeCellReps = {
        /*
         Compute the (approx.) number of repetitions a single cell needs
         (based on the ratio between single cell and score)
         and the desired total length at a given tempo.

         Care need to be taken in choosing the combination of tempo and performance length
         to avoid impossible computations (e.g. tempo of 60bpm and performance length of 2 minutes).
         For reference, at 60 bpm, a performance with NO reps takes 260 seconds and in general,
         the minimum performance length IN MINUTES (no reps), should not be lower than

         scoreLength / tempo

         mellCells = the array of melodic cells
         cell = a single cell from the array
         tempo = the desired tempo in BPM
         perfLength = the desired total length of the performance in MINUTES
        */
    |melCells cell tempo perfLength|
    var avgReps, reps, scoreLength, totalBeatLength, minMaxAdd;
    scoreLength = melCells.collect({|cell| cell[\durs]}).flatten.sum;
    totalBeatLength = perfLength * tempo;                   // performance length in beats
    avgReps = totalBeatLength / scoreLength;                // average repetition  per cell
    minMaxAdd =  (avgReps).rand - (avgReps/2);              //compute a random factor to add to the avg
    reps = (avgReps + minMaxAdd).floor;
    // testing
    // [avgReps.floor, "  ", reps].postln;
    // reps;
};
)


(
//testing
var melCells = ~createMelPatterns.value();
var scoreLength; //in beats
var temp;
scoreLength= melCells.collect({|cell| cell[\durs]}).collect({|item| item.sum()}).sum;

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

    var actualScore, player=Dictionary.new, score, pitches=List.new(), durs=List.new();
    player[\score]=Dictionary.newFrom([\pitches,pitches,\durs, durs]); // Holder for a flattened representation of the complete score as [\pitches,\durs]. Starts with 2 empty lists
    //score = melCells;
    melCells.do({
        |item i|
        var reps, cell, pitches, durs;
        cell = Dictionary.new;
        reps = ~computeCellReps.value(melCells:melCells,cell:item, tempo:tempo, perfLength:perfLength);
        // we may want to add some more stuff here in the future,
        // such as likelihood of octave jumps, slight push/drag, etc.
        //
        //Multiply the cell's pitches and durs by a random number of reps
        //and add them to the player's actual score array
        [i, item[\durs].flatten.sum,reps].postln;
        reps = rrand(reps-1,reps+1);  //may have to change to account for cell's length
        player[\score][\pitches].addAll(item[\pitches].dup(reps).flatten);
        player[\score][\durs].addAll(item[\durs].dup(reps).flatten);
        });
        //testing
        player[\score][\pitches].size.postln;
        player[\score][\durs].size.postln;
        // shouldImplement (instrument selection not implemented yet)
        player[\instrument]=0;
    };
)

// Testing
(
// A dummy instrument
~pippo = ~createPlayerScoreInAdvance.value(melCells:~createMelPatterns.value,
                                           perfLength:15,
                                           tempo:100,
                                           instrument:0);
// ~pippo.inspect
)

// testing on external MIDI
// Plays the complete score of an instrument of a selected MIDI channel
// Will need to adjust octave to fit instrument's range
(
~testInstrumentMIDI = {
    |instrument, cellNo=0, channel=0, amp = 0.3, mtranspose = 0 |
    var pitches, durs;
    pitches = instrument[\score][\pitches];
    durs = instrument[\score][\durs];
    if (instrument.notNil) {
        var mOut, cell, patterns = ~createMelPatterns.value, tempo = 60;
        mOut = MIDIOut(0).latency_(Server.default.latency);
        Pbind(
              \type, \midi,
              \amp, amp,
              \midicmd, \noteOn,
              \midiout, mOut,
              \chan, channel,
              // degree is converted to midinote, not just frequency
              \degree,  Pseq(pitches,1),
              \mtranspose, mtranspose,
              \dur, Pseq(durs, 1),
              \legato, 1,
              \tempo, 100/60
              ).play;//(quant: 1);
        }
        {"Cannot play without an instrument".postln;}
    }
)
(
//var instr = ~createPlayerScoreInAdvance.value();
p = ~testInstrumentMIDI.value(~pippo);
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
//testing individualized scores creation
a = ~createMelPatterns.value;
b = ~createPlayerScoreInAdvance.value(melCells:a, perfLength:35, tempo:100, instrument:nil);
b.class.postln;
b[\score][\pitches].size.postln;
b[\score][\durs].size.postln;
)


/*********************************
*** 1-E Performing the score     *
**********************************/

// 1-E-1 Setup
// 1-E-11 General setup if needed (SynthDef definition, Midi connections, etc)
// 1-E-12 Create the performance (with 0 instruments, will default to 5, performLength = 5, tempo = 120, patternsFunction )
   ~perf = p=~createPerformance.value(patternsFunction:~createMelPatterns);

// 1-E-2 Execute the performance

/////////////////////////////
///////  TO DO !!! //////////
/////////////////////////////


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
*** 1-F  Helper functions and code snippets     *
*************************************************/



/**********************************************************************************************************
**********************************************************************************************************
* Scratch*/
*/

(
~scratchBPS = 100; // perf tempo
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

/*
 The following (simplified) example from the docs works fine (assuming Midi Through is connected to an actual synth,
 I used fluidsynth to test).
 TODO: Not clear how to connect to other midi in ports, though. Check the destination (after init) with:
 MIDIClient.destinations;
*/

MIDIClient.init;    // if not already done
~mOut = MIDIOut(0).latency_(Server.default.latency);

(
// substitute your own device here
//var    mOut = MIDIOut.newByName("Midi Through", "Midi Through   Port-0").latency_(Server.default.latency);

p = Pbind(
    \type, \midi,
    // this line is optional b/c noteOn is the default
    // just making it explicit here
    \amp, 0.3,
    \midicmd, \noteOn,
    \midiout, ~mOut,    // must provide the MIDI target here
    \chan, 0,
    // degree is converted to midinote, not just frequency
    \degree, Pseq([1,3,5,8],1),
    \dur, Pseq([1,1,1,1], inf),
).play(quant: 1);
)

p.stop;
*/
