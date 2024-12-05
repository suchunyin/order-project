<script lang="ts" setup>
import { ref, reactive, onMounted } from "vue";
import { addRecommend } from "@/http/api/product";
import { useRouter } from "vue-router";
import { ElMessage } from "element-plus";
import uploadImage from "@/components/uploadImage.vue";
import { productApi } from "../interface";
import { getProductList, getTypeList } from "@/http/api/product";

const form = reactive({ id: "", cover: "" });
let isSubmit = ref<boolean>(false);
const handleSubmit = async () => {
  if (!form.id || !form.cover) {
    ElMessage({
      type: "warning",
      message: !form.id ? "关联商品不能为空！" : "请上传封面图片！",
    });
    return;
  }
  const { msg }: any = await addRecommend(form);
  ElMessage({ type: "success", message: msg });
  isSubmit.value = true;
  handleBack();
};

const setCover = (img: string) => {
  form.cover = img;
};

const router = useRouter();
const handleBack = () => {
  router.push("/home");
};

let tableData = ref<Array<productApi>>(null);
let typeList = ref(null);
let selectProduct = ref([]);
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
  getTableData();
});
const handleSelectProduct = (row: any) => {
  selectProduct.value = [row];
  form.id = row.id;
};
</script>

<template>
  <div class="main-container">
    <div class="back-btn">
      <el-button @click="handleBack">返回</el-button>
      <el-button type="primary" @click="handleSubmit"> 提交 </el-button>
    </div>
    <el-form :model="form" label-width="auto">
      <el-form-item label="封面图">
        <uploadImage
          :fileKey="'recommend'"
          :isSubmit="isSubmit"
          @setImg="setCover"
        ></uploadImage>
      </el-form-item>
      <el-form-item v-show="form.id" label="已选择商品">
        <el-table size="small" :data="selectProduct" style="width: 100%">
          <el-table-column prop="name" label="商品" width="360" />
          <el-table-column prop="defaultPrice" label="价格" width="300" />
          <el-table-column prop="sales" label="销量" width="300" />
          <el-table-column label="所属类目">
            <template #default="scope">
              <span>{{ typeNameFormat(scope.row.typeId) }}</span>
            </template>
          </el-table-column>
        </el-table>
      </el-form-item>
      <el-form-item label="选择关联商品">
        <el-table
          size="small"
          class="table-wrapper"
          :data="tableData"
          style="width: 100%"
          height="500"
          highlight-current-row
          @row-click="handleSelectProduct"
        >
          <el-table-column prop="name" label="商品" width="360" />
          <el-table-column prop="defaultPrice" label="价格" width="300" />
          <el-table-column prop="sales" label="销量" width="300" />
          <el-table-column label="所属类目">
            <template #default="scope">
              <span>{{ typeNameFormat(scope.row.typeId) }}</span>
            </template>
          </el-table-column>
        </el-table>
      </el-form-item>
    </el-form>
  </div>
</template>

<style lang="scss" scoped>
.main-container {
  background-color: #fff;
  margin-top: 20px;
  padding: 20px;
  .back-btn {
    text-align: left;
    padding-bottom: 20px;
  }
  .img-wrapper {
    width: 100%;
    height: 100%;
    position: relative;
    .img-thumbnail {
      width: 100%;
      height: 100%;
      border-radius: 6px;
    }

    .img-actions {
      display: none;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      color: #fff;
    }
    .img-action-item + .img-action-item {
      padding-left: 20px;
    }
    &:hover .img-actions {
      display: block;
    }
    &:hover::before {
      content: "";
      position: absolute;
      width: 100%;
      height: 100%;
      background-color: #0000006e;
      border-radius: 6px;
    }
  }
}
</style>
