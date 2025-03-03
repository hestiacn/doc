<script>
export default {
  props: {
    items: {
      type: Array,
      required: true
    }
  },
  methods: {
    chunkArray(arr, size) {
      return Array.from({ length: Math.ceil(arr.length / size) }, (v, i) =>
        arr.slice(i * size, i * size + size)
      )
    }
  }
}
</script>

<template>
  <ul class="FeatureList">
    <template v-for="(item, index) in items" :key="index">
      <li>
        <span v-html="item.text"></span>
        <div v-if="item.apps" class="app-grid">
          <div 
            v-for="(row, rowIndex) in chunkArray(item.apps, 4)"
            :key="`row-${rowIndex}`"
            class="app-row"
          >
            <div
              v-for="(app, colIndex) in row"
              :key="`app-${rowIndex}-${colIndex}`"
              class="app-card"
            >
              <div class="app-icon">
                <img v-if="app.iconType === 'image'" :src="app.icon" :alt="app.text"></img>
                <i v-else-if="app.iconType === 'fontawesome'" :class="app.icon"></i>
                <svg v-else-if="app.iconType === 'svg'" v-html="app.icon"></svg>
              </div>
              <div class="app-name">{{ app.text }}</div>
            </div>
          </div>
        </div>
      </li>
    </template>
  </ul>
</template>

<style scoped>
:root {
  --app-card-scale: 0.65;
}
.FeatureList {
  margin: 0.55em 0;
  padding-left: 1em;
  list-style: disc;
  line-height: 1.5;

  & ul {
    padding-left: 1em;
    list-style: disc;
  }

  & li {
    margin-top: 0.5em;
  }

  @media (min-width: 640px) {
    font-size: 1.15rem;
  }
}

.app-grid {
  margin: 1.5rem 0;
}

.app-row {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1.5rem;
  margin-bottom: 1.5rem;
}

.app-card {
  padding: 1rem;
  background: var(--vp-c-bg-soft);
  border-radius: 8px;
  text-align: center;
  transition: transform 0.2s ease;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
  
  &:hover {
    transform: translateY(-3px);
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.15);
  }
}

.app-icon {
  height: 60px;
  margin-bottom: 0.8rem;
  display: flex;
  align-items: center;
  justify-content: center;

  img {
    max-height: 100%;
    max-width: 100%;
    object-fit: contain;
  }

  i {
    font-size: 2.5rem;
    color: var(--vp-c-brand);
  }

  svg {
    width: 48px;
    height: 48px;
    fill: currentColor;
  }
}

.app-name {
  font-size: 0.9rem;
  font-weight: 500;
  word-break: break-word;
}

@media (max-width: 768px) {
  .app-row {
    grid-template-columns: repeat(2, 1fr);
    gap: 1rem;
  }

  .app-icon {
    height: 50px;
    
    i {
      font-size: 2rem;
    }

    svg {
      width: 40px;
      height: 40px;
    }
  }
}
</style>
