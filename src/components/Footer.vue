<!--
    This file is part of the Calculatrice Salaire Net TangoMan package.

    (c) Matthias Morin <mat@tangoman.io>

    This source file is subject to the MIT license that is bundled
    with this source code in the file LICENSE.
-->
<template>
    <footer class="card-footer">
        <p class="small"><span class="badge badge-success mr-2">v{{ version }}</span> Copyright &copy; {{ copyrights }}</p>
    </footer>
</template>
<script>
    // When bumping the app version, update the `version` prop passed
    // from Card.vue where this component is used.
    export default {
        name: 'Footer',
        props: {
            'version': String,
            'copyrights': String
        }
    }
</script>
<style scoped lang="scss">
    footer.card-footer p {
        margin-bottom: 0;
    }
</style>
