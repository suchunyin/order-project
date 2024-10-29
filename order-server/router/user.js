const express = require("express");
const router = express.Router();

const { user } = require("../router_handler/models");

router.get("/user/info", async (req, res) => {
  let userinfo = await user.findOne({
    where: { isDeleted: 0, id: req.query.id },
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

module.exports = router;
