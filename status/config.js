module.exports = {
  title: 'System Status AdminAFK',
  description: 'Status page of AdminAFK services',
  baseUrl: 'https://status.adminafk.fr',
  defaultLocale: 'en',
  locales: [
    { code: 'en', iso: 'en-US', name: 'English' }
  ],
  content: {
    frontMatterFormat: 'yaml',
    systems: [
      'personnalWebsite',
      'monitoring',
      'log',
      'mail',
      'wiki',
      'git'
    ]
  },
  theme: {
    scheduled: {
      position: 'aboveGlobalStatus'
    },
    links: {
      en: {
        contact: "https://adminafk.fr/#/Contact"
      }
    }
  },
  notifications: {
    twitter: {
      en: "MoNsTeRRR_CSGO"
    }
  }
}