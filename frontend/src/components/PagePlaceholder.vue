<template>
  <div class="page-grid">
    <div>
      <h2 class="page-title">{{ title }}</h2>
      <p class="page-description">{{ description }}</p>
    </div>
    <div class="placeholder-card">
      <h3>预留内容</h3>
      <ul class="placeholder-list">
        <li v-for="item in modules" :key="item">{{ item }}</li>
      </ul>
    </div>
  </div>
</template>

<script setup>
defineProps({
  title: {
    type: String,
    required: true
  },
  description: {
    type: String,
    required: true
  },
  modules: {
    type: Array,
    default: () => []
  }
});
</script>
