export default {
  fetch: function(...args) {
    return fetch(...args);
  },
  stringify: function(map) {
    return JSON.stringify(map);
  },
  log: console.log
};
