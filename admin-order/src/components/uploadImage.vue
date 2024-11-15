<script setup lang="ts">
import { ref, defineEmits, defineProps, onUnmounted } from "vue";
import { uploadImg, removeImg } from "@/http/api/product";

const props = defineProps({ fileKey: String, isSubmit: Boolean });
let imgUrl = ref("");
const emit = defineEmits(["setImg"]);
const handleUpload = async ({ file }) => {
  const { image }: any = await uploadImg(file, props.fileKey);
  imgUrl.value = image;
  emit("setImg", imgUrl.value);
};

const dialogImageUrl = ref("");
const dialogVisible = ref(false);

const handleRemove = () => {
  if (!imgUrl.value) return;
  removeImg(imgUrl.value).then(() => {
    imgUrl.value = "";
    emit("setImg", imgUrl.value);
  });
};

const handlePictureCardPreview = () => {
  dialogImageUrl.value = imgUrl.value!;
  dialogVisible.value = true;
};

onUnmounted(() => {
  !props.isSubmit && handleRemove();
});
</script>

<template>
  <el-upload
    action="#"
    :show-file-list="false"
    :http-request="handleUpload"
    accept=".png,.jpg,.jpeg"
    list-type="picture-card"
  >
    <el-icon v-if="!imgUrl"><Plus /></el-icon>
    <template v-else>
      <div class="img-wrapper">
        <img class="img-thumbnail" :src="imgUrl" alt="" />
        <span class="img-actions">
          <span class="img-action-item" @click.stop="handlePictureCardPreview">
            <el-icon><zoom-in /></el-icon>
          </span>
          <span class="img-action-item" @click.stop="handleRemove">
            <el-icon><Delete /></el-icon>
          </span>
        </span>
      </div>
    </template>
  </el-upload>
  <el-dialog v-model="dialogVisible">
    <img w-full style="width: 100%" :src="dialogImageUrl" alt="Preview Image" />
  </el-dialog>
</template>

<style lang="scss" scoped>
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
    font-size: 26px;
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
</style>
