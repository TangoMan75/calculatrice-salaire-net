import js from '@eslint/js'
import pluginVue from 'eslint-plugin-vue'
import babelParser from '@babel/eslint-parser'
import globals from 'globals'

export default [
  js.configs.recommended,
  ...pluginVue.configs['flat/essential'],
  {
    languageOptions: {
      ecmaVersion: 2022,
      sourceType: 'module',
      globals: {
        ...globals.browser,
        ...globals.node
      }
    },
    rules: {
      'no-console': process.env.NODE_ENV === 'production' ? 'error' : 'off',
      'no-debugger': process.env.NODE_ENV === 'production' ? 'error' : 'off',
      'vue/multi-word-component-names': 'off',
      'vue/no-reserved-component-names': 'off'
    }
  },
  {
    files: ['**/*.js'],
    languageOptions: {
      parser: babelParser,
      parserOptions: {
        requireConfigFile: false
      }
    }
  },
  {
    files: ['**/*.vue'],
    languageOptions: {
      parserOptions: {
        parser: babelParser,
        requireConfigFile: false
      }
    }
  },
  {
    files: ['tests/unit/**/*.js'],
    languageOptions: {
      globals: {
        ...globals.vitest
      }
    }
  }
]
