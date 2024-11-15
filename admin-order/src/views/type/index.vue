<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { typeApi } from "../interface";
import { getTypeList, deleteType } from "@/http/api/product";
import { ElMessage } from "element-plus";

const router = useRouter();
const route = useRoute();
const handleAdd = () => {
  router.push("/type/addType");
};
let isAdd = computed(() => route.fullPath === "/type/addType");

const handleDelete = async (item: any) => {
  const { msg }: any = await deleteType(item);
  ElMessage({ type: "success", message: msg });
  getTableData();
};

let tableData = ref<Array<typeApi>>(null);
const getTableData = async () => {
  const list = await getTypeList();
  tableData.value = list as typeApi[];
  tableData.value.forEach((v: any) => {
    v.productNum = v.productList.length;
  });
};
onMounted(() => {
  !isAdd.value && getTableData();
});
</script>

<template>
  <div class="main-container" v-if="!isAdd">
    <div class="top">
      <el-button type="primary" @click="handleAdd">新增类目</el-button>
    </div>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column prop="name" label="类目" width="320" />
      <el-table-column label="图标" width="300">
        <template #default="scope">
          <el-image
            class="type-image"
            v-if="scope.row.image"
            :src="scope.row.image"
          />
        </template>
      </el-table-column>
      <el-table-column prop="productNum" label="商品数量" width="300" />
      <el-table-column label="操作" min-width="320">
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
  <div v-else><router-view /></div>
</template>

<style lang="scss" scoped>
.main-container {
  background-color: #fff;
  margin-top: 20px;
  padding: 20px;
  .top {
    width: 100%;
    text-align: end;
  }
  .type-image {
    width: 30px;
    height: 30px;
  }
}
</style>
