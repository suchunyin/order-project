<script lang="ts" setup>
import { ref, reactive } from "vue";
import { addType } from "@/http/api/product";
import { useRouter } from "vue-router";
import { ElMessage } from "element-plus";
import uploadImage from "@/components/uploadImage.vue";

const form = reactive({ name: "", image: "" });
let isSubmit = ref<boolean>(false);
const handleSubmit = async () => {
  if (!form.name) {
    ElMessage({ type: "warning", message: "类目名称不能为空！" });
    return;
  }
  const { msg }: any = await addType(form);
  ElMessage({ type: "success", message: msg });
  isSubmit.value = true;
  handleBack();
};

const setImg = (img: string) => {
  form.image = img;
};

const router = useRouter();
const handleBack = () => {
  router.push("/type");
};
</script>

<template>
  <div class="main-container">
    <div class="back-btn">
      <el-button type="primary" @click="handleBack">返回</el-button>
    </div>
    <el-form :model="form" label-width="auto" style="max-width: 600px">
      <el-form-item label="类目名称">
        <el-input v-model="form.name" />
      </el-form-item>
      <el-form-item label="类目图标">
        <uploadImage
          :fileKey="'type'"
          :isSubmit="isSubmit"
          @setImg="setImg"
        ></uploadImage>
      </el-form-item>
    </el-form>
    <el-button type="primary" @click="handleSubmit">提交</el-button>
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
