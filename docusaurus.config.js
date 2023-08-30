// @ts-check
// Note: type annotations allow type checking and IDEs autocompletion

const lightCodeTheme = require('prism-react-renderer/themes/github');
const darkCodeTheme = require('prism-react-renderer/themes/dracula');

const math = require('remark-math');
const katex = require('rehype-katex');

/** @type {import('@docusaurus/types').Config} */
const config = {
  title: 'DevOps Roadmap',
  tagline: 'CoachCrew.tech',
  url: 'https://docs.devops.coachcrew.tech',
  baseUrl: '/',
  onBrokenLinks: 'throw',
  onBrokenMarkdownLinks: 'warn',
  favicon: 'img/favicon.ico',

  // GitHub pages deployment config.
  // If you aren't using GitHub pages, you don't need these.
  organizationName: 'CoachCrew.tech', // Usually your GitHub org/user name.
  projectName: 'devops-roadmap', // Usually your repo name.

  // Even if you don't use internalization, you can use this field to set useful
  // metadata like html lang. For example, if your site is Chinese, you may want
  // to replace "en" with "zh-Hans".
  i18n: {
    defaultLocale: 'en',
    locales: ['en'],
  },

  presets: [
    [
      '@docusaurus/preset-classic',
      /** @type {import('@docusaurus/preset-classic').Options} */
      {
        docs: {
          path: 'cloud',
          routeBasePath: 'cloud',
          sidebarPath: require.resolve('./sidebars.js'),
          // Please change this to your repo.
          // Remove this to remove the "edit this page" links.
          remarkPlugins: [math],
          rehypePlugins: [katex],
          editUrl:
            'https://github.com/mehr74/roadmap/tree/main/packages/create-docusaurus/templates/shared/',
        },
        theme: {
          customCss: require.resolve('./src/css/custom.css'),
        },
      },
    ],
  ],

  plugins: [
    [
      '@docusaurus/plugin-content-docs',
      /** @type {import('@docusaurus/preset-classic').Options} */
      {
        id: 'coding',
        path: 'coding',
        routeBasePath: 'coding',
        remarkPlugins: [math],
        rehypePlugins: [katex],
        sidebarPath: require.resolve('./sidebars.js'),
        // Please change this to your repo.
        // Remove this to remove the "edit this page" links.
        editUrl:
          'https://github.com/mehr74/roadmap/tree/main/packages/create-docusaurus/templates/shared/',
      },
    ],
    [
      '@docusaurus/plugin-content-docs',
      /** @type {import('@docusaurus/preset-classic').Options} */
      {
        id: 'tools',
        path: 'tools',
        routeBasePath: 'tools',
        remarkPlugins: [math],
        rehypePlugins: [katex],
        sidebarPath: require.resolve('./sidebars.js'),
        // Please change this to your repo.
        // Remove this to remove the "edit this page" links.
        editUrl:
          'https://github.com/mehr74/roadmap/tree/main/packages/create-docusaurus/templates/shared/',
      },
    ],

  ],
  stylesheets: [
    {
      href: 'https://cdn.jsdelivr.net/npm/katex@0.13.24/dist/katex.min.css',
      type: 'text/css',
      integrity:
        'sha384-odtC+0UGzzFL/6PNoE8rX/SPcQDXBJ+uRepguP4QkPCm2LBxH3FA3y+fKSiJ+AmM',
      crossorigin: 'anonymous',
    },
  ],

  themeConfig:
    /** @type {import('@docusaurus/preset-classic').ThemeConfig} */
    ({
      navbar: {
        title: 'Roadmap',
        logo: {
          alt: 'DevOps Roadmap',
          src: 'img/logo.svg',
        },
        items: [
          {
            to: '/cloud/intro',
            position: 'left',
            label: 'Cloud'
          },
          {
            to: '/coding/intro',
            position: 'left',
            label: 'Coding',
          },
          {
            to: '/tools/intro',
            position: 'left',
            label: 'Tools',
          },
        ],
      },
      footer: {
        style: 'dark',
        links: [
          {
            title: 'Cloud',
            items: [
              {
                label: 'cloud',
                to: '/cloud/intro',
              },
            ],
          },
          {
            title: 'Coding',
            items: [
              {
                label: 'Coding',
                href: '/coding/intro',
              },
            ],
          },
          {
            title: 'More',
            items: [
              {
                label: 'Ora',
                to: 'https://ora.pm',
              },
              {
                label: 'GitHub',
                href: 'https://github.com/mehr74/roadmap',
              },
            ],
          },
        ],
        copyright: `Copyright © ${new Date().getFullYear()} My Project, Inc. Built with Docusaurus.`,
      },
      prism: {
        theme: lightCodeTheme,
        darkTheme: darkCodeTheme,
        additionalLanguages: ['powershell', 'yaml', 'json', 'markdown', 'bash']
      },
    }),
};


module.exports = config;
