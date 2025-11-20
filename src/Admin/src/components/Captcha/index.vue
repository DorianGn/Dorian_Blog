<template>
  <div class="captcha-inline" @click="refreshCode" title="点击刷新">
    <span class="code-display">{{ code }}</span>
  </div>
</template>

<script>
export default {
  data() {
    return {
      code: '',
    };
  },
  methods: {
    generateCode(length = 4) {
      let result = '';
      const characters = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
      for (let i = 0; i < length; i++) {
        result += characters.charAt(Math.floor(Math.random() * characters.length));
      }
      this.code = result;
    },
    refreshCode() {
      this.generateCode(4);
    },
    verify(inputCode) {
      return inputCode.toUpperCase() === this.code.toUpperCase();
    },
    getCode() {
      return this.code;
    }
  },
  mounted() {
    this.generateCode(4);
  },
};
</script>

<style scoped>
.captcha-inline {
  display: flex;
  align-items: center;
  height: 100%;
  padding-left: 12px;
  border-left: 1px solid #e8e8e8;
  cursor: pointer;
  transition: all 0.2s;
}

.captcha-inline:hover {
  background: rgba(24, 67, 185, 0.03);
}

.code-display {
  font-size: 16px;
  font-weight: 600;
  letter-spacing: 3px;
  color: #1843b9;
  user-select: none;
  font-family: 'Courier New', monospace;
  min-width: 65px;
  text-align: center;
}
</style>
