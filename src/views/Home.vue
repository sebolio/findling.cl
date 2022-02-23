<script setup>
import { onMounted, ref } from 'vue';
import { getResume } from '../resume';
import Year from '../components/Year.vue';
import YearData from '../components/YearData.vue';

const yearStartingSide = 1; //1:left, 0:right
const locale = 'en';
let resume = ref([]);

onMounted(async _ => {
  resume.value = await getResume(locale);
})
</script>


<template>
  <div class="site-container">
    <div class="info">
      <div class="fixed">
        <section class="name">
          <img src="@/assets/avatar.jpg" width="200" />
          <h1>Seb Findling</h1>
          <div class="icons">
              <Popper content="Linkedin" hover arrow :interactive="false">
                <a href="//linkedin.com/in/seb-findling" target="_blank">
                  <i class="fa-brands fa-linkedin"></i>
                </a>
              </Popper>
              <Popper content="WhatsApp" hover arrow :interactive="false">
                <a href="//wa.me/56937067212" target="_blank">
                  <i class="fa-brands fa-whatsapp-square"></i>
                </a>
              </Popper>
              <Popper content="GitHub" hover arrow :interactive="false">
                <a href="//github.com/sebfindling" target="_blank">
                  <i class="fa-brands fa-github-square"></i>
                </a>
              </Popper>
              <Popper content="Music" hover arrow :interactive="false">
                <a href="//soundcloud.com/rojosostenido" target="_blank">
                  <i class="fa-solid fa-square-caret-right"></i>
                </a>
              </Popper>
          </div>
        </section>
        <h3>
          Very creative developer and consultant. Pastime musician, 34, CTO in
          <Popper placement="right" arrow hover openDelay="300">
            <template #content>
                <img src="https://seb.cl/captures/dreamoms1.jpg" width="300" />
                <p>Educational and medical platform for mothers<br>and pregnants</p>
            </template>
            <a href="//dreamoms.com" target="_blank">Dreamoms</a>
          </Popper> and founder of
          <Popper placement="right" arrow hover openDelay="300">
            <template #content>
                <img src="https://seb.cl/captures/puntero.jpg" width="300" />
                <p>Software for everything and everyone</p>
            </template>
            <a href="//puntero.cl" target="_blank">Puntero</a>
          </Popper> <!--and author of
          <Popper placement="right" arrow hover openDelay="300">
            <template #content>
                <img src="https://seb.cl/captures/blox.jpg" width="300" />
                <p>Multi purpose library for managing data using<br>forms and tables</p>
            </template>
            <a href="//blox.ee" target="_blank">Blox</a>
          </Popper>-->.
        </h3>
      </div>
    </div>

    <div class="resume">
      <h2>Experience</h2>
      <Year
        v-for="(year, i) in resume"
        :year="year.year"
        :right="i % 2 === yearStartingSide"
        :left="i % 2 !== yearStartingSide"
        :first="i === 0"
        :last="i === resume.length - 1"
      >
        <ul class="year-data">
          <YearData
            v-for="item in year.items"
            :title="item.title"
            :description="item.description"
            :images="item.images"
          />
        </ul>
      </Year>
      <h2>Phew.. that's a lot</h2>

    </div>
  </div>
</template>

<style lang="scss">
@import "@/assets/bootstrap.min.css";
@import "@/assets/style.css";
@import "@/assets/home.scss";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css";
</style>
