import axios, { AxiosResponse } from "axios";

interface ResType<T> {
  code: number;
  res?: T;
  msg: string;
}

interface Http {
  get<T>(url: string, params?: unknown): Promise<ResType<T>>;
  post<T>(url: string, params?: unknown): Promise<ResType<T>>;
  upload<T>(url: string, params: unknown): Promise<ResType<T>>;
}

axios.defaults.baseURL = "/api";
axios.defaults.timeout = 120 * 1000;
// const imgBase = "/toimage";

// 响应拦截
axios.interceptors.response.use((res: AxiosResponse) => {
  switch (res.status) {
    case 200:
      return res.data;
    default:
      return;
  }
});

export const http: Http = {
  get(url, params) {
    return new Promise((resolve, reject) => {
      axios
        .get(url, { params })
        .then((res: any) => {
          console.log(res);
          // res.res = res.res.map((r: any) => {
          //   r.img && (r.img = imgBase + r.img);
          //   r.image && (r.image = imgBase + r.image);
          //   if (r.product) {
          //     r.product = r.product.map((v: { image: string }) => {
          //       v.image && (v.image = imgBase + v.image);
          //       return v;
          //     });
          //   }
          //   return r;
          // });
          resolve(res);
        })
        .catch((err: any) => {
          reject(err.data);
        });
    });
  },
  post(url, params) {
    return new Promise((resolve, reject) => {
      axios
        .post(url, params)
        .then((res: any) => {
          resolve(res);
        })
        .catch((err) => {
          reject(err.data);
        });
    });
  },
  upload(url, file) {
    return new Promise((resolve, reject) => {
      axios
        .post(url, file, {
          headers: { "Content-Type": "multipart/form-data;" },
        })
        .then((res: any) => {
          // res.res.img = imgBase + res.res.img;
          resolve(res);
        })
        .catch((err) => reject(err.data));
    });
  },
};
