<script lang="ts" setup>
import { ref, reactive, onMounted, watch } from "vue";
import { addProduct, getTypeList } from "@/http/api/product";
import { useRouter } from "vue-router";
import { ElMessage } from "element-plus";
import uploadImage from "@/components/uploadImage.vue";
import { productApi, productPrice, productAttribute } from "../interface";

let form = reactive<productApi>({
  name: "",
  describe: "",
  image: "",
  defaultPrice: null,
  sales: 0,
  typeId: null,
  price: [],
  totalStore: 0,
  attribute: [],
});
let price = ref<productPrice[]>([]);
let attribute = ref<productAttribute[]>([
  { name: "规格", items: ["中杯", "大杯"] },
]);

let isSubmit = ref<boolean>(false);
const handleSubmit = async () => {
  form.price = [...price.value];
  form.attribute = [...attribute.value];
  form.defaultPrice = Math.min(...price.value.map((p) => p.price));
  form.totalStore = 0;
  price.value.forEach((p) => (form.totalStore += p.store));
  console.log(form);
  const { msg }: any = await addProduct(form);
  ElMessage({ type: "success", message: msg });
  isSubmit.value = true;
  handleBack();
};

const setImg = (img: string) => {
  form.image = img;
};

const router = useRouter();
const handleBack = () => {
  router.push("/product");
};
let typeList = ref(null);
onMounted(async () => {
  typeList.value = await getTypeList();
});

watch(
  attribute,
  (newVal, oldVal) => {
    // 同步price的size属性和attribute的规格
    newVal.forEach((item) => {
      if (item.name === "规格") {
        item.items.forEach((_size) => {
          if (!_size) return;
          // 如果没有此规格则在price中增加
          let index = price.value.findIndex((p) => p.size === _size);
          if (index === -1)
            price.value.push({
              size: _size,
              price: null,
              store: null,
            });
        });
        // 删除price中多余的规格
        price.value = price.value.filter((p) => item.items.includes(p.size));
      }
    });
  },
  { deep: true, immediate: true }
);
const handleAttributeAdd = () => {
  attribute.value.push({ name: "", items: [""] });
};
const handleAttributeDel = (index: any, row: any[]) => {
  row.splice(index, 1);
};
const addAttributeSon = (row: string[]) => {
  row.push("");
};
const delAttributeSon = (index: any, row: any[]) => {
  row.splice(index, 1);
};
const attNameChange = (value: string, index: number) => {
  // 是否存在该属性名
  if (
    value == "" ||
    attribute.value.findIndex(
      (a, aindex) => a.name === value && aindex !== index
    ) === -1
  )
    return;
  attribute.value[index].name = "";
  ElMessage({ type: "info", message: "已存在该属性" });
};
</script>

<template>
  <div class="add-container">
    <div class="back-btn">
      <el-button type="primary" @click="handleBack">返回</el-button>
    </div>
    <el-form :model="form" label-width="auto" style="max-width: 600px">
      <el-form-item label="商品分类">
        <el-select v-model="form.typeId" placeholder="选择商品分类" filterable>
          <el-option
            v-for="item in typeList"
            :key="item.id"
            :label="item.name"
            :value="item.id"
          />
        </el-select>
      </el-form-item>
      <el-form-item label="商品图片">
        <uploadImage
          :fileKey="'product'"
          :isSubmit="isSubmit"
          @setImg="setImg"
        ></uploadImage>
      </el-form-item>
      <el-form-item label="商品名称">
        <el-input v-model="form.name" />
      </el-form-item>
      <el-form-item label="商品描述">
        <el-input
          v-model="form.describe"
          :rows="3"
          type="textarea"
          placeholder="输入商品描述"
        />
      </el-form-item>
      <el-form-item label="商品属性">
        <div
          class="attribute"
          v-for="(att, attIndex) in attribute"
          :key="att.name"
        >
          <el-input
            v-model="att.name"
            style="width: 50%; margin-bottom: 10px"
            placeholder="属性名"
            :disabled="att.name == '规格'"
            @change="attNameChange(att.name, attIndex)"
          />
          <div
            class="att-items"
            v-for="(item, index) in att.items"
            :key="index"
          >
            <el-input v-model="att.items[index]" placeholder="子属性" />
            <el-icon
              @click="delAttributeSon(index, att.items)"
              v-if="index > 0 || att.items.length > 1"
              ><Remove
            /></el-icon>
            <el-icon
              @click="addAttributeSon(att.items)"
              v-if="index == att.items.length - 1"
            >
              <CirclePlus />
            </el-icon>
          </div>
          <el-button
            v-if="att.name !== '规格'"
            class="del"
            type="danger"
            size="small"
            plain
            @click="handleAttributeDel(attIndex, attribute)"
            >删除{{ att.name || "" }}</el-button
          >
        </div>
        <el-button type="primary" link @click="handleAttributeAdd"
          >创建其它属性</el-button
        >
      </el-form-item>
      <el-form-item label="规格售价与库存">
        <el-table class="price-input-table" :data="price" style="width: 300px">
          <template #empty>请添加规格的子属性</template>
          <el-table-column prop="size" label="规格" width="100" />
          <el-table-column label="售价(元)" width="100">
            <template #default="scope">
              <el-input
                type="number"
                min="0"
                v-model.number="scope.row.price"
                size="small"
              />
            </template>
          </el-table-column>
          <el-table-column label="库存(份)" width="100">
            <template #default="scope">
              <el-input
                type="number"
                min="0"
                v-model.number="scope.row.store"
                size="small"
              />
            </template>
          </el-table-column>
        </el-table>
      </el-form-item>
    </el-form>
    <el-button type="primary" @click="handleSubmit">提交</el-button>
  </div>
</template>

<style lang="scss" scoped>
.add-container {
  height: 100%;
  overflow: auto;

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
  .attribute {
    width: 100%;
    display: flex;
    flex-direction: column;
    align-items: flex-start;
    .att-items {
      margin: 0px 10px;
      display: flex;
      align-items: center;
      margin-bottom: 10px;
    }
    .del {
      margin: 0px 0 10px 10px;
    }
  }
}
</style>
