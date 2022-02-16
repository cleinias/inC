##  In C

### Project description
A SuperCollider rendition of Terry Riley's In C that follows Riley's score instructions as closely as possible

This is a self-education project aimed at improving my familiarity with classic minimalism
and with SuperCollider (and especially its pattern language).

A few iterations are planned. Phase 1 is a minimal working prototype, successive phases add more complexity.

### Basic elements of Riley's score, as per his own instructions:

1.  53 melodic patterns
2.  Patterns are to be played consecutively with each
    performer having the freedom to determine how many times
    he or she will repeat each pattern before moving on to the next.
3.  To keep the performance between 45 min and an hour eache pattern
    should be repeated between 45 seconds and a minute and a half (45''-90'')
    or longer.
4.  A group of about 35 instrumentalists is desired but smaller
    or larger groups can work too.
5.  Any instrument can play.
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
10. Tempo is left to the discretion of the performers, not too slow.
11. It is OK to transpose patterns by an octave, especially to transpose up.
12. Transposing down by octaves works best on the patterns
    containing notes of long durations.
13. Augmentation of rhythmic values can also be effective.
14. In C is ended in this way: when each performer arrives at figure #53,
    he or she stays on it until the entire ensemble has arrived there.
15. The group then makes a large crescendo and diminuendo a few times
    and each player drops out as he or she wishes.


## Phases
The project is planned to proceed through several stages of increasing complexity, provisionally summarized as follows (see below for further details on the single phases):

1. Phase 1: Minimal working prototype:
2. Phase 2 - Refactor into classes
3. Phase 3 - Add complete scores and full instrument set
4. Phase 4 - Add Riley's additional (and not so additional) options:
	- Pulse instrument
	- Improvised percussions
	- Ending with repeat crescendo and diminuendo and instruments' randomly dropping off
5. Phase 5 - Add some spatialization
6. Phase 6 - Explore live performance interaction with algorithm
7. Phase 7 - Add minimal GUI to control performance at run time


## 0 - General setup


All data and algorithms of In C are contained in three main objects:

- MelodicPatterns
  The repository of melody cells

- Performance
  Contains parameters about number of players, duration, and tempo (for now)

- Players
  Data about the players, including their scores and instruments


In the first test, the three main objects are represented by environment variables, later phases may refactor to classes.


## 1 - Phase 1 description

The three main objects are represented by environment variables:

    - ~melPatterns
    - ~performance
    - ~player


### Performance
Performance is the main object. It has:

 - an instance of melodic patterns (melPatterns)
 - a set of performance parameters
 - a collection of players instantiated on the basis of the performance parameters
 - an actual score generated on the basis of performance parameters (possibly. See notes on payesr below)

The performance is executed by compiling all the functions in inC-1.scd and then evaluating the following:

```
// playersNum:  --> desired numebr of instrumetns (will be created randomly)
// performLength: --> desired length in minutes
// patternsFunction: --> the function generating the patterns (only ~createMelPatterns is provided in the prototype)
```

p=~createPerformance.value(playersNum: anInteger, performLength:aFloat, patternsFunction:~createMelPatterns);
q=~executePerformance.value(p);

performance is stopped in standard SuperCollider fashion with

```
q.stop;
```

### 1-A creating the patterns *

- Patterns are coded as a dictionary of two vectors, containing,
  respectively, pitches and durations
  (we are using dictionary to leave open the possibility of adding more features later)
- The pattern dictionaries are then stored in a vector containing all the melodic patterns (~melCells)
- Pitches are specified in degrees and expressed in integers
  (with a caveat: if 0 is C4, and 1 is D4, C# is 0.1, not 0.5, and Db is 0.9. See the Literals doc page for details)
- Durations are indicated in fractions of a beat


