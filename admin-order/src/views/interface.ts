export interface productPrice {
  size: string;
  price: number;
  store: number;
}
export interface productAttribute {
  name: string;
  items: Array<string>;
}
interface orderProduct {
  id: number;
  name: string;
  image: string;
  attribute: string;
  num: number;
  price: number;
}

export interface typeApi {
  id: number;
  name: string;
  img: string;
  isDeleted?: number;
  productList: Array<productApi>;
}
export interface productApi {
  id?: number;
  name: string;
  describe: string;
  image: string;
  defaultPrice: number; //默认最低价
  sales: number;
  typeId: number;
  price: Array<productPrice>;
  totalStore: number;
  attribute: Array<productAttribute>;
  isDeleted?: number;
}
export interface orderApi {
  id: number;
  orderType: number;
  amount: number;
  dealNum: number;
  code: string;
  phone: string;
  remark: string;
  userId: string;
  product: Array<orderProduct>;
  createdAt: string;
  isDeleted?: number;
}
export interface recommendApi extends productApi {
  cover: string;
  isRecommend: number;
}
