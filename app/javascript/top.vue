<template>
  <div>
    <transition name='fade' mode='out-in' appear>
        <div class="top-title">Biitos</div>
    </transition>
    <transition name='fade2' mode='out-in' appear
        @before-enter="beforeEnter"
        @after-enter="afterEnter"
    >
        <div class="description">最高の出会いと最高の音楽を</div>
    </transition>
  </div>
</template>

<script>
export default {

}
</script>

<style>
  .fade-enter {
    opacity: 0;
  }
  .fade-enter-active {
    transition: opacity 1s;
  }
  .fade-enter-to {
    opacity: 1;
  }
  .fade2-enter {
    opacity: 0;
  }
  .fade2-enter-active {
    transition: opacity 5s;
  }
  .fade2-enter-to {
    opacity: 1;
  }
</style>