import { defaultTheme } from '@vuepress/theme-default'

export default {
  title: 'Obsidian Notes', // 网站标题
  description: 'A collection of Markdown notes', // 网站描述
  theme: defaultTheme(), // 使用默认主题
  bundler: '@vuepress/bundler-vite', // 使用 Vite 打包器
  base: '/obsidian_note/', // GitHub Pages 仓库路径（如果部署到 GitHub Pages）
  themeConfig: {
    navbar: [
      { text: '首页', link: '/' }, // 首页导航链接
      { text: 'GitHub', link: 'https://github.com/emary3399/obsidian_note' } // GitHub 链接
    ],
    sidebar: 'auto' // 自动生成侧边栏
  }
}