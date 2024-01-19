/**
 * This file allows to serve Vue.js over github_pages
 * 
 * @url https://tangoman75.github.io/salaire-brut-net
 */

module.exports = {
    publicPath: process.env.NODE_ENV === 'production'
    ? '/calculatrice-salaire-net/'
    : '/'
}