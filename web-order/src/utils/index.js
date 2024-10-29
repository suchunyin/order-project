// 获取元素布局位置信息
export function getElement(id) {
  return new Promise((resolve) => {
    uni
      .createSelectorQuery()
      .select(id)
      .boundingClientRect((res) => {
        resolve(res);
      })
      .exec();
  });
}
// const { baseUrl } = require("../api");
import api from "../api/index";
const baseUrl = api.baseUrl;
export function imageUrl(image) {
  return image ? baseUrl + image : image;
}
