---
layout: page
title: 开发团队
---
<script setup>
  import { VPTeamPage, VPTeamPageTitle, VPTeamPageSection, VPTeamMembers } from "vitepress/theme";
  import { projectManagers, teamMembers } from "./_data/team";
</script>
  <VPTeamPageTitle>
    <template #title>开发团队成员介绍</template>
    <template #lead>Hestia 的开发由国际团队指导，选择部分成员在下面进行介绍.
    </template>
  </VPTeamPageTitle>
  <VPTeamPageSection>
    <template #title>项目经理</template>
    <template #members>
      <VPTeamMembers :members="projectManagers" />
    </template>
  </VPTeamPageSection>
  <VPTeamPageSection>
    <template #title>团队成员</template>
    <template #members>
      <VPTeamMembers :members="teamMembers" />
    </template>
  </VPTeamPageSection>
