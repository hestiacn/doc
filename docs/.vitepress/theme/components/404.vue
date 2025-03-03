<template lang="html">
  <div class="not-found">
    <div class="content">
      <font-awesome-icon :icon="randomIcon" class="icon" aria-hidden="true" />
      <h1 id="error-title">错误:404</h1>
      <p id="error-message">{{ randomMessage }}</p>
      <a href="/" class="home-link" aria-label="返回首页">
        <font-awesome-icon :icon="['fas', 'home']" aria-hidden="true" />
        返回首页
      </a>
    </div>

    <div class="floating-circles"></div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      messages: [
      "哎呀，页面被外星人绑架了！👽",
      "页面去度假了，暂时不在家。🏖️",
      "页面迷路了，正在找回家的路。🧭",
      "页面被猫咪叼走了！🐱",
      "页面被黑洞吸走了！🕳️",
      "页面正在和机器人跳舞！🤖",
      "页面去月球散步了！🌕",
      "页面被时间机器传送到未来！🚀",
      "页面在彩虹尽头玩耍！🌈",
      "页面去参加精灵派对了！🧚",
      "页面正在和海豚一起游泳！🐬",
      "页面被巫师施了魔法！🧙",
      ],
      icons: [
      ["fas", "ghost"],
        ["fas", "rocket"],
        ["fas", "cat"],
        ["fas", "cloud"],
        ["fas", "user-astronaut"],
        ["fas", "robot"],
        ["fas", "moon"],
        ["fas", "space-shuttle"],
        ["fas", "rainbow"],
        ["fas", "fairy"],
        ["fas", "dolphin"],
        ["fas", "magic"],
      ],
      randomMessage: "",
      randomIcon: [],
    };
  },
  created() {
    this.randomMessage = this.getRandomMessage();
    this.randomIcon = this.getRandomIcon();
  },
  methods: {
    getRandomMessage() {
      const randomIndex = Math.floor(Math.random() * this.messages.length);
      return this.messages[randomIndex];
    },
    getRandomIcon() {
      const randomIndex = Math.floor(Math.random() * this.icons.length);
      return this.icons[randomIndex];
    },
  },
};
</script>

<style scoped>
.not-found {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: linear-gradient(120deg, #ff9a9e, #fad0c4, #fbc2eb, #a18cd1, #fad0c4, #ffd1ff);
  background-size: 600% 600%; 
  animation: backgroundFade 20s ease infinite; 
  font-family: Arial, sans-serif;
  text-align: center;
  overflow: hidden;
  position: relative;
}

.content {
  background-color: #ffffff;
  padding: 2rem;
  border-radius: 15px;
  box-shadow: 0 8px 15px rgba(0, 0, 0, 0.1), 0 4px 6px rgba(0, 0, 0, 0.05);
  border: 1px solid #eee;
  z-index: 2;
  position: relative;
}
.icon {
  font-size: 3rem;
  color: #dc3545;
  margin-bottom: 1.5rem;
  animation: spin 3s linear infinite;
}
h1 {
  font-size: 3rem;
  margin: 0 0 2rem;
  color: #dc3545;
  animation: fadeIn 1.5s ease-in-out;
}
p {
  font-size: 1.5rem;
  color: #6c757d;
  margin: 1rem 0 2rem;
  animation: fadeIn 2s ease-in-out;
}
.home-link {
  display: inline-block;
  margin-top: 1rem;
  padding: 0.6rem 1.2rem;
  font-size: 1rem;
  color: #ffffff;
  background: linear-gradient(to right, #007bff, #0056b3);
  border-radius: 5px;
  text-decoration: none;
  transition: background-color 0.3s ease, transform 0.2s ease;
  position: relative;
  overflow: hidden;
}
.home-link:hover {
  background-color: #0056b3;
  transform: translateY(-2px);
}
.home-link::before {
  content: "";
  position: absolute;
  top: 0;
  left: 50%;
  width: 300%;
  height: 300%;
  background-color: rgba(255, 255, 255, 0.2);
  border-radius: 50%;
  transition: all 0.8s ease-in-out;
  opacity: 0;
  pointer-events: none;
  transform: translateX(-50%) translateY(-50%) scale(0);
}
.home-link:hover::before {
  opacity: 1;
  transform: translateX(-50%) translateY(-50%) scale(1);
}
.floating-circles {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  pointer-events: none;
  overflow: hidden;
}
.floating-circles::before,
.floating-circles::after {
  content: "";
  position: absolute;
  width: 100px;
  height: 100px;
  background-color: rgba(255, 255, 255, 0.1);
  border-radius: 50%;
  animation: float 8s ease-in-out infinite alternate;
}
.floating-circles::after {
  width: 150px;
  height: 150px;
  animation-delay: 4s;
}
@keyframes float {
  0%, 100% { transform: translateY(0); }
  50% { transform: translateY(-10px); }
}
@keyframes spin {
  0% {
    transform: rotate(0deg);
  }
  100% {
    transform: rotate(360deg);
  }
}
@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(20px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
@keyframes backgroundFade {
  0% {
    background-position: 0% 50%;
  }
  50% {
    background-position: 100% 50%;
  }
  100% {
    background-position: 0% 50%;
  }
}
@media (max-width: 768px) {
  h1 {
    font-size: 3rem;
  }
  p {
    font-size: 1.2rem;
  }
  .home-link {
    font-size: 0.9rem;
    padding: 0.4rem 0.8rem;
  }
}
</style>