/**
 * This file is part of the Calculatrice Salaire Net TangoMan package.
 *
 * (c) Matthias Morin <mat@tangoman.io>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

/**
 * Calc
 */
export default class Calc {
    /**
     * Base Hours
     * @type {Object}
     */
    hours = {};

    /**
     * Salary
     * @type {Object}
     */
    salary = {};

    /**
     * Status
     * @type {Object}
     */
    status = {};

    /**
     * tax rate
     * @type {Number}
     */
    tax_rate = 22;

    /**
     * Employer contributions rate
     * @type {Number}
     */
    employer_contributions_rate = 42;

    /**
     * constructor
     * status.tax_rate updates calc.tax_rate
     * @param  {Object}  hours   Base Hours
     * @param  {Object}  salary  Salary
     * @param  {Object}  status  Employee Status
     */
    constructor(hours, salary, status) {
        this.hours = hours;
        this.salary = salary;
        this.status = status;
        this.tax_rate = Number(status.tax_rate)
    }

    /**
     * update status, tax_rate, salary and employer contributions
     * @param {Object} status
     * @param {Boolean} update
     * @return {Object}
     */
    set_status(status, update = true) {
        this.status = status;
        this.tax_rate = Number(status.tax_rate);

        this.update('net', update);

        return this
    }

    /**
     * update tax_rate and net salary
     * @param {Number} tax_rate
     * @param {Boolean} update
     * @return {Object}
     */
    set_tax_rate(tax_rate, update = true) {
        this.tax_rate = tax_rate;

        this.update('net', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} hourly_gross
     * @param  {Boolean} update
     * @return {Object}
     */
    set_hourly_gross(hourly_gross, update = true) {
        this.salary.hourly_gross = Number(hourly_gross);
        this.salary.daily_gross = Number(hourly_gross * this.hours.per_day);
        this.salary.monthly_gross = Number(hourly_gross * this.hours.per_month);
        this.salary.annual_gross = Number(hourly_gross * this.hours.per_year);

        this.update('net', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} hourly_net
     * @param  {Boolean} update
     * @return {Object}
     */
    set_hourly_net(hourly_net, update = true) {
        this.salary.hourly_net = Number(hourly_net);
        this.salary.daily_net = Number(hourly_net * this.hours.per_day);
        this.salary.monthly_net = Number(hourly_net * this.hours.per_month);
        this.salary.annual_net = Number(hourly_net * this.hours.per_year);

        this.update('gross', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} daily_gross
     * @param  {Boolean} update
     * @return {Object}
     */
    set_daily_gross(daily_gross, update = true) {
        this.salary.hourly_gross = Number(daily_gross / this.hours.per_day);
        this.salary.daily_gross = Number(daily_gross);
        this.salary.monthly_gross = Number(daily_gross * 20);
        this.salary.annual_gross = Number(daily_gross * 365);

        this.update('net', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} daily_net
     * @param  {Boolean} update
     * @return {Object}
     */
    set_daily_net(daily_net, update = true) {
        this.salary.hourly_net = Number(daily_net / this.hours.per_day);
        this.salary.daily_net = Number(daily_net);
        this.salary.monthly_net = Number(daily_net * 20);
        this.salary.annual_net = Number(daily_net * 365);

        this.update('gross', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} monthly_gross
     * @param  {Boolean} update
     * @return {Object}
     */
    set_monthly_gross(monthly_gross, update = true) {
        this.salary.hourly_gross = Number(monthly_gross / this.hours.per_month);
        this.salary.daily_gross = Number(monthly_gross / 20);
        this.salary.monthly_gross = Number(monthly_gross);
        this.salary.annual_gross = Number(monthly_gross * 12);

        this.update('net', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} monthly_net
     * @param  {Boolean} update
     * @return {Object}
     */
    set_monthly_net(monthly_net, update = true) {
        this.salary.hourly_net = Number(monthly_net / this.hours.per_month);
        this.salary.daily_net = Number(monthly_net / 20);
        this.salary.monthly_net = Number(monthly_net);
        this.salary.annual_net = Number(monthly_net * 12);

        this.update('gross', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} annual_gross
     * @param  {Boolean} update
     * @return {Object}
     */
    set_annual_gross(annual_gross, update = true) {
        this.salary.hourly_gross = Number(annual_gross / 52 / this.hours.per_week);
        this.salary.daily_gross = Number(annual_gross / 365);
        this.salary.monthly_gross = Number(annual_gross / 12);
        this.salary.annual_gross = Number(annual_gross);

        this.update('net', update);

        return this
    }

    /**
     * updates salary and employer contributions
     * @param  {Number} annual_net
     * @param  {Boolean} update
     * @return {Object}
     */
    set_annual_net(annual_net, update = true) {
        this.salary.hourly_net = Number(annual_net / 52 / this.hours.per_week);
        this.salary.daily_net = Number(annual_net / 365);
        this.salary.monthly_net = Number(annual_net / 12);
        this.salary.annual_net = Number(annual_net);

        this.update('gross', update);

        return this
    }

    /**
     * updates total cost
     * @param  {Number} total
     * @return {Object}
     */
    set_total_cost(total) {
        this.salary.total_cost = total;
        let multiplier = (1 + (this.employer_contributions_rate / 100));
        let annual_gross = Number(total / multiplier);

        this.set_annual_gross(annual_gross, false);
        this.update_employer_contributions();

        return this
    }

    /**
     * update gross or net salary, employer contributions and total cost
     * @param  {String} target
     * @param  {Boolean} update
     * @return {Object}
     */
    update(target, update = true) {
        let multiplier = (1 - (this.tax_rate / 100));

        if (target === 'gross') {
            this.salary.annual_gross = Number(this.salary.annual_net / multiplier);
            this.salary.monthly_gross = Number(this.salary.monthly_net / multiplier);
            this.salary.daily_gross = Number(this.salary.daily_net / multiplier);
            this.salary.hourly_gross = Number(this.salary.hourly_net / multiplier)
        }

        if (target === 'net') {
            this.salary.annual_net = Number(this.salary.annual_gross * multiplier);
            this.salary.monthly_net = Number(this.salary.monthly_gross * multiplier);
            this.salary.daily_net = Number(this.salary.daily_gross * multiplier);
            this.salary.hourly_net = Number(this.salary.hourly_gross * multiplier)
        }

        if (update) {
            this.update_employer_contributions();
            this.update_total_cost()
        }

        return this
    }

    /**
     * update employer contributions
     * @return {Object}
     */
    update_employer_contributions() {
        let multiplier = (this.employer_contributions_rate / 100);
        this.salary.employer_contributions = Number(this.salary.annual_gross * multiplier);

        return this
    }

    /**
     * update total cost
     * @return {Object}
     */
    update_total_cost() {
        this.salary.total_cost = Number(this.salary.annual_gross + this.salary.employer_contributions);

        return this
    }
}
