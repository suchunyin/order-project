<script setup lang="ts">
import { ref, onMounted, computed, reactive, nextTick } from "vue";
import { updateInfo } from "@/http/api/user";
import { ElMessage } from "element-plus";
import { useStore } from "vuex";
import UploadImage from "@/components/uploadImage.vue";

const store = useStore();
const userInfo = computed(() => store.state.userInfo);
const settings = reactive([
  { label: "店铺logo", prop: "avatar", edit: false, avatar: "" },
  { label: "店铺名称", prop: "name", edit: false },
  { label: "店铺介绍", prop: "desc", edit: false },
  {
    label: "营业时间",
    prop: "time",
    edit: false,
    openingTime: null,
    closingTime: null,
  },
  { label: "店铺电话", prop: "phone", edit: false },
  { label: "外卖起送价(元)", prop: "minPriceDelivery", edit: false },
  { label: "店铺地址", prop: "address", edit: false },
]);
let isLogoSubmit = ref(false);
const setLogo = (val: string) => {
  settings.forEach((item) => {
    if (item.prop == "avatar") item.avatar = val;
  });
};
const handleEdit = (item: any) => {
  item[item.prop] = userInfo.value[item.prop];
  if (item.prop === "time") {
    item.openingTime = userInfo.value.openingTime;
    item.closingTime = userInfo.value.closingTime;
  }
  item.edit = true;
};
const handleSave = (prop: any, item) => {
  let params = {};
  if (prop !== "time") params[prop] = item[prop];
  else
    params = {
      openingTime: item.openingTime,
      closingTime: item.closingTime,
    };
  updateInfo(params).then((res) => {
    if (prop == "avatar") isLogoSubmit.value = true;
    ElMessage.success(res.msg || "保存成功");
    store.dispatch("UserInfo");
    nextTick(() => {
      item.edit = false;
    });
  });
};
onMounted(() => {});
</script>

<template>
  <div class="main-container">
    <template v-for="item in settings">
      <div class="item">
        <div class="label">{{ item.label }}</div>
        <div class="content" v-if="item.prop == 'avatar'">
          <el-image
            v-if="!item.edit"
            style="width: 100px; height: 100px"
            :src="userInfo.avatar"
            :preview-src-list="[userInfo.avatar]"
            alt=""
          />
          <UploadImage
            v-else
            :fileKey="'user'"
            :isSubmit="isLogoSubmit"
            @setImg="setLogo"
          />
        </div>
        <div class="content" v-else-if="item.prop == 'time'">
          <div v-if="!item.edit">
            {{ userInfo.openingTime }} —— {{ userInfo.closingTime }}
          </div>
          <div v-else>
            <el-time-select
              v-model="item.openingTime"
              style="width: 240px"
              :max-time="item.closingTime"
              placeholder="开始时间"
              start="08:30"
              step="00:15"
              end="18:30"
            />
            <el-time-select
              v-model="item.closingTime"
              style="width: 240px"
              :min-time="item.openingTime"
              placeholder="结束时间"
              start="08:30"
              step="00:15"
              end="22:30"
            />
          </div>
        </div>
        <div class="content" v-else>
          <div v-if="!item.edit">{{ userInfo[item.prop] }}</div>
          <el-input v-else v-model="item[item.prop]"></el-input>
        </div>
        <div class="btn">
          <el-button v-if="!item.edit" link @click="handleEdit(item)">
            修改
          </el-button>
          <el-button
            v-else
            link
            type="primary"
            @click="handleSave(item.prop, item)"
          >
            保存
          </el-button>
        </div>
      </div>
      <el-divider border-style="dotted" />
    </template>
  </div>
</template>

<style lang="scss" scoped>
.main-container {
  background-color: #fff;
  margin-top: 20px;
  padding: 50px 30px;

  .cover-image {
    width: 30px;
    height: 30px;
  }
  .item {
    display: flex;
    justify-content: space-between;
    .label {
      width: 200px;
      text-align: left;
      color: #777;
    }
    .content {
      width: 100%;
      text-align: left;
      margin-right: 20px;
    }
  }
}
</style>
