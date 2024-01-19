/**
 * This file is part of the Calculatrice Salaire Net TangoMan package.
 *
 * (c) Matthias Morin <mat@tangoman.io>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

/**
 * Compute weekly base hours
 */
export default class Hours {
    /**
     * annual hour base
     * @type {Number}
     */
    per_year = 1820;

    /**
     * monthly hour base
     * @type {Number}
     */
    per_month = 151.67;

    /**
     * weekly hour base
     * @type {Number}
     */
    per_week = 35;

    /**
     * daily hour base
     * @type {Number}
     */
    per_day = 7;

    /**
     * constructor
     * @param  {number} weekly_hour_base Weekly hour base
     */
    constructor(weekly_hour_base) {
        this.set_weekly_hour_base(weekly_hour_base)
    }

    /**
     * set weekly hour base
     * - per_day   = / 5 days a week
     * - per_month = x 52 weeks per year / 12 months
     * - per_year  = x 52 weeks
     * @param  {number} hours Hours per week
     * @return {Calc}
     */
    set_weekly_hour_base(weekly_hour_base) {
        this.per_day   = Number(weekly_hour_base / 5);
        this.per_week  = Number(weekly_hour_base);
        /* toFixed return a string */
        this.per_month = Number((weekly_hour_base * 52 / 12).toFixed(2));
        this.per_year  = Number(weekly_hour_base * 52);

        return this
    }
}
