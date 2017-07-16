export default {
  fetch: function(...args) {
    return fetch(...args);
  },
  stringify: JSON.stringify,
  log: console.log
};
