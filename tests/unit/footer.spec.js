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
import { assert } from 'chai'
import { shallowMount } from '@vue/test-utils'
import Footer from '@/components/Footer.vue'

describe('Footer.vue', () => {

    it('renders props.version and props.copyright when passed', () => {
        const copyrights = '2024 Matthias Morin';
        const version = '1.0.0';
        const wrapper = shallowMount(Footer, {
            propsData: { version, copyrights }
        });
        assert.include(wrapper.text(), copyrights);
        assert.include(wrapper.text(), version)
    })
});

