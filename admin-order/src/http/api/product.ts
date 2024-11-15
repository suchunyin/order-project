import { http } from "../Http";


// 上传图片
export const uploadImg = async (file: Blob, field: any) => {
  let fd = new FormData();
  fd.append(field, file);
  const res = await http.upload(`/uploadImage/${field}`, fd);
  return res.res;
};
// 删除图片
export const removeImg = async (image: any) => {
  const res = await http.post(`/removeImage`, { image });
  return res.res;
};

// 查询商品类目
export const getTypeList = async () => {
  const res = await http.get("/productType/typeList");
  return res.res;
};
// 新增类目
export const addType = async (data: any) => {
  const res = await http.post(`/productType/add`, data);
  return res;
}
// 删除类目
export const deleteType = async (data: any) => {
  const res = await http.post(`/productType/delete`, data);
  return res;
};

// 查询商品列表
export const getProductList = async () => {
  const res = await http.get("/product/productList");
  return res.res;
};
// 新增商品
export const addProduct = async (data: any) => {
  const res = await http.post(`/product/add`, data);
  return res;
};
// 删除商品
export const deleteProduct = async (data: any) => {
  const res = await http.post(`/product/delete`, data);
  return res;
};