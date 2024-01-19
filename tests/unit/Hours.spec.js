/**
 * This file is part of the Calculatrice Salaire Net TangoMan package.
 *
 * (c) Matthias Morin <mat@tangoman.io>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

/**
 * I personaly prefer the "assert" style, reference below:
 * @url https://www.chaijs.com/api/assert/
 */
import { assert } from 'chai'
import Hours from '@/entities/Hours.js'

describe('Hours.js', () => {
    let weekly_hour_base = 39;
    let hours = new Hours(weekly_hour_base);

    it('computes hours per year from weekly hour base', () => {
        assert.equal(hours.per_year, 2028)
    });

    it('computes hours per month from weekly hour base', () => {
        assert.equal(hours.per_month, 169)
    });

    it('computes hours per day from weekly hour base', () => {
        assert.equal(hours.per_day, 7.8)
    });

    it('checks each object property returns a number', () => {
        assert.isNumber(hours.per_year);
        assert.isNumber(hours.per_month);
        assert.isNumber(hours.per_week);
        assert.isNumber(hours.per_day)
    })
});

