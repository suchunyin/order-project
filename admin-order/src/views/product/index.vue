<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { productApi } from "../interface";
import { getProductList, deleteProduct, getTypeList } from "@/http/api/product";
import { ElMessage } from "element-plus";

const router = useRouter();
const route = useRoute();
const handleAdd = () => {
  router.push("/product/addProduct");
};
let isAdd = computed(() => route.fullPath === "/product/addProduct");

const handleDelete = async (item: any) => {
  const { msg }: any = await deleteProduct(item);
  ElMessage({ type: "success", message: msg });
  getTableData();
};

let tableData = ref<Array<productApi>>(null);
let typeList = ref(null);
const getTableData = async () => {
  const list = await getProductList();
  typeList.value = await getTypeList();
  tableData.value = list as productApi[];
};
const typeNameFormat = (typeId: any) => {
  const type = typeList.value.find((v: { id: any }) => v.id === typeId);
  return type.name;
};
onMounted(() => {
  !isAdd.value && getTableData();
});
</script>

<template>
  <div class="main-container" v-if="!isAdd">
    <div class="top">
      <el-button type="primary" @click="handleAdd">新增商品</el-button>
    </div>
    <el-table class="table-wrapper" :data="tableData" style="width: 100%">
      <el-table-column label="商品图片" width="150">
        <template #default="scope">
          <el-image
            class="product-image"
            v-if="scope.row.image"
            :src="scope.row.image"
          />
        </template>
      </el-table-column>
      <el-table-column prop="name" label="商品" width="260" />
      <el-table-column label="所属类目" width="220">
        <template #default="scope">
          <span>{{ typeNameFormat(scope.row.typeId) }}</span>
        </template>
      </el-table-column>
      <el-table-column prop="defaultPrice" label="价格" width="150" />
      <el-table-column prop="totalStore" label="库存" width="150" />
      <el-table-column prop="sales" label="销量" width="150" />
      <el-table-column label="操作" min-width="120">
        <template #default="scope">
          <el-button
            type="danger"
            size="small"
            @click="handleDelete(scope.row)"
          >
            删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
  <div class="main-container" v-else><router-view /></div>
</template>

<style lang="scss" scoped>
.main-container {
  background-color: #fff;
  margin-top: 20px;
  padding: 20px;
  height: 90%;
  .top {
    width: 100%;
    text-align: end;
  }
  .product-image {
    width: 30px;
    height: 30px;
  }
  .table-wrapper {
    height: 95%;
    overflow: auto;
  }
}
</style>
