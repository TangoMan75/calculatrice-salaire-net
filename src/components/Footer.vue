<!--
    This file is part of the Calculatrice Salaire Net TangoMan package.

    (c) Matthias Morin <mat@tangoman.io>

    This source file is subject to the MIT license that is bundled
    with this source code in the file LICENSE.
-->
<template>
    <footer class="footer">
        <p class="small"><span class="badge badge-success mr-2">v{{ version }}</span> Copyright &copy; {{ copyrights }}</p>
    </footer>
</template>
<script>
    export default {
        name: 'Footer',
        props: {
            'version': String,
            'copyrights': String
        }
    }
</script>
<style scoped lang="scss">
    /* necessary to place footer at the bottom of the page */
    body {
        position: relative;
        min-height: 100vh;
    }
    footer.footer {
        width: 100%;
        position: absolute;
        min-height: 2rem;
        @media only screen and (min-width: 576px) {
            min-height: 4rem;
        }
    }
</style>
