import { http } from "../Http";

export const getOrderList = async () => {
  const res = await http.get("/order/orderList?role=admin");
  return res.res;
};
export const getOrder = async (id: any) => {
    const res = await http.get(`/order/${id}`);
    return res.res;
  };

// 新增商品
export const addOrder = async (data: any) => {
  const res = await http.post(`/order/add`, data);
  return res;
};

// 删除商品
export const deleteOrder = async (data: any) => {
  const res = await http.post(`/order/delete`, data);
  return res;
};
