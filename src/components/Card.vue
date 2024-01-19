<!--
    This file is part of the Calculatrice Salaire Net TangoMan package.

    (c) Matthias Morin <mat@tangoman.io>

    This source file is subject to the MIT license that is bundled
    with this source code in the file LICENSE.
-->
<template>
    <!-- card -->
    <div class="card">
        <div class="card-header d-none d-sm-block">
            <h3><img src="../assets/logo.png" width="40" height="40" alt="" class="mr-3">Calculatrice Salaire Net</h3>
        </div>
        <div class="card-body">
            <div class="callout callout-success">
                <p>Pour un salarié travaillant <strong>{{ calc.hours.per_week }} heures par semaine</strong>, le
                    décompte de la durée de travail se fait sur la base de <strong>{{ calc.hours.per_year }}
                        heures</strong> pour une année civile. Soit 52 semaines multipliées par {{ calc.hours.per_week
                    }} heures par semaine.</p>
            </div>
            <div class="row controls px-lg-4 pb-lg-4">
                <div class="col-sm-6 col-md-6 col-lg-3 mb-md-2 mb-sm-2">
                    <label class="small" for="weekly_hour_base">Base hebdomadaire</label>
                    <div class="input-group input-group-sm">
                        <select id="weekly_hour_base" class="form-control" v-model="calc.hours.per_week"
                                @change="update_weekly_hour_base">
                            <option v-for="value in weekly_hour_bases" :key="value" :value="value">{{ value }}</option>
                        </select>
                        <div class="input-group-append">
                            <label for="weekly_hour_base" class="input-group-text">heures</label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-6 col-lg-3 mb-md-2 mb-sm-2">
                    <label class="small" for="status">Statut</label>
                    <select id="status" class="form-control form-control-sm" v-model="calc.tax_rate"
                            @change="update_tax_rate">
                        <option v-for="status in statuses" :key="status.label" :value="status.tax_rate">{{ status.label
                            }}
                        </option>
                    </select>
                </div>
                <div class="col-sm-6 col-md-6 col-lg-3 mb-md-2 mb-sm-2">
                    <label class="small" for="tax_rate">Cotisations</label>
                    <div class="input-group input-group-sm">
                        <input id="tax_rate" type="number" class="form-control" v-model="calc.tax_rate"
                               @change="update_tax_rate">
                        <div class="input-group-append">
                            <label for="tax_rate" class="input-group-text">%</label>
                        </div>
                    </div>
                </div>
                <div class="col-sm-6 col-md-6 col-lg-3 mb-md-2 mb-sm-2">
                    <label class="small" for="reference_wage">Préremplir avec</label>
                    <div class="input-group input-group-sm">
                        <div class="input-group-prepend">
                            <button class="btn btn-secondary" @click="set_reference_wage">&laquo;</button>
                        </div>
                        <select id="reference_wage" class="form-control" v-model="reference_wage_hourly_gross"
                                @change="set_reference_wage">
                            <option v-for="wage in reference_wages" :key="wage.label" :value="wage.hourly_gross">{{
                                wage.label }}
                            </option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="table-container px-lg-4 pb-lg-4">
                <table class="table table-bordered table-dark table-striped">
                    <thead>
                    <tr>
                        <th scope="col">Salaire</th>
                        <th scope="col">Brut</th>
                        <th scope="col">Net</th>
                        <th scope="col">Cotisations</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <th scope="row">Annuel</th>
                        <td>
                            <label for="annual_gross" @click="toggle('annual_gross')"
                                   :class="{ 'd-none': !edit.annual_gross }"><span class="editable">{{ calc.salary.annual_gross | format_euro }}</span></label>
                            <input id="annual_gross" type="number" :class="{ 'd-none': edit.annual_gross }"
                                   class="form-control form-control-sm" v-model="calc.salary.annual_gross"
                                   @change="update_annual_gross" @keyup="update_annual_gross"
                                   @keyup.enter="blur('annual_gross')" @blur="toggle('annual_gross')"/>
                        </td>
                        <td>
                            <label for="annual_net" @click="toggle('annual_net')"
                                   :class="{ 'd-none': !edit.annual_net }"><span class="editable">{{ calc.salary.annual_net | format_euro }}</span></label>
                            <input id="annual_net" type="number" :class="{ 'd-none': edit.annual_net }"
                                   class="form-control form-control-sm" v-model="calc.salary.annual_net"
                                   @change="update_annual_net" @keyup="update_annual_net"
                                   @keyup.enter="blur('annual_net')" @blur="toggle('annual_net')"/>
                        </td>
                        <td>
                            <p id="annual_tax">{{ calc.salary.annual_tax | format_euro }}</p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Mensuel</th>
                        <td>
                            <label for="monthly_gross" @click="toggle('monthly_gross')"
                                   :class="{ 'd-none': !edit.monthly_gross }"><span class="editable">{{ calc.salary.monthly_gross | format_euro }}</span></label>
                            <input id="monthly_gross" type="number" :class="{ 'd-none': edit.monthly_gross }"
                                   class="form-control form-control-sm" v-model="calc.salary.monthly_gross"
                                   @change="update_monthly_gross" @keyup="update_monthly_gross"
                                   @keyup.enter="blur('monthly_gross')" @blur="toggle('monthly_gross')"/>
                        </td>
                        <td>
                            <label for="monthly_net" @click="toggle('monthly_net')"
                                   :class="{ 'd-none': !edit.monthly_net }"><span class="editable">{{ calc.salary.monthly_net | format_euro }}</span></label>
                            <input id="monthly_net" type="number" :class="{ 'd-none': edit.monthly_net }"
                                   class="form-control form-control-sm" v-model="calc.salary.monthly_net"
                                   @change="update_monthly_net" @keyup="update_monthly_net"
                                   @keyup.enter="blur('monthly_net')" @blur="toggle('monthly_net')"/>
                        </td>
                        <td>
                            <p id="monthly_tax">{{ calc.salary.monthly_tax | format_euro }}</p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Journalier</th>
                        <td>
                            <label for="daily_gross" @click="toggle('daily_gross')"
                                   :class="{ 'd-none': !edit.daily_gross }"><span class="editable">{{ calc.salary.daily_gross | format_euro }}</span></label>
                            <input id="daily_gross" type="number" :class="{ 'd-none': edit.daily_gross }"
                                   class="form-control form-control-sm" v-model="calc.salary.daily_gross"
                                   @change="update_daily_gross" @keyup="update_daily_gross"
                                   @keyup.enter="blur('daily_gross')" @blur="toggle('daily_gross')"/>
                        </td>
                        <td>
                            <label for="daily_net" @click="toggle('daily_net')"
                                   :class="{ 'd-none': !edit.daily_net }"><span class="editable">{{ calc.salary.daily_net | format_euro }}</span></label>
                            <input id="daily_net" type="number" :class="{ 'd-none': edit.daily_net }"
                                   class="form-control form-control-sm" v-model="calc.salary.daily_net"
                                   @change="update_daily_net" @keyup="update_daily_net" @keyup.enter="blur('daily_net')"
                                   @blur="toggle('daily_net')"/>
                        </td>
                        <td>
                            <p id="daily_tax">{{ calc.salary.daily_tax | format_euro }}</p>
                        </td>
                    </tr>
                    <tr>
                        <th scope="row">Horaire</th>
                        <td>
                            <label for="hourly_gross" @click="toggle('hourly_gross')"
                                   :class="{ 'd-none': !edit.hourly_gross }"><span class="editable">{{ calc.salary.hourly_gross | format_euro }}</span></label>
                            <input id="hourly_gross" type="number" :class="{ 'd-none': edit.hourly_gross }"
                                   class="form-control form-control-sm" v-model="calc.salary.hourly_gross"
                                   @change="update_hourly_gross" @keyup="update_hourly_gross"
                                   @keyup.enter="blur('hourly_gross')" @blur="toggle('hourly_gross')"/>
                        </td>
                        <td>
                            <label for="hourly_net" @click="toggle('hourly_net')"
                                   :class="{ 'd-none': !edit.hourly_net }"><span class="editable">{{ calc.salary.hourly_net | format_euro }}</span></label>
                            <input id="hourly_net" type="number" :class="{ 'd-none': edit.hourly_net }"
                                   class="form-control form-control-sm" v-model="calc.salary.hourly_net"
                                   @change="update_hourly_net" @keyup="update_hourly_net"
                                   @keyup.enter="blur('hourly_net')" @blur="toggle('hourly_net')"/>
                        </td>
                        <td>
                            <p id="hourly_tax">{{ calc.salary.hourly_tax | format_euro }}</p>
                        </td>
                    </tr>
                    </tbody>
                </table>
                <div class="row">
                    <div class="col-xs-12 col-md-6 text-right">
                        <span class="mb-2 mb-sm-2 ml-2 small text-muted">
                            Charges patronales / an
                        </span>
                        <span class="mb-2 mb-sm-2 ml-2 badge badge-secondary">{{ calc.salary.employer_contributions | format_euro }}</span>
                    </div>
                    <div class="col-xs-12 col-md-6 text-right">
                        <span class="mb-2 mb-sm-2 ml-2 small text-muted">
                            Coût salarié total / an
                        </span>
                        <span class="editable-badge">
                            <label for="total_cost" @click="toggle('total_cost')"
                                   :class="{ 'd-none': !edit.total_cost }"
                                   class="mb-2 mb-sm-2 ml-2 badge badge-secondary">{{ (calc.salary.total_cost) |
                                format_euro
                                }}</label>
                            <input id="total_cost" type="number" :class="{ 'd-none': edit.total_cost }"
                                   class="form-control form-control-sm" v-model="calc.salary.total_cost"
                                   @change="update_total_cost" @keyup="update_total_cost"
                                   @keyup.enter="blur('total_cost')"
                                   @blur="toggle('total_cost')"/>
                        </span>
                    </div>
                </div>
            </div>
            <div class="callout">
                <p class="text-muted small">Notez que la calculatrice ne tient pas compte des différents avantages
                    monétaires ou en nature que pourrait proposer un employeur, tels que:</p>
                <ul class="text-muted small">
                    <li>Tickets restaurants</li>
                    <li>Participation aux frais de transports</li>
                    <li>Mutuelle d'entreprise</li>
                    <li>Primes et intéressement</li>
                    <li>Bon de Souscription de Parts de Créateur d'Entreprise (BSCPE)</li>
                    <li>Dispositif d'épargne salariale (PEE)</li>
                    <li>Plan d'épargne retraite collectif (Perco)</li>
                    <li>13e mois</li>
                    <li>Formations</li>
                    <li>Heures supplémentaires rémunérées</li>
                    <li>Chèques cadeaux</li>
                    <li>Chèques vacances</li>
                </ul>
            </div>
            <h4>Tickets restaurants</h4>
            <p class="card-text">Légalement, l'employeur est libre de déterminer le montant de la valeur des titres
                restaurant qu'il fournit à ses salariés. Cependant dans les faits, ils valent rarement plus que 10,42
                euros, pour des raisons fiscales.</p>
            <h4>Frais de transport</h4>
            <p class="card-text">D'après le Code du travail, tous les employeurs doivent prendre en charge une partie du
                prix de l'abonnement aux transports en commun de leurs salariés.</p>
            <h4>Mutuelle</h4>
            <p class="card-text">Légalement, la participation de l'employeur couvre au moins la moitié de la cotisation
                à la mutuelle collective.</p>
            <h4>mon-entreprise.fr</h4>
            <p class="card-text">Le gouvernement met à disposition un outil pour simuler le coût d'un salarié,
                disponible ici: <a href="https://mon-entreprise.fr/simulateurs/salaire-brut-net" target="_blank"
                                   rel="noopener noreferrer nofollow">mon-entreprise.fr</a>.</p>
        </div><!-- end card body -->
        <div class="card-footer">
            <button class="btn btn-outline-success btn-sm float-right" v-if="updateExists" @click="refreshApp">Mise à
                jour
            </button>
            <p class="small"><span class="badge badge-success mr-2">v1.0.0</span> Copyright &copy; Matthias Morin 2020
            </p>
        </div><!-- end card footer -->
    </div><!-- end card -->
</template>
<script>
    /* data */
    import statuses from '../data/statuses.json'
    import reference_wages from '../data/reference_wages.json'
    /* objects */
    import Salary from '../entities/Salary.js'
    import Hours from '../entities/Hours.js'
    import Calc from '../entities/Calc.js'

    let salary = new Salary()
    let hours = new Hours(35)
    let calc = new Calc(hours, salary, statuses[0])
    calc.set_hourly_gross(reference_wages[0].hourly_gross)
    export default {
        name: 'Card',
        data: function () {
            return {
                calc: calc,
                statuses: statuses,
                status: statuses[0],
                reference_wages: reference_wages,
                reference_wage_hourly_gross: reference_wages[0].hourly_gross,
                weekly_hour_bases: [35, 39],
                edit: {
                    'annual_gross': true,
                    'annual_net': true,
                    'monthly_gross': true,
                    'monthly_net': true,
                    'daily_gross': true,
                    'daily_net': true,
                    'hourly_gross': true,
                    'hourly_net': true,
                    'total_cost': true
                },
                refreshing: false, /* update mecanism */
                registration: null,
                updateExists: false
            }
        },
        filters: {
            format_euro(number) {
                return Intl.NumberFormat('fr-FR', {style: 'currency', currency: 'EUR'}).format(number)
            }
        },
        methods: {
            toggle(target) {
                /* set all properties to true (display:none) */
                for (let property in this.edit) {
                    if (property !== target) {
                        this.edit[property] = true
                    } else {
                        this.edit[property] = !this.edit[property]
                        if (!this.edit[property]) {
                            document.getElementById(target).focus()
                            document.getElementById(target).select()
                        }
                    }
                }
            },
            blur(target) {
                document.getElementById(target).blur()
            },
            set_reference_wage() {
                this.calc.set_hourly_gross(this.reference_wage_hourly_gross)
            },
            update_tax_rate() {
                this.calc.set_tax_rate(this.calc.tax_rate)
            },
            update_weekly_hour_base() {
                this.calc.hours.set_weekly_hour_base(this.calc.hours.per_week)
                /* update table according to hourly gross salary */
                this.calc.set_hourly_gross(this.calc.salary.hourly_gross)
            },
            update_annual_gross() {
                this.calc.set_annual_gross(this.calc.salary.annual_gross)
            },
            update_monthly_gross() {
                this.calc.set_monthly_gross(this.calc.salary.monthly_gross)
            },
            update_daily_gross() {
                this.calc.set_daily_gross(this.calc.salary.daily_gross)
            },
            update_hourly_gross() {
                this.calc.set_hourly_gross(this.calc.salary.hourly_gross)
            },
            update_annual_net() {
                this.calc.set_annual_net(this.calc.salary.annual_net)
            },
            update_monthly_net() {
                this.calc.set_monthly_net(this.calc.salary.monthly_net)
            },
            update_daily_net() {
                this.calc.set_daily_net(this.calc.salary.daily_net)
            },
            update_hourly_net() {
                this.calc.set_hourly_net(this.calc.salary.hourly_net)
            },
            update_total_cost() {
                this.calc.set_total_cost(this.calc.salary.total_cost)
            },
            showRefreshUI(e) {
                /* Display a button inviting the user to refresh/reload the app due */
                /* to an app update being available. */
                /* The new service worker is installed, but not yet active. */
                /* Store the ServiceWorkerRegistration instance for later use. */
                this.registration = e.detail;
                this.updateExists = true;
            },
            refreshApp() {
                /* Handle a user tap on the update app button. */
                this.updateExists = false;
                /* Protect against missing registration.waiting. */
                if (!this.registration || !this.registration.waiting) {
                    return;
                }
                this.registration.waiting.postMessage('skipWaiting');
            }
        },
        created() {
            /* Listen for swUpdated event and display refresh snackbar as required. */
            document.addEventListener('swUpdated', this.showRefreshUI, {once: true})
            /* Refresh all open app tabs when a new service worker is installed. */
            navigator.serviceWorker.addEventListener('controllerchange', () => {
                if (this.refreshing) {
                    return;
                }
                this.refreshing = true
                window.location.reload()
            })
        }
    }
</script>
<style scoped lang="scss">
    $primary: #007bff;
    $secondary: #6c757d;
    $success: #28a745;
    $info: #17a2b8;
    $warning: #ffc107;
    $danger: #dc3545;
    $light: #f8f9fa;
    $dark: #343a40;
    @media only screen and (max-width: 576px) {
        .container {
            padding: 0;
        }
    }

    .card {
        margin-bottom: 0;
        @media only screen and (min-width: 576px) {
            margin-bottom: 4rem;
        }

        .card-header {
            padding-bottom: 0;

            h3 {
                font-family: Ubuntu, Avenir, Helvetica, Arial, sans-serif;
                -webkit-font-smoothing: antialiased;
                -moz-osx-font-smoothing: grayscale;
            }
        }

        .card-body {
            .controls {
                margin-bottom: 1rem;

                label {
                    margin-bottom: 0;
                }
            }

            table {
                th, td {
                    @media only screen and (max-width: 576px) {
                        font-weight: lighter;
                        font-size: small;
                    }
                }

                th {
                    font-family: Ubuntu, Avenir, Helvetica, Arial, sans-serif;
                    overflow: hidden;
                    white-space: nowrap;
                    text-overflow: ellipsis;
                    -webkit-font-smoothing: antialiased;
                    -moz-osx-font-smoothing: grayscale;

                    &[scope=col]:first-of-type, &[scope=row] {
                        max-width: 5rem;
                    }
                }

                td {
                    min-width: 6rem;
                    max-width: 6rem;
                    padding: 0;

                    p {
                        display: block;
                        margin: 0;
                        padding: 12px;
                    }

                    label {
                        display: block;
                        margin: 0;
                        padding: 12px;

                        &:hover {
                            cursor: pointer;
                        }

                        .editable {
                            position: relative;
                            padding: 2px 4px;
                            border-radius: 3px;
                            border: 1px dotted #eee;

                            &:after {
                                font-size: 66%;
                                font-weight: lighter;
                                position: absolute;
                                right: 0;
                                bottom: 20px;
                                content: 'modifier';
                                @media only screen and (min-width: 576px) {
                                    right: -42px;
                                    bottom: 16px;
                                }
                            }

                            @media only screen and (hover: hover) and (min-width: 576px) {
                                border: 1px solid transparent;
                                &:after {
                                    content: '';
                                }
                                &:hover {
                                    border: 1px dotted #eee;

                                    &:after {
                                        content: 'modifier';
                                    }
                                }
                            }
                        }
                    }

                    input {
                        max-width: 13rem;
                        margin: 8px;
                        @media only screen and (max-width: 576px) {
                            max-width: 88px;
                            margin: 6px;
                        }
                        @media only screen and (min-width: 576px) and (max-width: 768px) {
                            max-width: 10rem;
                            margin: 8px 2px;
                        }
                    }
                }
            }

            .editable-badge {
                label:hover {
                    cursor: pointer;
                }

                input {
                    display: inline-block;
                    max-width: 13rem;
                    margin-bottom: 8px;
                }
            }
        }

        .card-footer p {
            margin-bottom: 0;
        }
    }

    .callout {
        margin-bottom: 1rem;
        padding: 1.25rem;
        border: 1px solid #eee;
        border-left-width: .25rem;
        border-left-color: lightgrey;
        border-radius: .25rem;

        &.callout-primary {
            border-left-color: $primary;
        }

        &.callout-secondary {
            border-left-color: $secondary;
        }

        &.callout-success {
            border-left-color: $success;
        }

        &.callout-info {
            border-left-color: $info;
        }

        &.callout-warning {
            border-left-color: $warning;
        }

        &.callout-danger {
            border-left-color: $danger;
        }

        &.callout-light {
            border-left-color: $light;
        }

        &.callout-dark {
            border-left-color: $dark;
        }
    }
</style>
