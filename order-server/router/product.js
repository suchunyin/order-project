const express = require("express");
const router = express.Router();

const { productType, product, recommend } = require("../router_handler/models");
router.use((req, res, next) => {
  console.log("--------------------------");
  console.log("time:", new Date());
  next();
});

const { upload, removeImage } = require("../middleware");
router.post("/uploadImage/:field", upload, (req, res) => {
  res.json({
    code: 200,
    msg: "图片上传成功！",
    // res: { file: req.file },
    res: { info: req.params, image: req.image, filename: req.file.filename },
  });
});
router.post("/removeImage", removeImage, (req, res) => {
  res.json({
    code: 200,
    msg: "图片删除成功！",
  });
});

// 商品列表查询
router.get("/product/productList", async (req, res) => {
  // 查询商品
  let productList = await product.findAll({
    where: { isDeleted: 0 },
    raw: true,
  });
  // 转换json
  productList = productList.map((v) => {
    v.price = v.price ? JSON.parse(v.price) : v.price;
    v.attribute = v.attribute ? JSON.parse(v.attribute) : v.attribute;
    return v;
  });
  res.json({
    code: 200,
    msg: "",
    res: productList,
  });
});
// 商品增加
router.post("/product/add", async (req, res) => {
  req.body.price = JSON.stringify(req.body.price);
  req.body.attribute = JSON.stringify(req.body.attribute);
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
router.post("/product/delete", removeImage, async (req, res) => {
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
  // 查询商品类型、商品
  let type = await productType.findAll({
    where: { isDeleted: 0 },
    raw: true,
  });
  let productList = await product.findAll({
    where: { isDeleted: 0 },
    raw: true,
  });
  // 转换json
  productList = productList.map((v) => {
    v.price = v.price ? JSON.parse(v.price) : v.price;
    v.attribute = v.attribute ? JSON.parse(v.attribute) : v.attribute;
    return v;
  });
  for (let i = 0; i < type.length; i++) {
    // 商品 拼接类型
    type[i].productList = productList.filter((v) => v.typeId == type[i].id);
  }
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
      fields: [`name`, `image`],
    }
  );
  res.json({
    code: 200,
    msg: "新增成功！",
    // res: ins,
  });
});
// 类型删除
router.post("/productType/delete", removeImage, async (req, res) => {
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

// 商品推荐查询
router.get("/recommend/list", async (req, res) => {
  const productList = await product.findAll({
    where: { isDeleted: 0, isRecommend: 1 },
    raw: true,
  });
  const recommendList = await recommend.findAll({
    where: { isDeleted: 0 },
    raw: true,
  });

  // 转换json,拼接推荐信息
  const list = productList.map((v) => {
    v.price = v.price ? JSON.parse(v.price) : v.price;
    v.attribute = v.attribute ? JSON.parse(v.attribute) : v.attribute;
    let rec = recommendList.find((r) => r.id == v.id);
    return { ...v, ...rec };
  });
  res.json({
    code: 200,
    msg: "",
    res: list,
  });
});
// 商品推荐增加
router.post("/recommend/add", async (req, res) => {
  const ins = await recommend.update(
    { ...req.body, isRecommend: 1 },
    { where: { id: req.body.id } }
  );
  res.json({
    code: 200,
    msg: "新增成功！",
    // res: ins,
  });
});
const coverChange = (req, res, next) => {
  req.body.image = req.body.cover; // 删除封面图片文件
  next();
};
// 商品推荐删除
router.post(
  "/recommend/delete",
  [coverChange, removeImage],
  async (req, res) => {
    const del = await recommend.update(
      { cover: null, isRecommend: 0 },
      { where: { id: req.body.id } }
    );
    res.json({
      code: 200,
      msg: "删除成功！",
      // res: del,
    });
  }
);

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
