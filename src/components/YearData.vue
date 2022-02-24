<script setup>
import { onMounted, ref } from 'vue';

const props = defineProps(['title', 'description', 'images'])
const currentOpenImage = ref(null);
const assetLocation = (uri) => uri.replace('@', location.hostname === 'seb.cl' ? '/assets' : '/src/assets'); //fix for local development
const imageMap = props.images ? ['', ...props.images.map(image => image.src ? assetLocation('/captures/'+image.src) : image)] : []
</script>

<template>
  <li class="year-data">
    <h3>{{ title }}</h3>
    <p>
      <Markdown :source="description" />
    </p>
    <div class="images">
      <Popper
        arrow
        hover
        v-for="(image, i) in images"
        @click="currentOpenImage = i + 1"
        :interactive="false"
        openDelay="90"
      >
        <template #content>
          <img :src="assetLocation('/thumbs/'+image.src)" width="300" v-if="image.src && assetLocation" />
          <p v-if="image.alt" style="text-align: center;">Click para agrandar</p>
        </template>
        <br><img :src="assetLocation('/thumbs/'+image.src)" height="50" class="file" v-if="image.src && assetLocation" />
      </Popper>
    </div>
  </li>
  <vue-easy-lightbox
    :imgs="imageMap"
    :index="currentOpenImage"
    :visible="currentOpenImage"
    @hide="currentOpenImage = null"
  ></vue-easy-lightbox>
</template>

<style lang="scss">
.year {
  min-height: 100px;
}
.year-data {
  margin-bottom: 40px !important;
  li {
    list-style: none;
    padding: 0;
    margin: 0;
  }
  p {
    margin-bottom: 0;
    code {
      background-color: #ffe4b3;
      color: black;
      padding: 2px;
      border: 1px solid #ffda85;
    }
    strong {
      font-weight: 600;
    }
  }
  h3 {
    text-decoration: underline;
    font-size: 1.1rem;
  }
  .images {
    margin-bottom: 20px;
    .file {
      border: 1px solid rgb(245, 162, 106);
      border-radius: 5px;
      margin-bottom: 10px;
      margin-right: 10px;
      min-width: 50px;
      min-height: 50px;
      background: rgb(245, 162, 106);
      cursor: pointer;
      &:hover {
        border: 1px solid rgb(212, 62, 3);
      }
    }
  }
}
</style>