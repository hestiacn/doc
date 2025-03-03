import { version } from '../../../package.json';
export default [
  { text: '功能特点介绍', link: '/features' },
  { text: '面板安装', link: '/install' },
  { text: '部署文档指南', link: '/docs/introduction/getting-started', activeMatch: '/docs/' },
  { text: '开发团队介绍', link: '/team' },
  { text: '官方面板演示', link: 'https://demo.hestiacp.com:8083/' },
  { text: '论坛', items: [
      { text: '中文论坛', link: 'https://bbs.hestiamb.org', },
      { text: '英文官方论坛', link: 'https://forum.hestiacp.com', },],},
  { text: '赞助开源社区', link: '/donate' },
  { text: `最新版本 v ${version}`,
    items: [
    {text: '版本更新日志',link: '/changelog', },
    {text: '团队贡献',link: '/contribute', },
    {text: '安全策略',link: '/strategies', },
  ],		
 },
];
