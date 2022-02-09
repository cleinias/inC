/****************************************************************
*              In C - Working notes                             *
*****************************************************************/




/*

Phase 1
Minimal working prototype
  Steps                                                                 Progress

- Write general program structure as functions                          DONE
- Write patterns-generating function                                    DONE
- Write performance generating function:
      - General setup                                                   DONE
      - Create individual *randomized* scores for player                Randomization not done yet
        according to performance parameters
      - Add random cell transposition
      - Create instruments and assign to players:
        - As internal, MIDI, etc.

- Write performance executing function(s):
      - As simple as possible with internal default PBind instrument
      - Slightly more complex with different internal instruments
      - With MIDI out to synth (possibly Carla-hosted Kontakt)
      - With MIDI out to Ardour (controlled from Ardour)

*/


/*
Phase 2
Refactor into classes
*/

/*
Phase 3
Add complete scores and full instrument set
*/

/*
Phase 4
Add Riley's additional (and not so additional) options:
- Pulse instrument
- Improvised percussions
- Ending with repeat crescendo and diminuendo and instruments' randomly dropping off
*/


/*
Phase 5
Explore live performance interaction with algorithm
*/

/*
Phase 6
Add minimal GUI to control performance at run time
*/