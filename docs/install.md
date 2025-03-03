---
layout: page
title: 面板安装
---

<script setup>
  import PageHeader from "./.vitepress/theme/components/PageHeader.vue";
  import InstallBuilder from "./.vitepress/theme/components/InstallBuilder.vue";
  import { options } from "./_data/options";
</script>

<InstallPage>
  <PageHeader>
    <template #title>快速安装 Hestia 服务器控制面板配置生成</template>
  </PageHeader>
  <PageHeader>
    <template #aside><a class="header-button" href="https://www.hostbuf.com" target="_blank"> 服务器连接工具推荐 [FinalShell] </a></template>
  </PageHeader>
  <PageHeader>
    <template #aside><a class="header-button" href="./docs/introduction/getting-started#要求">查看安装要求</a></template>  
  </PageHeader>
  <InstallBuilder :options="options"></InstallBuilder>
</InstallPage>

<style>
.header-button {
  display: inline-block;
  border: 1px solid transparent;
  font-weight: 600;
  transition: color 0.25s, border-color 0.25s, background-color 0.25s;
  border-radius: 20px;
  padding: 0 20px;
  line-height: 38px;
  font-size: 14px;
  border-color: var(--vp-button-alt-border);
  color: var(--vp-button-alt-text);
  background-color: var(--vp-button-alt-bg);

  &:hover {
    border-color: var(--vp-button-alt-hover-border);
    color: var(--vp-button-alt-hover-text);
    background-color: var(--vp-button-alt-hover-bg);
  }
}
</style>

<style>
  .header-button {  
    color: white;
    background-color: var(--vp-c-brand);
  }  
  .header-button:hover {
    color: white;
    background-color: #d8036a;
  }  
</style>
