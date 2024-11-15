<script setup lang="ts">
import { ref, onMounted, computed, reactive } from "vue";
import { orderApi } from "../interface";
import { getOrderList } from "@/http/api/order";

let tableData = ref<Array<orderApi>>(null);
const getTableData = async () => {
  const list = await getOrderList();
  tableData.value = list as orderApi[];
};
let isOpen = ref<boolean>(false);
let detail = reactive<orderApi>({
  id: null,
  orderType: null,
  amount: null,
  dealNum: null,
  code: "",
  phone: "",
  remark: "",
  userId: "",
  product: [],
  createdAt: "",
});
const handleOpenDetail = (row: any) => {
  isOpen.value = true;
  detail = { ...row };
};
const timeFormat = (t: string) => t.split(/T|\./, 2).join(" ");
const orderTypeFormat = (ot: number) => (ot == 1 ? "到店取餐" : "外卖到家");
onMounted(() => {
  getTableData();
});
</script>

<template>
  <div class="main-container">
    <el-table class="table-wrapper" :data="tableData" style="width: 100%">
      <el-table-column prop="createdAt" label="交易时间" width="300">
        <template #default="scope">
          {{ timeFormat(scope.row.createdAt) }}
        </template>
      </el-table-column>
      <el-table-column prop="orderType" label="订单类型" width="220">
        <template #default="scope">
          {{ orderTypeFormat(scope.row.orderType) }}
        </template>
      </el-table-column>
      <el-table-column prop="amount" label="交易金额" width="220" />
      <el-table-column prop="dealNum" label="订单数量" width="220" />
      <el-table-column label="操作" min-width="120">
        <template #default="scope">
          <el-button
            type="primary"
            size="small"
            @click="handleOpenDetail(scope.row)"
          >
            订单详情
          </el-button>
        </template>
      </el-table-column>
    </el-table>
    <el-drawer
      v-model="isOpen"
      class="detail-wrapper"
      :title="orderTypeFormat(detail.orderType)"
      direction="rtl"
      size="40%"
    >
      <el-table :data="detail.product">
        <el-table-column property="name" label="商品" width="150" />
        <el-table-column property="attribute" label="规格" width="150" />
        <el-table-column property="num" label="数量" width="150" />
        <el-table-column property="price" label="小计" min-width="120" />
      </el-table>
      <div class="info">
        <div class="item">
          <span class="label">订单类型</span>
          <span class="value">{{ orderTypeFormat(detail.orderType) }}</span>
        </div>
        <div class="item">
          <span class="label">取餐码</span>
          <span class="value">{{ detail.code }}</span>
        </div>
        <div class="item">
          <span class="label">联系电话</span>
          <span class="value">{{ detail.phone }}</span>
        </div>
        <div class="item">
          <span class="label">交易金额</span>
          <span class="value">{{ detail.amount }}</span>
        </div>
        <div class="item">
          <span class="label">下单时间</span>
          <span class="value">{{ timeFormat(detail.createdAt) }}</span>
        </div>
        <div class="item">
          <span class="label">客户备注</span>
          <span class="value">{{ detail.remark || "无" }}</span>
        </div>
      </div>
    </el-drawer>
  </div>
</template>

<style lang="scss" scoped>
.main-container {
  background-color: #fff;
  margin-top: 20px;
  padding: 20px;
  height: 90%;
  .table-wrapper {
    max-height: 100%;
    overflow: auto;
  }
  ::v-deep .el-drawer__title {
    text-align: left;
  }
  .detail-wrapper {
    .info {
      display: flex;
      flex-direction: column;
      align-items: flex-start;
      margin: 20px 0;
      .item {
        display: grid;
        grid-template-columns: 30% 70%;
        text-align: left;
        width: 50%;
        margin-bottom: 10px;
        .label {
          font-weight: 600;
        }
      }
    }
  }
}
</style>
