export const setStore = (item: any, data: any) => {
  window.localStorage.setItem(item, JSON.stringify(data));
};
export const getStore = (item: any) => {
  let data = window.localStorage.getItem(item);
  if (!data) {
    return null;
  }
  try {
    return JSON.parse(data);
  } catch (error) {
    console.error("Failed to parse info:", error);
    return {};
  }
};
export const removeStore = (item: any) => {
  window.localStorage.removeItem(item);
};
