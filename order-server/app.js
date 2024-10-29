const port = 3009;
process.env.baseUrl = "http://127.0.0.1:" + port;

const express = require("express");
const app = express();

app.listen(port, () => {
  console.log(process.env.baseUrl + " 服务启动");
});

// 导入并配置cors中间件
const cors = require("cors");
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.use("/api", require("./router/product"));
app.use("/api", require("./router/order"));
app.use("/api", require("./router/user"));
app.use((err, req, res, next) => {
  console.log("错误: ", err.message);
  res.send(err.message);
  // next();
});

app.use(express.static("resource"));
