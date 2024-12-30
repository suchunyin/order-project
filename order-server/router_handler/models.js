const { DB, Sequelize } = require("./dbConfig");

const productType = DB.define("product_type", {
  id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    field: "id",
    autoIncrement: true,
  },
  name: Sequelize.STRING(30),
  image: Sequelize.STRING(300),
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
  orderType: Sequelize.INTEGER,     //订单类型：1 "自提" , 2 "外卖"
  amount: Sequelize.INTEGER,        //交易金额
  dealNum: Sequelize.INTEGER,       //订单数量
  code: Sequelize.STRING(100),      //取餐码
  phone: Sequelize.STRING(300),     //客户联系电话
  remark: Sequelize.TEXT,           //客户备注
  userId: Sequelize.STRING(300),    //客户id
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
  account: Sequelize.STRING(100),
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
const admin = DB.define("admin", {
  id: {
    primaryKey: true,
    type: Sequelize.INTEGER,
    field: "id",
    autoIncrement: true,
  },
  account: Sequelize.STRING(100),
  name: Sequelize.STRING(100),
  avatar: Sequelize.STRING(100),
  desc: Sequelize.TEXT,
  phone: Sequelize.STRING(300),
  openingTime: Sequelize.TIME,
  closingTime: Sequelize.TIME,
  minPriceDelivery: Sequelize.INTEGER,
  address: Sequelize.TEXT,
  isDeleted: {
    type: Sequelize.TINYINT,
    defaultValue: "0",
    field: "isDeleted",
  },
});
module.exports = { productType, product, order, recommend, user, admin };
