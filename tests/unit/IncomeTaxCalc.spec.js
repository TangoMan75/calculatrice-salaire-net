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
import IncomeTaxCalc from '@/entities/IncomeTaxCalc.js'

describe('IncomeTaxCalc.js', () => {
    let income_tax_calculator = new IncomeTaxCalc();

    let low_income = 10063
    let net_income_1 = 10065
    let net_income_2 = 25660
    let net_income_3 = 73370
    let net_income_4 = 157807

    let tax_rate_1 = 11;
    let tax_rate_2 = 30;
    let tax_rate_3 = 41;
    let tax_rate_4 = 45;

    it('returns correct income tax rate for low income', () => {
        assert.equal(income_tax_calculator.get_tax_rate(low_income), 0)
    })

    it('returns correct income tax rate for first bracket', () => {
        assert.equal(income_tax_calculator.get_tax_rate(net_income_1), tax_rate_1)
    })

    it('returns correct income tax rate for second bracket', () => {
        assert.equal(income_tax_calculator.get_tax_rate(net_income_2), tax_rate_2)
    })

    it('returns correct income tax rate for bracket n°3', () => {
        assert.equal(income_tax_calculator.get_tax_rate(net_income_3), tax_rate_3)
    })

    it('returns correct income tax rate for bracket n°4', () => {
        assert.equal(income_tax_calculator.get_tax_rate(net_income_4), tax_rate_4)
    })
});

