import { createApp } from "vue";
import App from "./App.vue";
import router from "./app/router.js";
import "./styles/global.css";

createApp(App).use(router).mount("#root");
