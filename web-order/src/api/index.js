import request from "./request";

const baseUrl = "http://127.0.0.1:3009";
const apiUrl = baseUrl + "/api";

const register = (data) => {
  return request({ url: `${apiUrl}/user/register`, data: data, method: "POST" });
};

const login = (data) => {
  return request({ url: `${apiUrl}/user/login`, data: data, method: "POST" });
};
const getProductList = () => {
  return request({ url: `${apiUrl}/productType/typeList` });
};

const getOrderList = ({ id }) => {
  return request({ url: `${apiUrl}/order/orderList?id=${id}` });
};
const addOrder = (data) => {
  return request({ url: `${apiUrl}/order/add`, data: data, method: "POST" });
};
const getOrderInfo = (id) => {
  return request({ url: `${apiUrl}/order/${id}` });
};
const deleteOrder = (data) => {
  return request({ url: `${apiUrl}/order/delete`, data: data, method: "POST" });
};

const api = {
  baseUrl,
  getProductList,
  getOrderList,
  addOrder,
  getOrderInfo,
  deleteOrder,
  login,
  register
};
export default api;
