/**
 * This file is part of the Calculatrice Salaire Net TangoMan package.
 *
 * (c) Matthias Morin <mat@tangoman.io>
 *
 * This source file is subject to the MIT license that is bundled
 * with this source code in the file LICENSE.
 */

/**
 * IncomeTaxCalc
 */
 export default class IncomeTaxCalc {

    /**
     * Returns french income tax rate according to tax brackets.
     *
     * When user's net income is under first bracket, tax rate equals 11%
     *
     * @param  {Number} net_income User's net income
     * @return {Number} tax_rate   Tax rate
     */
    get_tax_rate(net_income) {

        let tax_bracket_1 = 10064
        let tax_bracket_2 = 25659
        let tax_bracket_3 = 73369
        let tax_bracket_4 = 157806

        let tax_rate_1 = 11;
        let tax_rate_2 = 30;
        let tax_rate_3 = 41;
        let tax_rate_4 = 45;

        let  tax_rate = 0;

        switch (true) {
            case net_income > tax_bracket_4:
                tax_rate = tax_rate_4;
                break;
            case net_income > tax_bracket_3:
                tax_rate = tax_rate_3;
                break;
            case net_income > tax_bracket_2:
                tax_rate = tax_rate_2;
                break;
            case net_income > tax_bracket_1:
                tax_rate = tax_rate_1;
                break;
        }

        return tax_rate;
    }
}
