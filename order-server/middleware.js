const moment = require("moment");
const isSameDay = (d1, d2) => {
  return moment(d1).isSame(d2, "day");
};

const multer = require("multer");
const path = require("path");
const fullpath = path.resolve(__dirname, "resource/");
const upload = (req, res, next) => {
  let field = req.params.field;
  let spath = path.join(fullpath, "image/" + field);
  let storage = multer.diskStorage({
    destination: (req, file, cb) => {
      if (file.mimetype === "image/jpeg" || file.mimetype === "image/png")
        cb(null, spath);
      else cb({ error: "不支持上传该文件类型！" });
    },
    filename: (req, file, cb) => {
      const ft = file.originalname.split("."); //文件类型格式
      const filename =
        moment().format("YYYYMMDDHHmmss") + "." + ft[ft.length - 1];
      cb(null, filename);
    },
  });
  const multerConfig = multer({ storage });
  multerConfig.single(field)(req, res, (err) => {
    if (err) {
      console.log(err);
      res.json({ err: err, msg: "上传图片失败" });
    } else {
      req.image = `/image/${field}/${req.file.filename}`;
      next();
    }
  });
};
const fs = require("fs");
const removeImage = (req, res, next) => {
  const { image } = req.body;
  if(!image) next();
  fs.unlink(path.join(fullpath, image), (err) => {
    if (err) {
      res.json({ msg: "删除图片失败", err: err });
    } else next();
  });
};
module.exports = { isSameDay, upload, removeImage };
