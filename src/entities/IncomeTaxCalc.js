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

	tax_bracket_1 = 10064;
	tax_bracket_2 = 25659;
	tax_bracket_3 = 73369;
	tax_bracket_4 = 157806;

	/**
	 * compustes french income tax according to tax brackets
	 * @param  {[type]} net_income [description]
	 * @return {[type]}            [description]
	 */
	get_income_tax(net_income) {
		let tax_bracket_1 = 10064
		let tax_bracket_2 = 25659
		let tax_bracket_3 = 73369
		let tax_bracket_4 = 157806

		let tax_rate_1 = 11
			let tax_rate_2 = 30
			let tax_rate_3 = 41
			let tax_rate_4 = 45

		if (net_salary > tax_bracket_1) {
			// total_taxes = (net_salary - tax_bracket_1) * 
		}

		return;
	}
}
