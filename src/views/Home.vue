<script setup>
import { onMounted, ref } from 'vue';
import { getResume } from '../resume';
import Year from '../components/Year.vue';
import YearData from '../components/YearData.vue';

const yearStartingSide = 1; //1:left, 0:right
const locale = 'en';
let resume = ref([]);
let phone = ref(null);

onMounted(async _ => {
    resume.value = await getResume(locale);
    phone.value = localStorage.getItem('phone');
})
</script>


<template>
  <div class="site-container">
    <div class="info">
      <div class="fixed">
        <section class="name">
          <img src="@/assets/avatar.jpg" width="200" />
          <h1>Sebastián Findling</h1>
          <h3 class="role screen senior">
              Senior Software Developer
          </h3>
          <h3 class="role screen sr">
              Sr. Software Developer
          </h3>
          <div class="icons screen">
            <Popper content="Linkedin" hover arrow :interactive="false">
              <a href="//linkedin.com/in/findling" target="_blank">
                <i class="fa-brands fa-linkedin"></i>
              </a>
            </Popper>
            <Popper content="WhatsApp" hover arrow :interactive="false">
              <a href="//wa.me/56999997371" target="_blank">
                <i class="fa-brands fa-whatsapp-square"></i>
              </a>
            </Popper>
            <!-- <Popper content="Personal blog" hover arrow :interactive="false">
              <a href="https://findling.cl" target="_blank">
                <i class="fa-brands fa-blogger"></i>
              </a>
            </Popper> -->
            <Popper content="My GitHub repo" hover arrow :interactive="false">
              <a class="desktop" href="https://github.com/sebolio" target="_blank">
                <i class="fa-brands fa-github-square"></i>
              </a>
            </Popper>
              <!-- <Popper content="Music" hover arrow :interactive="false">
                <a href="//soundcloud.com/rojosostenido" target="_blank">
                  <i class="fa-solid fa-square-caret-right"></i>
                </a>
              </Popper> -->
          </div>
        </section>
        <h3 class="print">
          I am a senior software developer and tech lead with many years of experience.
          <br><br>
          <li>Email: sebastian@findling.cl</li>
          <li>Phone: +569 {{ phone }}</li>
          <li>Portfolio: <a href="https://seb.cl">seb.cl</a></li>
          <li>Residence: Santiago de Chile</li>
          <br><br><br>
        </h3>
      </div>
    </div>

    <div class="resume">
      <h2>Welcome! 😃<a class="view-seb" href="https://seb.cl">View interactive version</a></h2>
        <h5>I am a senior software developer and tech lead with many years of experience.</h5>
      <!-- <h4>Projects developed just by myself, unless noted otherwise.</h4> -->
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
            v-for="(item, i) in year.items"
            :title="item.title"
            :description="item.description"
            :images="item.images"
            :last="i === year.items.length - 1"
          />
        </ul>
      </Year>
      <h2 class="screen">Phew... that's a lot 😅</h2>

    </div>
  </div>
</template>

<style lang="scss">
@import "@/assets/bootstrap.min.css";
@import "@/assets/style.css";
@import "@/assets/home.scss";
@import "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css";
</style>
