DROP TABLE IF EXISTS `order`;

CREATE TABLE
  `order` (
    `id` int NOT NULL AUTO_INCREMENT,
    `orderType` int DEFAULT NULL,
    `amount` int DEFAULT NULL,
    `dealNum` int DEFAULT NULL,
    `code` varchar(100) DEFAULT NULL,
    `phone` varchar(300) DEFAULT NULL,
    `remark` text DEFAULT NULL,
    `userId` varchar(300) DEFAULT NULL,
    `product` text DEFAULT NULL,
    `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `isDeleted` tinyint (1) unsigned zerofill DEFAULT '0',
    PRIMARY KEY (`id`)
  );

INSERT INTO
  `order` (
    `id`,
    `orderType`,
    `amount`,
    `dealNum`,
    `code`,
    `phone`,
    `remark`,
    `userId`,
    `product`
  )
VALUES
  (
    '301',
    1,
    16,
    1,
    '1001',
    '13544556622',
    '',
    '40001',
    '[{"id":201,"image":"/image/product/2024-09-13-161849.png","name":"手剥鲜石榴茉莉","attribute":"中杯/7分糖/正常冰","num":1,"price":16}]'
  );

DROP TABLE IF EXISTS `user`;

CREATE TABLE
  `user` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) DEFAULT NULL,
    `avatar` varchar(100) DEFAULT NULL,
    `phone` varchar(300) DEFAULT NULL,
    `addressObj` text DEFAULT NULL,
    `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `isDeleted` tinyint (1) unsigned zerofill DEFAULT '0',
    PRIMARY KEY (`id`)
  );

INSERT INTO
  `user` (`id`, `name`, `avatar`, `phone`, `addressObj`)
VALUES
  (
    '40001',
    '雅丽',
    '/user/default.jpg',
    '13544556622',
    '[{"address":"北京市北京市东城区天桥南大街126号","recipientName":"李","recipientGender":"女士","recipientPhone":"19855446622"}]'
  );

DROP TABLE IF EXISTS `product_type`;

CREATE TABLE
  `product_type` (
    `id` int NOT NULL AUTO_INCREMENT,
    `name` varchar(100) DEFAULT NULL,
    `image` varchar(100) DEFAULT NULL,
    `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `isDeleted` tinyint (1) unsigned zerofill DEFAULT '0',
    PRIMARY KEY (`id`)
  );

INSERT INTO
  `product_type` (`id`, `name`, `image`)
VALUES
  ('101', '新品来袭', '/image/type/xinpin.png'),
  ('102', '水果茶', '/image/type/shuiguocha.png'),
  ('103', '醇香奶茶', '/image/type/naicha.png'),
  ('104', '牛乳茶', '/image/type/niunai.png'),
  ('105', '沁爽柠檬茶', '/image/type/ningmeng.png'),
  ('106', '轻松现泡茶', '/image/type/cha.png'),
  ('107', '豪气1L装', '/image/type/chaoda.png'),
  ('108', '加小料区', '');

DROP TABLE IF EXISTS `product`;

CREATE TABLE
  `product` (
    `id` int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    `name` varchar(100) NOT NULL,
    `describe` text DEFAULT NULL,
    `image` varchar(300) DEFAULT NULL,
    `defaultPrice` int DEFAULT NULL,
    `sales` int DEFAULT NULL,
    `typeId` int DEFAULT NULL,
    `price` varchar(300) DEFAULT NULL,
    `totalStore` int DEFAULT NULL,
    `attribute` varchar(300) DEFAULT NULL,
    `isRecommend` tinyint (1) unsigned zerofill DEFAULT '0',
    `cover` varchar(300) DEFAULT NULL,
    `createdAt` datetime DEFAULT CURRENT_TIMESTAMP,
    `updatedAt` datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    `isDeleted` tinyint (1) unsigned zerofill DEFAULT '0'
  );

INSERT INTO
  `product` (
    `id`,
    `name`,
    `describe`,
    `image`,
    `defaultPrice`,
    `sales`,
    `typeId`,
    `price`,
    `totalStore`,
    `attribute`
  )
VALUES
  (
    '201',
    '手剥鲜石榴茉莉',
    '手剥鲜石榴，喝得到的新鲜感！源自"中国石榴之乡"会理突尼斯软籽红石榴，晶莹饱满粒粒手剥，现榨爆汁，搭配清新柠檬片与鲜灵七窖茉香雪芽茶底解锁满分清甜，嚼得到的现剥果粒更添鲜感十足。杯型容量：冷饮中杯520ml。
【饮茶小贴士】
＊饮品内含鲜石榴果粒，请小心饮用，果粒或有沉底，可搭配小勺勺取食用。
* 饮品中或有沉淀属于正常工艺现象，请放心饮用。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-161849.png',
    16,
    10,
    101,
    '[{"size":"中杯","price":16,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯"]},{"name":"甜度","items":["7分糖","全糖"]},{"name":"温度","items":["正常冰"]}]'
  ),
  (
    '202',
    '手剥鲜石榴玫瑰椰',
    '手剥鲜石榴，喝得到的新鲜感！源自"中国石榴之乡"会理突尼斯软籽红石榴，晶莹饱满粒粒手剥，现榨爆汁，邂逅天然玫瑰花露与清新椰子水，花香果香鲜香交织，层次丰富回味无穷。杯型容量：冷饮中杯520ml。
【饮茶小贴士】
＊饮品内含鲜石榴果粒，请小心饮用，果粒或有沉底，可搭配小勺勺取食用。
＊饮品中或有沉淀属于正常工艺现象，请放心饮用。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-162048.png',
    16,
    10,
    101,
    '[{"size":"中杯","price":16,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯"]},{"name":"甜度","items":["7分糖","全糖"]},{"name":"温度","items":["正常冰"]}]'
  ),
  (
    '203',
    '百香凤梨',
    '精选菲律宾凤梨与黄金百香果双香加持。凤梨新鲜果肉与馥郁黄金百香果搭配，酸酸甜甜满杯浓香！七窖茉香雪芽风味交叠，畅饮海边清甜。杯型容量：冷饮中杯500ml；冷饮大杯650ml。
【饮茶小贴士】
＊本饮品含有凤梨，过敏者慎食。
* 受特殊因素影响，部分门店鲜果品种存在差异，具体以门店出品为准，如介意请提前与门店沟通。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-162351.png',
    15,
    10,
    102,
    '[{"size":"中杯","price":15,"store":20},{"size":"大杯","price":18,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","全糖"]},{"name":"温度","items":["正常冰","少冰","去冰"]}]'
  ),
  (
    '204',
    '青提茉莉',
    '爆款回归，口口清爽！精选阳光玫瑰青提手捣出香，搭配青提原汁及鲜灵七窖茉香雪芽，层层出香果肉饱满，Q弹冻冻更添嚼劲，一口惊艳！杯型容量： 冷饮中杯500ml，大杯650ml。
【饮茶小贴士】
* 边搅边喝风味更佳。
* 如选择去除冻冻小料，不满杯为正常现象，敬请谅解。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-162549.png',
    15,
    10,
    102,
    '[{"size":"中杯","price":15,"store":20},{"size":"大杯","price":18,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","5分糖","3分糖（口感淡）"]},{"name":"温度","items":["正常冰","少冰","去冰"]}]'
  ),
  (
    '205',
    '真梅醉．青梅绿茶',
    '茶百道联名梅见青梅酒﹣﹣真梅醉．青梅绿茶，创意回归！精选大颗青梅加一点点酒，注入花香鲜灵的七窖茉香雪芽，入口清新甘爽，带来微醺愉悦感受！搭配甜蜜桂花，花香、茶香、酒香层层递进，多重口感一口满足～杯型容量：冷饮中杯520ml。
【饮茶小贴士】
＊该产品内含酒精，酒精浓度＜0.5%VOL，孕妇、驾车人士、酒精过敏者不建议饮用，未成年人请勿饮用。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-162627.png',
    12,
    10,
    102,
    '[{"size":"中杯","price":12,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯"]},{"name":"甜度","items":["7分糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '206',
    '紫气葡萄冻冻',
    '使用时令鲜葡萄搭配云南夏黑葡萄汁，果肉粒粒可见，入口鲜甜。搭配清新甘冽的七窖茉香雪芽，激发出更多的清爽口感。加入Q弹爽滑的冻冻，解锁多重味蕾享受。杯型容量：冷饮中杯500ml，大杯650ml。
【饮茶小贴士】
＊本产品可制作沙冰版，可根据您的喜好自行选择。
＊建议用吸管边搅边喝，口感更佳。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-162808.png',
    12,
    10,
    102,
    '[{"size":"中杯","price":12,"store":20},{"size":"大杯","price":16,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","5分糖","3分糖（口感淡）"]},{"name":"温度","items":["正常冰","少冰","沙冰"]}]'
  ),
  (
    '207',
    '紫气葡萄芝士',
    '使用时令鲜葡萄搭配云南夏黑葡萄汁，手工去皮保留大颗葡萄果肉，搭配清新甘冽的七窖茉香雪芽，再淋上咸香芝士奶盖，口感层层递进，入口轻盈柔滑不腻口。杯型容量：冷饮中杯500ml，大杯650ml。
【饮茶小贴士】
*1．本饮品含有乳蛋白成分，乳蛋白过敏者慎用。
*2．本产品可制作沙冰版，可根据您的喜好自行选择。
* 建议用吸管边搅边喝，口感更佳。
* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-162849.png',
    16,
    10,
    102,
    '[{"size":"中杯","price":16,"store":20},{"size":"大杯","price":19,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","5分糖","3分糖（口感淡）"]},{"name":"温度","items":["正常冰","少冰","沙冰"]}]'
  ),
  (
    '208',
    '杨枝甘露',
    '精选优质芒果、特制红西柚果粒、泰国小西米铺于杯底，搭配浓香椰浆，酸甜清爽丝毫不腻。开创杯装杨枝甘露酸甜鲜爽新喝法。杯型容积：热饮中杯475ml，大杯600ml，常温／冷饮中杯500ml，大杯650ml
【饮茶小贴士】
*1．本饮品含有芒果，对芒果过敏者慎食。
*2．西柚略带苦味，介意者慎点。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-162947.png',
    17,
    10,
    102,
    '[{"size":"中杯","price":17,"store":20},{"size":"大杯","price":21,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","5分糖","3分糖"]},{"name":"温度","items":["正常冰","少冰","常温","温热"]},{"name":"西柚","items":["有西柚","无西柚"]}]'
  ),
  (
    '209',
    '多芒杨枝甘露',
    '精选优质芒果、特制红西柚果粒、泰国小西米铺于杯底，搭配浓香椰浆，酸甜清爽丝毫不腻。开创杯装杨枝甘露酸甜鲜爽新喝法。杯型容量：热饮中杯475ml，大杯600ml，常温／冷饮中杯500ml，大杯650ml。
【饮茶小贴士】
＊本饮品含有芒果，对芒果过敏者慎食。
＊西柚略带苦味，介意者慎点。
* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-163150.png',
    19,
    10,
    102,
    '[{"size":"中杯","price":19,"store":20},{"size":"大杯","price":22,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["默认"]},{"name":"温度","items":["正常冰","少冰","常温","温热"]}]'
  ),
  (
    '210',
    '芒芒生打椰',
    '优选香甜多汁的芒果制成细腻沙冰，混入由Q弹冻冻及清爽生打椰打底的杯中，再铺上一层芒果粒，入口即是果香椰香充盈，凉意沁人。杯型容量：冷饮中杯500ml，大杯650ml
【饮茶小贴士】
*1．本饮品含有芒果、乳蛋白成分，对芒果、乳蛋白过敏者慎食。*2．饮品易化，建议及时饮用，为保证口感，如选择打包将配备保温袋包装，感谢理解。
* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-163307.png',
    15,
    10,
    102,
    '[{"size":"中杯","price":15,"store":20},{"size":"大杯","price":18,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","3分糖","不额外加糖","全糖"]},{"name":"温度","items":["沙冰"]}]'
  ),
  (
    '211',
    '生椰西瓜',
    '严选当季鲜脆西瓜搭档清甜生打椰，汇入七窖茉香雪芽中，口口多汁，脆甜生香！Q弹椰果的加入，更添嚼劲，沁爽有料。杯型容积：冷饮中杯500ml，大杯650ml。
【饮茶小贴士】
＊本饮品含有乳蛋白成分，对乳蛋白过敏者慎食。
＊建议不要与牛油果同食，避免引发肠胃不适。
* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-163407.png',
    13,
    10,
    102,
    '[{"size":"中杯","price":13,"store":20},{"size":"大杯","price":16,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["5分糖","不额外加糖","全糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '212',
    '西瓜啵啵',
    'Q弹脆啵啵与爽口西瓜的组合，混入经典的七窖茉香雪芽，小啜一口，口腔里回荡着茉莉与西瓜的清香，冰爽的感觉由口到心。手捣版偏果汁口感，沙冰版劲爽十足，可根据喜好随心选择。杯型容量：冷饮中杯500ml，大杯650ml。
【饮茶小贴士】
*1．建议不要与牛油果同食，避免引发肠胃不适。
*2．沙冰版饮品易化，建议及时饮用，为保证口感，如选择打包将配备保温袋包装，感谢理解。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-163517.png',
    14,
    10,
    102,
    '[{"size":"中杯","price":14,"store":20},{"size":"大杯","price":17,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","5分糖","3分糖","不额外加糖","全糖"]},{"name":"温度","items":["正常冰","少冰","沙冰"]}]'
  ),
  (
    '213',
    '盐盐冰淇淋乌龙',
    '经典风味，更懂夏天的味道！香草冰淇淋打底搭配混入海盐的醇香奶味，满杯咸甜醇厚，清凉宜人！岩韵奇兰茶底自带幽幽兰香更添馥郁茶香，满杯清香爽滑浓郁，一口回到记忆里的夏天！容量：冷饮中杯520ml。
【饮茶小贴士】
＊边搅边喝风味更佳。
* 香草冰淇淋不可分装。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-163638.png',
    11,
    10,
    103,
    '[{"size":"中杯","price":11,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯"]},{"name":"甜度","items":["全糖","5分糖"]},{"name":"温度","items":["正常冰","少冰","去冰"]}]'
  ),
  (
    '214',
    '双球冰淇淋红茶',
    '经典的双球冰淇淋红茶，是夏天记忆里的那一杯！杯中加入2颗奶香浓郁的香草冰淇淋打底，再注入香高似梅的梅占花魁茶汤，丝滑浓郁的冰淇淋与清爽茶汤的组合，一口回味经典！杯型容积：冷饮中杯520ml。
【饮茶小贴士】
*1、冰淇淋易化，外卖不可单独分装。
*2、边搅边喝，风味更佳。
*3、冰淇淋含有乳制品、大豆制品、可能含坚果，过敏者慎点。* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-163820.png',
    14,
    10,
    103,
    '[{"size":"中杯","price":14,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯"]},{"name":"甜度","items":["全糖","7分糖","3分糖（口感淡）"]},{"name":"温度","items":["正常冰","少冰","去冰"]}]'
  ),
  (
    '215',
    '抹茶奶布丁',
    '甄选高山生态茶园优质鲜茶，传承蒸青工艺，迸发清鲜茶香，经过遮阴、研磨处理，制成细腻抹茶，自然清新，融入香醇奶底，
再搭配嫩滑奶冻，一口实现清雅抹茶香和醇厚奶香的双重满足。热饮中杯475ml大杯600ml，冷饮中杯500ml大杯650ml。
【饮茶小贴士】
*1．建议喝法：边搅边喝，口感更佳。
*2．升级鲜奶配方为鲜奶，鲜奶精选自优质牧场的100％生牛乳。＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-163927.png',
    12,
    10,
    103,
    '[{"size":"中杯","price":12,"store":20},{"size":"大杯","price":15,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","5分糖","3分糖","不额外加糖","全糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '216',
    '招牌芋圆奶茶',
    '精选优质芋头制成的软萌小芋圆，沙糯香甜，搭配香气馥郁的梅占花魁奶茶底，顺滑香甜，吮吸一口，玩味无穷。杯型容量：常温／热饮中杯475ml，大杯600ml，冷饮中杯500ml，大杯650ml＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-13-164027.png',
    13,
    10,
    103,
    '[{"size":"中杯","price":13,"store":20},{"size":"大杯","price":16,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰","常温","热"]}]'
  ),
  (
    '217',
    '豆乳玉麒麟',
    '精选岩韵奇兰奶茶底与特磨黄豆粉迸发出加倍的豆香，咸甜芝士甜而不腻的口感将香醇无限延伸，香气悠远绵长。杯型容量：常温／热饮中杯475ml，大杯600ml，冷饮中杯500ml，大杯650ml＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-004205.png',
    14,
    10,
    103,
    '[{"size":"中杯","price":14,"store":20},{"size":"大杯","price":17,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰","常温","热"]}]'
  ),
  (
    '218',
    '豆乳米麻薯',
    '禾米麻薯以稀有禾米（源自谷种培育）为原料，入口米香兼具奶香，搭配岩韵奇兰奶茶底、Q软血糯米与芝士奶盖，再撒上豆香味十足的黄豆粉，每一口都幸福感拉满！杯型容量：常温／热饮中杯475ml◇大杯600ml◇冷饮中杯500ml◇大杯650ml建议喝法： 尝尝豆乳奶盖，再搅一搅禾米麻薯，让豆香、茶味伴随Q软底料，感受多重滋味。
* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-004309.png',
    16,
    10,
    103,
    '[{"size":"中杯","price":16,"store":20},{"size":"大杯","price":19,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰","常温","热"]}]'
  ),
  (
    '219',
    '茉莉奶绿',
    '七窖茉香雪芽香气馥郁端正，制成奶茶清甜怡人，小啜一口，浓郁的奶香和茉莉花香经唇入喉，淡雅香气经久留存。杯型容积：常温／热饮／中杯475ml◇大杯600ml◇冷饮中杯500ml，大杯650ml。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-004400.png',
    11,
    10,
    103,
    '[{"size":"中杯","price":11,"store":20},{"size":"大杯","price":13,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰","常温","热"]}]'
  ),
  (
    '220',
    '黑糖珍珠奶茶',
    '焦香浓郁的黑糖糖浆包裹每日现煮的珍珠，颗颗软糯弹牙。混入香醇浓郁的梅占花魁奶茶底，一口纵享顺滑，香而不腻，再现经典口味。杯型容量：常温／热饮中杯475ml，大杯600ml，冷饮中杯500ml，大杯650ml。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-004452.png',
    11,
    10,
    103,
    '[{"size":"中杯","price":11,"store":20},{"size":"大杯","price":13,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰","常温","热"]}]'
  ),
  (
    '221',
    '黄金椰椰乌龙',
    '岩韵奇兰奶茶底蕴含绵远花香与豆香，入喉茶味香醇，加入Q弹椰果为茶香增添了无限玩味。杯型容量：常温／热饮中杯475ml，大杯600ml，冷饮中杯500ml，大杯650ml
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-004549.png',
    12,
    10,
    103,
    '[{"size":"中杯","price":12,"store":20},{"size":"大杯","price":15,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰","常温","热"]}]'
  ),
  (
    '222',
    '奥利奥奶茶',
    '选用梅占花魁为底制成的奶茶甘香顺滑，覆盖咸香丝滑的芝士奶盖，撒上香脆奥利奥碎，滋味浓郁，风味十足。杯型容量：常温／热饮中杯475ml◇大杯600ml◇冷饮中杯500ml，大杯650ml＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-004711.png',
    14,
    10,
    103,
    '[{"size":"中杯","price":14,"store":20},{"size":"大杯","price":17,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰","常温","热"]}]'
  ),
  (
    '223',
    '绿茶',
    '约4200朵茉莉花制成1斤茶！以广西横州茉莉花窖足七次原叶绿茶，制成花香馥郁的七窖茉香雪芽，茶香更醇更自然，茶汤黄绿明亮，茶味鲜灵持久，甘甜爽口。杯型容量：冷饮中杯500ml，大杯650ml。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-004932.png',
    6,
    10,
    106,
    '[{"size":"中杯","price":6,"store":20},{"size":"大杯","price":7,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","5分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '224',
    '岩茶',
    '原叶取自绿水青山的福建茶叶产区，得云雾阳光雨露天然润养，经传统乌龙茶工艺打磨成奇兰好茶。茶香浓郁锐长，有奇特兰调，茶汤琥珀明亮，入口甘甜醇厚，岩韵悠长。杯型容量：冷饮中杯500ml，大杯650ml
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-005017.png',
    6,
    10,
    106,
    '[{"size":"中杯","price":6,"store":20},{"size":"大杯","price":7,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","5分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '225',
    '红茶',
    '选用闽北地区特色茶叶梅占，叶片入水生香，悠冷高扬，似梅花独占百花魁，汤色橙黄明亮，入口轻盈柔糯，醇厚甘甜，细品之下更有山野余韵，滋味非凡。杯型容量：冷饮中杯500ml，大杯650ml
* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-005106.png',
    6,
    10,
    106,
    '[{"size":"中杯","price":6,"store":20},{"size":"大杯","price":7,"store":20}]',
    40,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","5分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '226',
    '超级大瓜',
    '花香鲜灵的七窖茉香雪芽碰撞沁甜西瓜，再搭配嫩滑奶冻融入经典生打椰，入口茶香清新椰香浓郁，1L大杯装超满足，嚼得到的清甜沁爽，给你带来甜蜜的清凉体验！杯型容量：冷饮超级杯1000ml.
【饮茶小贴士】
* 1．建议不要与牛油果同食，避免引发肠胃不适。
*2．本饮品含有乳蛋白成分，乳蛋白过敏者慎用。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-005157.png',
    20,
    10,
    107,
    '[{"size":"1L","price":20,"store":20}]',
    20,
    '[{"name":"规格","items":["1L"]},{"name":"甜度","items":["7分糖","5分糖","3分糖（口感淡）","不额外加糖（口感淡）","全糖"]},{"name":"温度","items":["少冰","正常冰"]}]'
  ),
  (
    '227',
    '超级杯水果茶',
    '1L装超大杯水果茶，黄金百香果富含VC，搭配新鲜西瓜、凤梨、芒果等多种水果打造超级VC杯，鲜灵七窖茉香雪芽混入软滑冻冻，每一口都清甜鲜爽。杯型容积：1000ml。
【饮茶小贴士】
＊本饮品含有芒果、凤梨，对芒果、凤梨过敏者慎食。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-005306.png',
    20,
    10,
    107,
    '[{"size":"1L","price":20,"store":20}]',
    20,
    '[{"name":"规格","items":["1L"]},{"name":"甜度","items":["全糖","7分糖","5分糖","3分糖","不额外加糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '228',
    '小西米',
    '单份约40克，泰国进口小西米，色泽白净颗颗均匀饱满，口感Q弹软糯。',
    '/image/product/2024-09-14-005502.png',
    1,
    10,
    108,
    '[{"size":"份","price":1,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '229',
    '珍珠（黑糖风味）',
    '单份约70克，木薯淀粉制作而成的珍珠，精心焖煮，Q弹有嚼劲。',
    '/image/product/2024-09-14-005602.png',
    1,
    10,
    108,
    '[{"size":"份","price":1,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '230',
    '冻冻',
    '（添加热饮建议分装）单份约70克，Q弹冻冻，口感爽滑，味道轻甜。',
    '/image/product/2024-09-14-005711.png',
    1,
    10,
    108,
    '[{"size":"份","price":1,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '231',
    '椰果',
    '单份约35克，饱满大颗椰果粒，晶莹剔透口感顺滑。',
    '/image/product/2024-09-14-005815.png',
    1,
    10,
    108,
    '[{"size":"份","price":1,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '232',
    '脆啵啵',
    '（添加热饮建议分装）单份约35克，透明状脆啵啵，口感饱满，Q弹有嚼劲。',
    '/image/product/2024-09-14-005943.png',
    2,
    10,
    108,
    '[{"size":"份","price":2,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '233',
    '血糯米',
    '单份约50克，颗粒分明带着淡淡米香，软糯有嚼劲。',
    '/image/product/2024-09-14-010046.png',
    2,
    10,
    108,
    '[{"size":"份","price":2,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '234',
    '云绒奶冻',
    '（添加热饮建议分装）单份约70克，奶冻嫩滑细腻，入口是饱满的芝士奶香，丝滑入喉浓郁爽口，搭配奶茶奶香更醇厚！',
    '/image/product/2024-09-14-010239.png',
    2,
    10,
    108,
    '[{"size":"份","price":2,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '235',
    '芋圆',
    '单份约35克，精选优质芋头制作的芋圆，口感沙糯带着浓浓芋香味。',
    '/image/product/2024-09-14-010144.png',
    2,
    10,
    108,
    '[{"size":"份","price":2,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '236',
    '奥利奥',
    '单份约20克，原味奥利奥饼干碎，经典酥脆。',
    '/image/product/2024-09-14-010337.png',
    2,
    10,
    108,
    '[{"size":"份","price":2,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '237',
    '禾米麻薯',
    '单份约100克，以稀有禾米（源自野生谷种培育）为原料制作而成，通过恰当配比，兼具米香和奶香，整体口感软糯均衡且香滑细腻。',
    '/image/product/2024-09-14-010452.png',
    3,
    10,
    108,
    '[{"size":"份","price":3,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '238',
    '芝士奶盖',
    '（添加热饮建议分装）单份约25克，咸甜芝士奶盖，奶味香浓，口感醇厚。',
    '/image/product/2024-09-14-010552.png',
    3,
    10,
    108,
    '[{"size":"份","price":3,"store":20}]',
    20,
    '[{"name":"规格","items":["份"]},{"name":"属性","items":["不分装","分装￥0.5"]}]'
  ),
  (
    '239',
    '栀子生椰奶冻',
    'Q弹爽滑的奶冻搭配香甜浓郁的椰子乳，与栀香绿茶茶底融合得恰到好处，深吸一口，椰香扑鼻甜而不腻，再加入醇厚牛乳收尾，整杯都是惊喜风味！杯型容积：中杯500ml，大杯650ml。
【饮茶小贴士】
*1．饮用时请勿一口吞食。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-010636.png',
    13,
    10,
    104,
    '[{"size":"中杯","price":13,"store":20},{"size":"大杯","price":16,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["7分糖","3分糖（口感淡）","不额外加糖（口感淡）","全糖"]},{"name":"温度","items":["正常冰","少冰","去冰"]}]'
  ),
  (
    '240',
    '凤梨柠檬茶',
    '菲律宾凤梨重锤出香激发独特热带香气，搭配锤捣后的柠檬提升香味层次，带来明亮奔放的热带风情，奇兰茶汤加入柔顺兰花香，淡雅悠扬，满杯醇香透亮金黄，酸甜馥郁。杯型容量：冷饮中杯500ml；冷饮大杯650ml。
【饮茶小贴士】
＊本饮品含有凤梨，过敏者慎食。
＊受特殊因素影响，部分门店鲜果品种存在差异，具体以门店出品为准，如介意请提前与门店沟通。
* 杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-010738.png',
    15,
    10,
    105,
    '[{"size":"中杯","price":15,"store":20},{"size":"大杯","price":18,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖","3分糖（口感淡）","不额外加糖（口感淡）"]},{"name":"温度","items":["正常冰","少冰"]}]'
  ),
  (
    '241',
    '老盐柠檬茶',
    '经典回归，遁入清爽夏天！清新柠檬重锤出香，搭配鲜灵七窖茉香雪芽茶底激发柠檬的七分甘甜与三分酸爽。海盐微咸交织酸甜口感，香气馥郁而口感轻盈，温柔如风卷走夏日暑气。杯型容量：冷饮中杯500ml；冷饮大杯650ml。
【饮茶小贴士】
* 边搅边喝风味更佳。
＊杯型容量数及图片仅供参考，饮品量及包装请以实际出品为准',
    '/image/product/2024-09-14-010823.png',
    14,
    10,
    105,
    '[{"size":"中杯","price":14,"store":20},{"size":"大杯","price":17,"store":20}]',
    20,
    '[{"name":"规格","items":["中杯","大杯"]},{"name":"甜度","items":["全糖","7分糖"]},{"name":"温度","items":["正常冰","少冰"]}]'
  );