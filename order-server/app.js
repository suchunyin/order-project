const port = 3009;
process.env.baseUrl = "http://127.0.0.1:" + port;
process.env.secret_key = "login_to_order2024";

const express = require("express");
const expressWs = require("express-ws");
const app = express();
expressWs(app);
app.listen(port, () => {
  console.log(process.env.baseUrl + " 服务启动");
});

// 导入并配置cors中间件
const cors = require("cors");
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// 解析token中间件
const expressJwt = require("express-jwt");
console.log(expressJwt);
app.use(
  expressJwt
    .expressjwt({
      secret: process.env.secret_key,
      algorithms: ["HS256"],
    })
    .unless({
      path: [
        "/api/admin/login",
        "/api/user/login",
        /^\/image/,
        "/api/product/productList",
        "/api/productType/typeList",
        "/api/recommend/list",
      ],
    })
);

// 路由
app.use("/api", require("./router/product"));
app.use("/api", require("./router/order"));
app.use("/api", require("./router/user"));
app.use("/api", require("./router/chat"));

// 错误处理中间件
const { errorHandler } = require("./middleware");
app.use(errorHandler);

app.use(express.static("resource"));
