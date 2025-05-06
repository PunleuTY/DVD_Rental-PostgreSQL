import { Duration } from "../model/Duration.js";
import { RaceResult } from "../model/RaceResult.js";
import fs from "fs";

/**
 * This class handles the race results management system.
 */
export class RaceResultsService {
  /**
   * The list of race results.
   * @type {Array<RaceResult>}
   * @private
   */
  _raceResults = [];

  get raceResults() {
    return this._raceResults;
  }

  /**
   * Adds a new race result to the race list.
   * @param {RaceResult} result - The race result.
   */
  addRaceResult(result) {
    this._raceResults.push(result);
  }

  /**
   * Saves the race results list to a JSON file.
   * @param {string} filePath - The path to the file where data should be saved.
   */
  saveToFile(filePath) {
    const jsonData = JSON.stringify(
      this._raceResults,
      (key, value) => {
        if (value instanceof Duration) {
          return { _totalSeconds: value._totalSeconds, __duration__: true };
        }
        return value;
      },
      2
    );

    fs.writeFileSync(filePath, jsonData, "utf8");
  }

  /**
   * Loads the race results list from a JSON file.
   * @param {string} filePath - The path to the file to load data from.
   * @returns {boolean} True if loading was successful, false otherwise.
   */
  loadFromFile(filePath) {
    try {
      const data = fs.readFileSync(filePath, "utf8");
      const parsed = JSON.parse(data);

      this._raceResults = parsed.map(
        (entry) =>
          new RaceResult(
            entry.participantId,
            entry.sport,
            new Duration(entry.duration._totalSeconds)
          )
      );
      return true;
    } catch (err) {
      console.error("Error loading race results:", err);
      return false;
    }
  }

  /**
   * Retrieves the race time for a given participant and sport.
   * @param {string} participantId - Participant ID.
   * @param {string} sport - Sport name.
   * @returns {Duration|null} Duration if found, else null.
   */
  getTimeForParticipant(participantId, sport) {
    const result = this._raceResults.find(
      (r) => r.participantId === participantId && r.sport === sport
    );
    return result ? result.duration : null;
  }

  /**
   * Computes the total time for a given participant by summing their race times.
   * @param {string} participantId - The ID of the participant.
   * @returns {Duration} The total Duration object.
   */
  getTotalTimeForParticipant(participantId) {
    const results = this._raceResults.filter(
      (r) => r.participantId === participantId
    );

    const total = results.reduce(
      (acc, curr) => acc.plus(curr.duration),
      new Duration(0)
    );
    return total;
  }
}
