const { DB, Sequelize } = require("./dbConfig");

const productType = DB.define("product_type", {
  id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    field: "id",
    autoIncrement: true,
  },
  name: Sequelize.STRING(30),
  img: Sequelize.STRING(300),
  isDeleted: {
    type: Sequelize.TINYINT,
    defaultValue: "0",
    field: "isDeleted",
  },
});
const product = DB.define("product", {
  id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    field: "id",
    autoIncrement: true,
  },
  name: Sequelize.STRING(100),
  describe: Sequelize.TEXT,
  image: Sequelize.STRING(300),
  defaultPrice: {
    type: Sequelize.INTEGER,
    defaultValue: null,
    field: "defaultPrice",
    comment: "默认最低价",
  },
  sales: Sequelize.INTEGER,
  typeId: Sequelize.INTEGER,
  price: Sequelize.STRING(300),
  totalStore: Sequelize.INTEGER,
  attribute: Sequelize.STRING(300),
  isDeleted: {
    type: Sequelize.TINYINT,
    defaultValue: "0",
    field: "isDeleted",
  },
});

const order = DB.define("order", {
  id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    field: "id",
    autoIncrement: true,
  },
  orderType: Sequelize.INTEGER,
  amount: Sequelize.INTEGER,
  dealNum: Sequelize.INTEGER,
  code: Sequelize.STRING(100),
  phone: Sequelize.STRING(300),
  remark: Sequelize.TEXT,
  userId: Sequelize.STRING(300),
  product: Sequelize.TEXT,
  isDeleted: {
    type: Sequelize.TINYINT,
    defaultValue: "0",
    field: "isDeleted",
  },
});
const recommend = DB.define("product", {
  id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    field: "id",
    autoIncrement: true,
  },
  cover: Sequelize.STRING(300),
  isRecommend: {
    type: Sequelize.TINYINT,
    defaultValue: "0",
    field: "isRecommend",
  },
  isDeleted: {
    type: Sequelize.TINYINT,
    defaultValue: "0",
    field: "isDeleted",
  },
});
const user = DB.define("user", {
  id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    field: "id",
    autoIncrement: true,
  },
  name: Sequelize.STRING(100),
  avatar: Sequelize.STRING(100),
  phone: Sequelize.STRING(300),
  addressObj: Sequelize.TEXT,
  isDeleted: {
    type: Sequelize.TINYINT,
    defaultValue: "0",
    field: "isDeleted",
  },
});
module.exports = { productType, product, order, recommend, user };
