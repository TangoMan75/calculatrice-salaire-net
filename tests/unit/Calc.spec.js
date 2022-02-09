/**
 * This file is part of the Calculatrice Salaire Net TangoMan package.
 *
 * (c) Matthias Morin <mat@tangoman.io>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

/**
 * I personally prefer the "assert" style, reference below:
 * @url https://www.chaijs.com/api/assert/
 */
import {assert} from 'chai'
import Calc from '@/entities/Calc.js'
import Hours from '@/entities/Hours.js'
import Salary from '@/entities/Salary.js'

/**
 * helper function to format value
 * @param  {Number} value
 * @return {Number}
 */
function helper(value) {
    return Number(value.toFixed(2))
}

describe('Calc.js', () => {
    let calc = new Calc(new Hours(35), new Salary(), {"tax_rate": 22});

    it('set_hourly_gross updates salary and employer contributions', () => {
        calc.set_hourly_gross(10.03);
        assert.equal(helper(calc.salary.annual_gross), 18254.60);
        assert.equal(helper(calc.salary.monthly_gross), 1521.25);
        assert.equal(helper(calc.salary.daily_gross), 70.21);
        assert.equal(helper(calc.salary.hourly_gross), 10.03);
        assert.equal(helper(calc.salary.annual_net), 14238.59);
        assert.equal(helper(calc.salary.monthly_net), 1186.58);
        assert.equal(helper(calc.salary.daily_net), 54.76);
        assert.equal(helper(calc.salary.hourly_net), 7.82);
        assert.equal(helper(calc.salary.employer_contributions), 7666.93);
        assert.equal(helper(calc.salary.total_cost), 25921.53)
    });

    it('set_hourly_net updates salary and employer contributions', () => {
        calc.set_hourly_net(10);
        assert.equal(helper(calc.salary.annual_gross), 23333.33);
        assert.equal(helper(calc.salary.monthly_gross), 1944.49);
        assert.equal(helper(calc.salary.daily_gross), 89.74);
        assert.equal(helper(calc.salary.hourly_gross), 12.82);
        assert.equal(helper(calc.salary.annual_net), 18200);
        assert.equal(helper(calc.salary.monthly_net), 1516.70);
        assert.equal(helper(calc.salary.daily_net), 70);
        assert.equal(helper(calc.salary.hourly_net), 10);
        assert.equal(helper(calc.salary.employer_contributions), 9800);
        assert.equal(helper(calc.salary.total_cost), 33133.33)
    });

    it('set_daily_gross updates salary and employer contributions', () => {
        calc.set_daily_gross(100);
        assert.equal(helper(calc.salary.annual_gross), 36500);
        assert.equal(helper(calc.salary.monthly_gross), 2000);
        assert.equal(helper(calc.salary.daily_gross), 100);
        assert.equal(helper(calc.salary.hourly_gross), 14.29);
        assert.equal(helper(calc.salary.annual_net), 28470);
        assert.equal(helper(calc.salary.monthly_net), 1560);
        assert.equal(helper(calc.salary.daily_net), 78);
        assert.equal(helper(calc.salary.hourly_net), 11.14);
        assert.equal(helper(calc.salary.employer_contributions), 15330);
        assert.equal(helper(calc.salary.total_cost), 51830)
    });

    it('set_daily_net updates salary and employer contributions', () => {
        calc.set_daily_net(100);
        assert.equal(helper(calc.salary.annual_gross), 46794.87);
        assert.equal(helper(calc.salary.monthly_gross), 2564.10);
        assert.equal(helper(calc.salary.daily_gross), 128.21);
        assert.equal(helper(calc.salary.hourly_gross), 18.32);
        assert.equal(helper(calc.salary.annual_net), 36500);
        assert.equal(helper(calc.salary.monthly_net), 2000);
        assert.equal(helper(calc.salary.daily_net), 100);
        assert.equal(helper(calc.salary.hourly_net), 14.29);
        assert.equal(helper(calc.salary.employer_contributions), 19653.85);
        assert.equal(helper(calc.salary.total_cost), 66448.72)
    });

    it('set_monthly_gross updates salary and employer contributions', () => {
        calc.set_monthly_gross(2500);
        assert.equal(helper(calc.salary.annual_gross), 30000);
        assert.equal(helper(calc.salary.monthly_gross), 2500);
        assert.equal(helper(calc.salary.daily_gross), 125);
        assert.equal(helper(calc.salary.hourly_gross), 16.48);
        assert.equal(helper(calc.salary.annual_net), 23400);
        assert.equal(helper(calc.salary.monthly_net), 1950);
        assert.equal(helper(calc.salary.daily_net), 97.50);
        assert.equal(helper(calc.salary.hourly_net), 12.86);
        assert.equal(helper(calc.salary.employer_contributions), 12600);
        assert.equal(helper(calc.salary.total_cost), 42600)
    });

    it('set_monthly_net updates salary and employer contributions', () => {
        calc.set_monthly_net(2500);
        assert.equal(helper(calc.salary.annual_gross), 38461.54);
        assert.equal(helper(calc.salary.monthly_gross), 3205.13);
        assert.equal(helper(calc.salary.daily_gross), 160.26);
        assert.equal(helper(calc.salary.hourly_gross), 21.13);
        assert.equal(helper(calc.salary.annual_net), 30000);
        assert.equal(helper(calc.salary.monthly_net), 2500);
        assert.equal(helper(calc.salary.daily_net), 125);
        assert.equal(helper(calc.salary.hourly_net), 16.48);
        assert.equal(helper(calc.salary.employer_contributions), 16153.85);
        assert.equal(helper(calc.salary.total_cost), 54615.38)
    });

    it('set_annual_gross updates salary and employer contributions', () => {
        calc.set_annual_gross(40000);
        assert.equal(helper(calc.salary.annual_gross), 40000);
        assert.equal(helper(calc.salary.monthly_gross), 3333.33);
        assert.equal(helper(calc.salary.daily_gross), 109.59);
        assert.equal(helper(calc.salary.hourly_gross), 21.98);
        assert.equal(helper(calc.salary.annual_net), 31200);
        assert.equal(helper(calc.salary.monthly_net), 2600);
        assert.equal(helper(calc.salary.daily_net), 85.48);
        assert.equal(helper(calc.salary.hourly_net), 17.14);
        assert.equal(helper(calc.salary.employer_contributions), 16800);
        assert.equal(helper(calc.salary.total_cost), 56800)
    });

    it('set_annual_net updates salary and employer contributions', () => {
        calc.set_annual_net(40000);
        assert.equal(helper(calc.salary.annual_gross), 51282.05);
        assert.equal(helper(calc.salary.monthly_gross), 4273.50);
        assert.equal(helper(calc.salary.daily_gross), 140.50);
        assert.equal(helper(calc.salary.hourly_gross), 28.18);
        assert.equal(helper(calc.salary.annual_net), 40000);
        assert.equal(helper(calc.salary.monthly_net), 3333.33);
        assert.equal(helper(calc.salary.daily_net), 109.59);
        assert.equal(helper(calc.salary.hourly_net), 21.98);
        assert.equal(helper(calc.salary.employer_contributions), 21538.46);
        assert.equal(helper(calc.salary.total_cost), 72820.51)
    });

    it('set_total_cost updates whole table', () => {
        calc.set_total_cost(142000);
        assert.equal(helper(calc.salary.annual_gross), 100000);
        assert.equal(helper(calc.salary.monthly_gross), 8333.33);
        assert.equal(helper(calc.salary.daily_gross), 273.97);
        assert.equal(helper(calc.salary.hourly_gross), 54.95);
        assert.equal(helper(calc.salary.annual_net), 78000);
        assert.equal(helper(calc.salary.monthly_net), 6500);
        assert.equal(helper(calc.salary.daily_net), 213.7);
        assert.equal(helper(calc.salary.hourly_net), 42.86);
        assert.equal(helper(calc.salary.employer_contributions), 42000);
        assert.equal(helper(calc.salary.total_cost), 142000)
    });

    it('set_status updates status, tax_rate, and net salary', () => {
        calc.set_annual_gross(40000);
        calc.set_status({"tax_rate": 25});
        assert.isObject(calc.status);
        assert.equal(calc.tax_rate, 25);
        assert.equal(helper(calc.salary.annual_gross), 40000);
        assert.equal(helper(calc.salary.monthly_gross), 3333.33);
        assert.equal(helper(calc.salary.daily_gross), 109.59);
        assert.equal(helper(calc.salary.hourly_gross), 21.98);
        assert.equal(helper(calc.salary.annual_net), 30000);
        assert.equal(helper(calc.salary.monthly_net), 2500);
        assert.equal(helper(calc.salary.daily_net), 82.19);
        assert.equal(helper(calc.salary.hourly_net), 16.48);
        assert.equal(helper(calc.salary.employer_contributions), 16800);
        assert.equal(helper(calc.salary.total_cost), 56800)
    });

    it('set_tax_rate updates tax_rate, and net salary', () => {
        calc.set_tax_rate(22);
        assert.equal(helper(calc.salary.annual_gross), 40000);
        assert.equal(helper(calc.salary.monthly_gross), 3333.33);
        assert.equal(helper(calc.salary.daily_gross), 109.59);
        assert.equal(helper(calc.salary.hourly_gross), 21.98);
        assert.equal(helper(calc.salary.annual_net), 31200);
        assert.equal(helper(calc.salary.monthly_net), 2600);
        assert.equal(helper(calc.salary.daily_net), 85.48);
        assert.equal(helper(calc.salary.hourly_net), 17.14);
        assert.equal(helper(calc.salary.employer_contributions), 16800);
        assert.equal(helper(calc.salary.total_cost), 56800)
    })
});

