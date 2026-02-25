import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import { VitePWA } from 'vite-plugin-pwa'
import { fileURLToPath, URL } from 'node:url'

export default defineConfig({
    base: process.env.NODE_ENV === 'production' ? '/calculatrice-salaire-net/' : '/',
    build: {
        outDir: 'docs',
    },
    plugins: [
        vue(),
        VitePWA({
            registerType: 'autoUpdate',
            workbox: {
                globPatterns: ['**/*.{js,css,html,ico,png,svg,jpg,json}']
            },
            manifest: {
                name: 'TangoMan | Calculatrice Salaire Net',
                short_name: 'Calculatrice Salaire Net',
                description: 'La Calculatrice Salaire Net TangoMan permet de convertir votre salaire brut en net horaire, journalier, mensuel, annuel...',
                theme_color: '#5599FF',
                background_color: '#5599FF',
                display: 'standalone',
                start_url: '.',
                icons: [
                    {
                        src: '/images/icons/android-chrome-192x192.png',
                        sizes: '192x192',
                        type: 'image/png'
                    },
                    {
                        src: '/images/icons/android-chrome-512x512.png',
                        sizes: '512x512',
                        type: 'image/png'
                    }
                ]
            }
        })
    ],
    css: {
        preprocessorOptions: {
            scss: {
                api: 'modern'
            }
        }
    },
    resolve: {
        alias: {
            '@': fileURLToPath(new URL('./src', import.meta.url))
        }
    },
    test: {
        environment: 'jsdom',
        include: ['tests/unit/**/*.spec.js'],
        globals: true
    }
})
