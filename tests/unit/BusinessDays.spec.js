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
import BusinessDays from '@/entities/BusinessDays.js'

describe('BusinessDays.js', () => {
    let paid_holidays = 25;
    let business_days = new BusinessDays(paid_holidays);

    it('computes business days from paid holidays', () => {
        assert.equal(business_days.business_days, 225)
    })
});

