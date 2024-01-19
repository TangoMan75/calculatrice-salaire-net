/**
 * This file is part of the Calculatrice Salaire Net TangoMan package.
 *
 * (c) Matthias Morin <mat@tangoman.io>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

/**
 * Compute business days in a year
 * 365 days
 * - 11 holidays
 * - 25 paid holidays
 * - 52 weekends (104 days)
 */
export default class BusinessDays {

    /**
     * @type {Number}
     */
    days_per_year = 365;

    /**
     * @type {Number}
     */
    business_days = 225;

    /**
     * @type {Number}
     */
    holidays = 11;

    /**
     * @type {Number}
     */
    paid_holidays = 25;

    /**
     * @type {Number}
     */
    week_ends = 52;

    /**
     * constructor
     * @param  {Number} paid_holidays
     */
    constructor(paid_holidays) {
        if (paid_holidays) {
            this.paid_holidays = paid_holidays
        }

        this.getBusinessDays()
    }

    /**
     * @return {Number}
     */
    getBusinessDays() {
        this.business_days = Number(this.days_per_year - this.holidays - this.paid_holidays - (this.week_ends * 2));
        return this.business_days
    }
}
