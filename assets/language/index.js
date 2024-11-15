import { createI18n } from 'vue-i18n';
import store from '@/store';
import { useStorage } from 'vue3-storage';
import cn from './zh-cn';
import en from './en';
import vn from './vn';

const storage = useStorage();

const messages = {
  en,
  cn,
  vn,
};

export const getLocale = () => {
  const localLan = storage.getStorageSync('lang');
  if (localLan) {
    return localLan;
  }
  const language = navigator.language.toLowerCase() || navigator.browserLanguage.toLowerCase();
  if (language === 'vi') {
    store.commit('CHANGE_LAN', 'vn');
    return 'vn';
  } else if (language === 'zh-cn' || language === 'zh-tw' || language === 'zh-hk') {
    store.commit('CHANGE_LAN', 'cn');
    return 'cn';
  }
  store.commit('CHANGE_LAN', 'en');
  return 'vn';
};

const i18n = createI18n({
  locale: getLocale(),
  messages,
});

export default i18n;
