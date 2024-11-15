const express = require("express");
const router = express.Router();

const { order } = require("../router_handler/models");
const { isSameDay } = require("../middleware");

const orderState = (req, res, next) => {
  console.log(res.res);
  next();
};

// 订单查询
router.get("/order/orderList", orderState, async (req, res) => {
  let list;
  if (req.query.role === "admin") {
    list = await order.findAll({
      where: { isDeleted: 0 },
      order: [["id", "DESC"]],
      raw: true,
    });
  } else {
    list = await order.findAll({
      where: { isDeleted: 0, userId: req.query.id },
      order: [["id", "DESC"]],
      raw: true,
    });
  }
  list = list.map((v) => {
    v.product = JSON.parse(v.product || "[]");
    return v;
  });

  res.json({
    code: 200,
    msg: "",
    res: list,
  });
});
router.get("/order/:id", async (req, res) => {
  let info = await order.findOne({
    where: { isDeleted: 0, id: req.params.id },
    raw: true,
  });
  info.product = JSON.parse(info.product || "[]");

  res.json({
    code: 200,
    msg: "",
    res: info,
  });
});

// 订单增加
router.post("/order/add", async (req, res) => {
  const lastId = await order.max("id", { where: { isDeleted: 0 } });
  const last = await order.findOne({ where: { id: lastId }, raw: true });

  let code = "1001";
  if (isSameDay(new Date(last.createdAt), new Date())) {
    code = Number(last.code) + 1 + "";
  }
  req.body.product = JSON.stringify(req.body.product);
  req.body.code = code;
  console.log(req.body);

  const ins = await order.create(
    { ...req.body },
    {
      fields: [
        `orderType`,
        `amount`,
        `dealNum`,
        `code`,
        `phone`,
        `remark`,
        `userId`,
        `product`,
      ],
    }
  );
  ins.product = JSON.parse(ins.product || "[]");
  res.json({
    code: 200,
    msg: "下单成功！",
    res: ins,
  });
});
// 订单删除
router.post("/order/delete", async (req, res) => {
  await order.update({ isDeleted: 1 }, { where: { id: req.body.id } });
  // const del = await productType.destroy({ where: { id: req.body.id } });
  res.json({
    code: 200,
    msg: "删除成功！",
  });
});

module.exports = router;
