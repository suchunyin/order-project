import { http } from "../Http";

export const login = async (data: any) => {
  const res = await http.post("/admin/login", data);
  return res;
};

export const getInfo = async () => {
  const res = await http.get("/admin/info");
  return res;
};

export const updateInfo = async (data: any) => {
  const res = await http.post("/admin/update", data);
  return res;
};