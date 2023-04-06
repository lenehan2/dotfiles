module.exports = {
  env: {
    browser: true,
    es2020: true,
    jest: true,
  },
  extends: [
    'plugin:react/recommended',
    'airbnb',
    'plugin:prettier/recommended',
    'prettier/@typescript-eslint', // Uses eslint-config-prettier to disable ESLint rules from @typescript-eslint/eslint-plugin that would conflict with prettier
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 11,
    sourceType: 'module',
  },
  plugins: ['react'],
  ignorePatterns: ['templates/javascript/**/*.js'],
  rules: {
    'import/extensions': [
      'error',
      'ignorePackages',
      {
        js: 'never',
        mjs: 'never',
        jsx: 'never',
        ts: 'never',
        tsx: 'never',
      },
    ],
    'react/jsx-one-expression-per-line': 'off', // Too aggressive, and --fix mangles otherwise logical jsx codeblocks
    'react/jsx-filename-extension': [1, { extensions: ['.js', '.jsx', '.ts', '.tsx'] }],
    'react/prop-types': 1,
    'react/jsx-props-no-spreading': [
      1,
      {
        html: 'enforce',
        custom: 'enforce',
        exceptions: ['Comp'], // Render function prop spreading
      },
    ],
    'no-param-reassign': ['error', { props: true, ignorePropertyModificationsForRegex: ['^draft'] }], // Allows immer.js to edit state directly without error
    'no-plusplus': ['error', { allowForLoopAfterthoughts: true }], // Allow ++/-- in for loop
  },
  settings: {
    react: {
      version: 'detect', // Tells eslint-plugin-react to automatically detect the version of React to use
    },
    'import/resolver': {
      node: {
        extensions: ['.js', '.jsx', '.ts', '.tsx', '.json'],
      },
    },
  },
  overrides: [
    {
      files: ['*.ts', '*.tsx'],
      parserOptions: {
        project: './tsconfig.json',
        tsconfigRootDir: __dirname,
      },
      extends: [
        'plugin:@typescript-eslint/recommended',
        'plugin:@typescript-eslint/recommended-requiring-type-checking',
        'prettier/@typescript-eslint',
      ],
      rules: {
        '@typescript-eslint/no-use-before-define': 'off',
        'react/jsx-filename-extension': 'off',
        'react/prop-types': 'off', // babel-plugin-typescript-to-proptypes in babel.config.js generates prop-types for typescript files
      },
    },
  ],
};
