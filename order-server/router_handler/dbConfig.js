const Sequelize = require("sequelize");

const DB = new Sequelize("order", "root", "root", {
  dialect: "mysql",
  host: "localhost",
  port: 3306,
  pool: {
    max: 5,
    min: 0,
    idle: 30 * 1000, // 如果一个线程30秒内没有被使用，那么就释放线程
  },
  define: {
    freezeTableName: true,
    // timestamps: false,
  },
});

DB.authenticate()
  .then(() => {
    console.log("数据库连接成功");
  })
  .catch((err) => {
    console.error("数据库连接错误：" + err);
  });

module.exports = { DB, Sequelize };
