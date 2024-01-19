<!--
    This file is part of the Calculatrice Salaire Net TangoMan package.

    (c) Matthias Morin <mat@tangoman.io>

    This source file is subject to the MIT license that is bundled
    with this source code in the file LICENSE.
-->
<template>
    <div class="container pt-lg-4 pt-md-4 pt-sm-1 pt-xs-1" id="app">
        <t-card></t-card>
    </div>
</template>
<script>
    import tCard from './components/Card.vue'
    export default {
        name: 'app',
        components: {
            tCard
        }
    }
</script>
<style lang="scss">
    @media only screen and (max-width: 576px) {
        .container {
            padding: 0;
        }
    }
</style>
