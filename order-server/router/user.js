const express = require("express");
const router = express.Router();

const { user, admin } = require("../router_handler/models");
const jwt = require("jsonwebtoken");

router.get("/user/info", async (req, res) => {
  let userinfo = await user.findOne({
    where: { isDeleted: 0, account: req.auth.account, },
    raw: true,
  });
  userinfo.addressObj = JSON.parse(userinfo.addressObj || "[]");
  // userinfo.avatar && (userinfo.avatar = process.env.baseUrl + userinfo.avatar);

  res.json({
    code: 200,
    msg: "",
    res: userinfo,
  });
});
router.post("/user/login", async (req, res) => {
  if ((!req.body.account && !req.body.phone) || !req.body.password) {
    return res.json({
      code: 400,
      msg: "账号或密码不能为空",
      res: null,
    });
  }
  let params = { password: req.body.password };
  if (req.body.account) params.account = req.body.account;
  if (req.body.phone) params.account = req.body.phone;
  let info = await user.findOne({
    where: {
      isDeleted: 0,
      ...params,
    },
    raw: true,
  });
  if (!info) {
    return res.status(400).json({
      code: 400,
      msg: "账号或密码错误",
      res: null,
    });
  }

  const token = jwt.sign(
    { account: info.account, phone: info.phone, id: info.id },
    process.env.secret_key,
    { expiresIn: "1h" }
  );
  res.json({
    code: 200,
    msg: "登录成功",
    res: { token, info },
  });
});
router.post("/admin/login", async (req, res) => {
  if (!req.body.account || !req.body.password) {
    return res.json({
      code: 400,
      msg: "账号或密码不能为空",
      res: null,
    });
  }
  let info = await admin.findOne({
    where: {
      isDeleted: 0,
      account: req.body.account,
      password: req.body.password,
    },
    raw: true,
  });
  if (!info) {
    return res.status(400).json({
      code: 400,
      msg: "账号或密码错误",
      res: null,
    });
  }

  const token = jwt.sign(
    { account: info.account, id: info.id },
    process.env.secret_key,
    { expiresIn: "1h" }
  );
  res.json({
    code: 200,
    msg: "登录成功",
    res: { token, info },
  });
});
router.get("/admin/info", async (req, res) => {
  let info = await admin.findOne({
    where: {
      isDeleted: 0,
      account: req.auth.account,
    },
    raw: true,
  });
  res.json({
    code: 200,
    msg: "",
    res: { ...info },
  });
});
router.post("/admin/update", async (req, res) => {
  await admin.update(
    { ...req.body },
    {
      where: {
        isDeleted: 0,
        account: req.auth.account,
      },
    }
  );
  res.json({
    code: 200,
    msg: "",
    res: "",
  });
});
module.exports = router;
