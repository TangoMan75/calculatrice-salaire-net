/**
 * This file is part of the Calculatrice Salaire Net TangoMan package.
 *
 * (c) Matthias Morin <mat@tangoman.io>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

/**
 * Salary Data Transport Object
 */
export default class Salary {
    /**
     * annual gross salary
     * @type {Number}
     */
    annual_gross = null;

    /**
     * monthly gross salary
     * @type {Number}
     */
    monthly_gross = null;

    /**
     * gross daily wage
     * @type {Number}
     */
    daily_gross = null;

    /**
     * gross hourly wage
     * @type {Number}
     */
    hourly_gross = null;

    /**
     * annual net salary
     * @type {Number}
     */
    annual_net = null;

    /**
     * monthly net salary
     * @type {Number}
     */
    monthly_net = null;

    /**
     * net daily wage
     * @type {Number}
     */
    daily_net = null;

    /**
     * net hourly wage
     * @type {Number}
     */
    hourly_net = null;

    /**
     * employer contributions
     * @type {Number}
     */
    employer_contributions = null;

    /**
     * total cost
     * @type {Number}
     */
    total_cost = null
}
