<script setup lang="ts">
import { ref, onMounted, computed } from "vue";
import { useRoute, useRouter } from "vue-router";
import { recommendApi } from "../interface";
import { getRecommendList, deleteRecommend } from "@/http/api/product";
import { ElMessage } from "element-plus";

const router = useRouter();
const route = useRoute();
const handleAdd = () => {
  router.push("/home/addRecommend");
};
let isAdd = computed(() => route.fullPath === "/home/addRecommend");

const handleDelete = async (item: any) => {
  const { msg }: any = await deleteRecommend(item);
  ElMessage({ type: "success", message: msg });
  getTableData();
};

let tableData = ref<Array<recommendApi>>(null);
const getTableData = async () => {
  const list = await getRecommendList();
  tableData.value = list as recommendApi[];
};
onMounted(() => {
  !isAdd.value && getTableData();
});
</script>

<template>
  <div class="main-container" v-if="!isAdd">
    <div class="top">
      <el-button type="primary" @click="handleAdd">新增推荐</el-button>
    </div>
    <el-table :data="tableData" style="width: 100%">
      <el-table-column label="封面图" width="300">
        <template #default="scope">
          <el-image
            class="cover-image"
            v-if="scope.row.cover"
            :src="scope.row.cover"
          />
        </template>
      </el-table-column>
      <el-table-column prop="name" label="关联商品" width="300" />
      <el-table-column prop="defaultPrice" label="价格" width="220" />
      <el-table-column prop="totalStore" label="库存" width="220" />
      <el-table-column prop="sales" label="销量" width="220" />
      <el-table-column label="操作">
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
  .cover-image {
    width: 30px;
    height: 30px;
  }
}
</style>
