const express = require("express");
const router = express.Router();

const { productType, product } = require("../router_handler/models");
router.use((req, res, next) => {
  console.log("--------------------------");
  console.log("time:", new Date());
  next();
});
// 商品列表查询
router.get("/product/productList", async (req, res) => {
  // 查询商品类型、商品
  let type = await productType.findAll({
    where: { isDeleted: 0 },
    raw: true,
  });
  let productList = await product.findAll({
    where: { isDeleted: 0 },
    raw: true,
  });
  // 拼接图片路径 转换json
  productList = productList.map((v) => {
    // v.image && (v.image = process.env.baseUrl + v.image);
    v.price = v.price ? JSON.parse(v.price) : v.price;
    v.attribute = v.attribute ? JSON.parse(v.attribute) : v.attribute;
    return v;
  });
  for (let i = 0; i < type.length; i++) {
    // 商品 拼接类型
    type[i].productList = productList.filter((v) => v.typeId == type[i].id);
    // 拼接图片路径
    // type[i].img && (type[i].img = process.env.baseUrl + type[i].img);
  }
  res.json({
    code: 200,
    msg: "",
    res: type,
  });
});
// 商品增加
router.post("/product/add", async (req, res) => {
  const ins = await product.create(
    { ...req.body },
    {
      fields: [
        `name`,
        `describe`,
        `image`,
        `defaultPrice`,
        `sales`,
        `typeId`,
        `price`,
        `totalStore`,
        `attribute`,
      ],
    }
  );
  res.json({
    code: 200,
    msg: "商品新增成功！",
    // res: ins,
  });
});
// 商品删除
router.post("/product/delete", async (req, res) => {
  const del = await product.update(
    { isDeleted: 1 },
    { where: { id: req.body.id } }
  );

  // const del = await product.destroy({ where: { id: req.body.id } });
  res.json({
    code: 200,
    msg: "删除成功！",
    // res: del,
  });
});
// 类型查询
router.get("/productType/typeList", async (req, res) => {
  let type = await productType.findAll({
    where: { isDeleted: 0 },
    raw: true,
  });
  type = type.map((v) => {
    v.img && (v.img = process.env.baseUrl + v.img);
    return v;
  });
  res.json({
    code: 200,
    msg: "",
    res: type,
  });
});
// 类型增加
router.post("/productType/add", async (req, res) => {
  const ins = await productType.create(
    { ...req.body },
    {
      fields: [`name`, `img`],
    }
  );
  res.json({
    code: 200,
    msg: "新增成功！",
    // res: ins,
  });
});
// 类型删除
router.post("/productType/delete", async (req, res) => {
  const del = await productType.update(
    { isDeleted: 1 },
    { where: { id: req.body.id } }
  );
  // const del = await productType.destroy({ where: { id: req.body.id } });
  res.json({
    code: 200,
    msg: "删除成功！",
    // res: del,
  });
});

router.get("/homepage/recommend", (req, res) => {
  res.status(500);
  throw new Error("服务器错误");
});

const mww = (req, res, next) => {
  console.log("第1个中间件");
  next();
};
router.post("/order/addq", [mww], (req, res) => {
  console.log(req.params);
  console.log(req.query);
  console.log(req.body);

  res.set({ aaa: "bbbb" });
  res.status(201).json("wwwwwwwwww");
});
module.exports = router;
