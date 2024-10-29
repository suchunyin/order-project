const moment = require("moment");
const isSameDay = (d1, d2) => {
  return moment(d1).isSame(d2, "day");
};
module.exports = { isSameDay };
