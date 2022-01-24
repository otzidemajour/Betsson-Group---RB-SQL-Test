#for events_runners.idRunner = 51256 find events.idTrack
SELECT idTrack FROM events WHERE idEvent IN (SELECT idEvent FROM events_races WHERE idRace IN (SELECT events_runners.idRace FROM events_runners WHERE idRunner = 51256));
/*
 for events_races.idRace = 4522 display race results for events_races_final_odds.betType =
PLC in a form like:
events_runners.programNumber, events_runners.name,
events_races_final_positions.finalPosition, events_races_final_odds.odds
*IMPORTANT: in table events_races_final_odds column "combination" contains
programNumber of the horse
 */
SELECT events_runners.programNumber,
       events_runners.name,
       events_races_final_positions.finalPosition,
       events_races_final_odds.odds
FROM events_races_final_positions
    INNER JOIN events_races_final_odds
        ON events_races_final_odds.idRace = 4522
                AND events_races_final_odds.betType = 'PLC'
    INNER JOIN events_runners
        ON  events_runners.idRace = 4522
                AND events_races_final_odds.combination = events_runners.programNumber
                AND events_races_final_positions.idRunner = events_runners.idRunner;
/*
 for events.idEvent = 552 display information about every race which belong to this event if
number of runners in the race is greater than 8 in a form like:
events_races.raceNumber, "number of runners for this races in events_runners table"
 */
SELECT events_races.raceNumber,
       COUNT(events_runners.idRunner) as 'number of runners for this races in events_runners table'
FROM events_races, events_runners
WHERE
      events_races.idEvent = 552
  AND events_runners.idRace = events_races.idRace
GROUP BY events_races.idRace
HAVING 8 < COUNT(events_runners.idRunner);
/*
 for events.idEvent = 552 display the list of races (events_races) and for each race the name
of the runner with events_runners.programNumber = 11 in a form like:
events_races.raceNumber, events_runners.name
*IMPORTANT: if race doesn't contain runners with programNumber = 11 we still want to see
events_races.raceNumber in the results list (name will be empty)
 */
SELECT events_races.raceNumber,
       IFNULL(events_runners.name,'')
FROM events_races
    LEFT OUTER JOIN events_runners
        ON events_races.idRace = events_runners.idRace
               AND programNumber = 11
WHERE idEvent = 552;

/*
 for events_races.idRace = 4491 and 4522 display information about the runner with the
HIGHEST events_runners.programNumber for each idRace in a form like:
events.runners.programNumber, events_runners.name
 */

SELECT MAX(programNumber),
       name,
       idRace
FROM events_runners
WHERE idRace = 4491 OR idRace = 4522
GROUP BY idRace;
