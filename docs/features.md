---
layout: page
title: 面板特点
---
<script setup>
  import PageHeader from "./.vitepress/theme/components/PageHeader.vue";
  import FeaturePageSection from "./.vitepress/theme/components/FeaturePageSection.vue";
  import FeatureList from "./.vitepress/theme/components/FeatureList.vue";
  import { users, webDomains, mail, dns, databases, serverAdmin } from "./_data/features";
</script>

<FeaturePage>
  <PageHeader>
    <template #title>面板特点</template>
  </PageHeader>
  <FeaturePageSection image="/images/undraw_two_factor_authentication_namy.svg">
    <template #title>多种用户安全机制</template>
    <template #lead>与其他用户共享对您服务器的访问权限并限制他们的资源</template>
    <template #list>
      <FeatureList :items="users"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_web_developer_re_h7ie.svg">
    <template #title> 快速部署 Web 网站</template>
    <template #lead>支持添加管理无限域并在其上快速安装应用程序.</template>
    <template #list>
      <FeatureList :items="webDomains"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_domain_names_re_0uun.svg">
    <template #title>自定义DNS和服务器集群</template>
    <template #lead>构建高效安全的DNS集群：高可用、负载均衡与实时监控</template>
    <template #list>
      <FeatureList :items="dns"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_personal_email_re_4lx7.svg">
    <template #title>自建Mail系统</template>
    <template #lead>自定义您自己的网站电子邮件系统，无需向商业邮件提供商付费!</template>
    <template #list>
      <FeatureList :items="mail"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_maintenance_re_59vn.svg">
    <template #title>多种数据库支持</template>
    <template #lead>从电子商务到博客，到大型网站管理，数据库总是需要用的，您可以在 MySQL 和 PostgreSQL 之间进行自由选择.</template>
    <template #list>
      <FeatureList :items="databases"></FeatureList>
    </template>
  </FeaturePageSection>
  <FeaturePageSection image="/images/undraw_server_status_re_n8ln.svg">
    <template #title>服务器备份管理</template>
    <template #lead>Hestia 控制面板的自动备份功能支持 SFTP、FTP 安全协议，并通过 Rclone 实现云备份的集成，为服务器管理员提供了高度灵活的数据备份和恢复选项。</template>
    <template #list>
      <FeatureList :items="serverAdmin"></FeatureList>
    </template>
  </FeaturePageSection>
</FeaturePage>
