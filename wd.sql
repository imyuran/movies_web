/*
Navicat MySQL Data Transfer

Source Server         : aa
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : wd

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2017-12-23 22:24:21
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for wd_admin_user
-- ----------------------------
DROP TABLE IF EXISTS `wd_admin_user`;
CREATE TABLE `wd_admin_user` (
  `id` smallint(5) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL DEFAULT '' COMMENT '管理员用户名',
  `password` varchar(50) NOT NULL DEFAULT '' COMMENT '管理员密码',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 启用 0 禁用',
  `create_time` varchar(20) DEFAULT '0' COMMENT '注册时间',
  `last_login_time` varchar(20) DEFAULT '0' COMMENT '最后登录时间',
  `last_login_ip` varchar(20) DEFAULT NULL COMMENT '最后登录IP',
  `salt` varchar(20) DEFAULT NULL COMMENT 'salt',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='管理员表';

-- ----------------------------
-- Records of wd_admin_user
-- ----------------------------
INSERT INTO `wd_admin_user` VALUES ('3', 'ghjl', 'b59c67bf196a4758191e42f76670ceba', '0', '1513180122', '0', null, null);
INSERT INTO `wd_admin_user` VALUES ('2', 'aaaa', '74b87337454200d4d33f80c4663dc5e5', '0', '1511862509', '0', null, null);

-- ----------------------------
-- Table structure for wd_askanswer
-- ----------------------------
DROP TABLE IF EXISTS `wd_askanswer`;
CREATE TABLE `wd_askanswer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL COMMENT '用户id',
  `title` varchar(255) NOT NULL COMMENT '标题',
  `desc` varchar(255) NOT NULL COMMENT '描述',
  `created_at` date NOT NULL COMMENT '创建时间',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '状态',
  `uploads` varchar(255) NOT NULL COMMENT '图片路径',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_askanswer
-- ----------------------------

-- ----------------------------
-- Table structure for wd_comment
-- ----------------------------
DROP TABLE IF EXISTS `wd_comment`;
CREATE TABLE `wd_comment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL COMMENT '上级评论',
  `uid` int(11) NOT NULL COMMENT '所属会员',
  `fid` int(11) NOT NULL DEFAULT '0' COMMENT '所属文章',
  `time` varchar(11) NOT NULL COMMENT '时间',
  `praise` varchar(11) DEFAULT '0' COMMENT '赞',
  `reply` varchar(11) DEFAULT '0' COMMENT '回复',
  `content` text NOT NULL COMMENT '内容',
  `mid` int(11) DEFAULT '0' COMMENT '所属作品',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8 COMMENT='评论表';

-- ----------------------------
-- Records of wd_comment
-- ----------------------------
INSERT INTO `wd_comment` VALUES ('85', '0', '6', '0', '1510717374', '1', '0', '777777', '4');
INSERT INTO `wd_comment` VALUES ('86', '85', '6', '0', '1510717379', '0', '0', '888888888', '4');
INSERT INTO `wd_comment` VALUES ('87', '86', '6', '0', '1510717387', '0', '0', '000000000000', '4');
INSERT INTO `wd_comment` VALUES ('88', '0', '6', '0', '1510754548', '0', '0', '999', '8');
INSERT INTO `wd_comment` VALUES ('89', '0', '6', '0', '1511024512', '0', '0', '44', '3');
INSERT INTO `wd_comment` VALUES ('90', '0', '13', '6', '1511876058', '0', '0', '我想说这是一条评论', '0');
INSERT INTO `wd_comment` VALUES ('91', '0', '6', '0', '1511880747', '0', '0', 'fagaes', '42');
INSERT INTO `wd_comment` VALUES ('92', '0', '6', '12', '1511881142', '0', '0', 'qswsddfghhjgfddsa', '0');
INSERT INTO `wd_comment` VALUES ('93', '90', '14', '6', '1511885185', '0', '0', 'wertgghgfds', '0');
INSERT INTO `wd_comment` VALUES ('94', '0', '13', '10', '1511971238', '0', '0', 'sqwdef', '0');
INSERT INTO `wd_comment` VALUES ('95', '0', '13', '13', '1512056054', '0', '0', 'aaaaaa', '0');
INSERT INTO `wd_comment` VALUES ('96', '0', '13', '0', '1512491527', '0', '0', '555', '49');
INSERT INTO `wd_comment` VALUES ('97', '96', '13', '0', '1512550778', '0', '0', '123222', '49');
INSERT INTO `wd_comment` VALUES ('98', '0', '13', '17', '1512563025', '0', '0', 'qwewef', '0');
INSERT INTO `wd_comment` VALUES ('99', '98', '13', '17', '1512563033', '0', '0', 'werfc', '0');
INSERT INTO `wd_comment` VALUES ('100', '0', '13', '21', '1512565426', '1', '0', 'aa', '0');
INSERT INTO `wd_comment` VALUES ('101', '0', '13', '22', '1512565480', '1', '0', 'fvdsdsv', '0');
INSERT INTO `wd_comment` VALUES ('102', '0', '13', '21', '1512566302', '0', '0', 'wase', '0');
INSERT INTO `wd_comment` VALUES ('103', '0', '13', '0', '1512568422', '1', '0', 'wsdff', '49');
INSERT INTO `wd_comment` VALUES ('104', '103', '13', '0', '1512568436', '0', '0', 'ergh', '49');
INSERT INTO `wd_comment` VALUES ('105', '0', '13', '22', '1512569619', '0', '0', 'swe', '0');
INSERT INTO `wd_comment` VALUES ('106', '0', '13', '22', '1512569627', '0', '0', 'ee', '0');
INSERT INTO `wd_comment` VALUES ('107', '0', '13', '22', '1512569635', '0', '0', 'www', '0');
INSERT INTO `wd_comment` VALUES ('108', '0', '13', '22', '1512569644', '0', '0', 'ww', '0');
INSERT INTO `wd_comment` VALUES ('109', '0', '13', '22', '1512569652', '0', '0', 'w', '0');
INSERT INTO `wd_comment` VALUES ('110', '0', '13', '22', '1512569664', '0', '0', 'eeee', '0');
INSERT INTO `wd_comment` VALUES ('111', '0', '13', '22', '1512569675', '0', '0', 'wwww', '0');
INSERT INTO `wd_comment` VALUES ('112', '0', '13', '22', '1512569684', '0', '0', 'eee', '0');
INSERT INTO `wd_comment` VALUES ('113', '0', '13', '22', '1512569691', '0', '0', 'www', '0');
INSERT INTO `wd_comment` VALUES ('114', '0', '13', '22', '1512569698', '0', '0', 'eee', '0');
INSERT INTO `wd_comment` VALUES ('115', '114', '13', '22', '1512569898', '0', '0', 'awdsdrgtfh', '0');
INSERT INTO `wd_comment` VALUES ('116', '115', '13', '114', '1512569920', '0', '0', 'dfghj', '0');
INSERT INTO `wd_comment` VALUES ('117', '116', '13', '115', '1512569932', '0', '0', 'fghfhj', '0');
INSERT INTO `wd_comment` VALUES ('118', '0', '13', '0', '1513092903', '1', '0', 'uhiil', '1');
INSERT INTO `wd_comment` VALUES ('119', '118', '13', '0', '1513092914', '0', '0', 'jjklk', '1');
INSERT INTO `wd_comment` VALUES ('120', '0', '13', '1', '1513179924', '0', '0', 'ghjh', '0');

-- ----------------------------
-- Table structure for wd_connect
-- ----------------------------
DROP TABLE IF EXISTS `wd_connect`;
CREATE TABLE `wd_connect` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `userobj` int(10) NOT NULL COMMENT '关注着',
  `usered` int(10) NOT NULL COMMENT '被关注',
  `date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_connect
-- ----------------------------
INSERT INTO `wd_connect` VALUES ('1', '14', '6', '2017-11-28 21:36:52');
INSERT INTO `wd_connect` VALUES ('2', '13', '6', '2017-11-28 21:36:52');
INSERT INTO `wd_connect` VALUES ('3', '15', '6', '2017-11-28 21:36:52');
INSERT INTO `wd_connect` VALUES ('4', '13', '14', '2017-11-29 21:45:40');
INSERT INTO `wd_connect` VALUES ('8', '13', '16', '2017-12-06 01:17:55');
INSERT INTO `wd_connect` VALUES ('9', '13', '15', '2017-12-06 20:02:26');
INSERT INTO `wd_connect` VALUES ('11', '6', '15', '2017-12-10 16:49:18');
INSERT INTO `wd_connect` VALUES ('12', '6', '16', '2017-12-10 16:49:27');
INSERT INTO `wd_connect` VALUES ('13', '6', '14', '2017-12-10 16:49:37');
INSERT INTO `wd_connect` VALUES ('14', '13', '17', '2017-12-12 23:33:06');

-- ----------------------------
-- Table structure for wd_fabu
-- ----------------------------
DROP TABLE IF EXISTS `wd_fabu`;
CREATE TABLE `wd_fabu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `add_ts` varchar(255) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '1',
  `img` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_fabu
-- ----------------------------
INSERT INTO `wd_fabu` VALUES ('1', '关于视频类型的注意事项', '痕迹类注意事项：痕迹类视频所需的录制软件对电脑配置要求叫高，并且机器配置不好会大大的影响效果，建议选择回放类，如电脑可以录制，那就联系我，我发给你录制软件，一般一个原始视频录下来会有1G至2G这么大！对机器也是个不小的负担，待我制作后就会压缩至100M之内！并上传至各大网站', '1513872202', '1', null);
INSERT INTO `wd_fabu` VALUES ('2', '明天进行维护的通告', '据2017年人民银行支付清算系统运行维护安排有关事项通知，原定于2017年10月21日实施的系统维护取消，更改为2017年10月28日进行支付清算系统维护，维护时间为00:00至8:00。\r\n\r\n维护期间小额支付系统及网上支付跨行清算系统和全国支票影像交换系统暂停受理业务，此次运行维护为全国范围所有银行，在此运行维护期间银行及三方支付公司系统都会进行维护升级，期间或大范围影响pos资金到账时间及信用卡业务，请各相关机构做好通知工作！避免带来不便！', '1513872202', '1', null);

-- ----------------------------
-- Table structure for wd_fangwen
-- ----------------------------
DROP TABLE IF EXISTS `wd_fangwen`;
CREATE TABLE `wd_fangwen` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `visiter_id` int(11) NOT NULL COMMENT '访问者',
  `visited_id` int(11) NOT NULL COMMENT '被访问者',
  `created_at` int(11) DEFAULT NULL COMMENT '访问时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=73 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_fangwen
-- ----------------------------
INSERT INTO `wd_fangwen` VALUES ('1', '17', '16', '1512834623');
INSERT INTO `wd_fangwen` VALUES ('2', '17', '15', '1512839727');
INSERT INTO `wd_fangwen` VALUES ('3', '17', '14', '1512842028');
INSERT INTO `wd_fangwen` VALUES ('4', '13', '6', '1512843569');
INSERT INTO `wd_fangwen` VALUES ('5', '13', '6', '1512843746');
INSERT INTO `wd_fangwen` VALUES ('6', '13', '6', '1512843778');
INSERT INTO `wd_fangwen` VALUES ('7', '13', '6', '1512844203');
INSERT INTO `wd_fangwen` VALUES ('8', '13', '6', '1512844266');
INSERT INTO `wd_fangwen` VALUES ('9', '13', '6', '1512844281');
INSERT INTO `wd_fangwen` VALUES ('10', '13', '6', '1512844316');
INSERT INTO `wd_fangwen` VALUES ('11', '13', '6', '1512844477');
INSERT INTO `wd_fangwen` VALUES ('12', '13', '15', '1512887524');
INSERT INTO `wd_fangwen` VALUES ('13', '13', '15', '1512887550');
INSERT INTO `wd_fangwen` VALUES ('14', '13', '15', '1512887846');
INSERT INTO `wd_fangwen` VALUES ('15', '13', '15', '1512888048');
INSERT INTO `wd_fangwen` VALUES ('16', '13', '16', '1512888481');
INSERT INTO `wd_fangwen` VALUES ('17', '13', '17', '1512892416');
INSERT INTO `wd_fangwen` VALUES ('18', '13', '16', '1512892422');
INSERT INTO `wd_fangwen` VALUES ('19', '13', '17', '1512892533');
INSERT INTO `wd_fangwen` VALUES ('20', '13', '17', '1512892622');
INSERT INTO `wd_fangwen` VALUES ('21', '13', '16', '1512894185');
INSERT INTO `wd_fangwen` VALUES ('22', '13', '16', '1512894203');
INSERT INTO `wd_fangwen` VALUES ('23', '6', '15', '1512895756');
INSERT INTO `wd_fangwen` VALUES ('24', '6', '16', '1512895765');
INSERT INTO `wd_fangwen` VALUES ('25', '6', '14', '1512895773');
INSERT INTO `wd_fangwen` VALUES ('26', '6', '16', '1512896489');
INSERT INTO `wd_fangwen` VALUES ('27', '13', '16', '1512901356');
INSERT INTO `wd_fangwen` VALUES ('28', '13', '15', '1512902604');
INSERT INTO `wd_fangwen` VALUES ('29', '13', '15', '1512903014');
INSERT INTO `wd_fangwen` VALUES ('30', '13', '15', '1512903139');
INSERT INTO `wd_fangwen` VALUES ('31', '13', '15', '1512903141');
INSERT INTO `wd_fangwen` VALUES ('32', '13', '15', '1512903398');
INSERT INTO `wd_fangwen` VALUES ('33', '13', '15', '1512903400');
INSERT INTO `wd_fangwen` VALUES ('34', '13', '15', '1512903417');
INSERT INTO `wd_fangwen` VALUES ('35', '13', '15', '1512903419');
INSERT INTO `wd_fangwen` VALUES ('36', '13', '15', '1512903476');
INSERT INTO `wd_fangwen` VALUES ('37', '13', '15', '1512903478');
INSERT INTO `wd_fangwen` VALUES ('38', '13', '15', '1512903537');
INSERT INTO `wd_fangwen` VALUES ('39', '13', '15', '1512903553');
INSERT INTO `wd_fangwen` VALUES ('40', '13', '15', '1512903555');
INSERT INTO `wd_fangwen` VALUES ('41', '13', '15', '1512903582');
INSERT INTO `wd_fangwen` VALUES ('42', '13', '15', '1512903590');
INSERT INTO `wd_fangwen` VALUES ('43', '13', '15', '1512903617');
INSERT INTO `wd_fangwen` VALUES ('44', '13', '15', '1512903804');
INSERT INTO `wd_fangwen` VALUES ('45', '13', '15', '1512903806');
INSERT INTO `wd_fangwen` VALUES ('46', '13', '16', '1512907128');
INSERT INTO `wd_fangwen` VALUES ('47', '13', '16', '1512907627');
INSERT INTO `wd_fangwen` VALUES ('48', '13', '16', '1512907726');
INSERT INTO `wd_fangwen` VALUES ('49', '13', '15', '1512908252');
INSERT INTO `wd_fangwen` VALUES ('50', '13', '16', '1512908264');
INSERT INTO `wd_fangwen` VALUES ('51', '13', '16', '1512908275');
INSERT INTO `wd_fangwen` VALUES ('52', '13', '14', '1512908298');
INSERT INTO `wd_fangwen` VALUES ('53', '13', '14', '1512908306');
INSERT INTO `wd_fangwen` VALUES ('54', '13', '14', '1512908325');
INSERT INTO `wd_fangwen` VALUES ('55', '13', '15', '1512915576');
INSERT INTO `wd_fangwen` VALUES ('56', '13', '16', '1513092736');
INSERT INTO `wd_fangwen` VALUES ('57', '13', '16', '1513092763');
INSERT INTO `wd_fangwen` VALUES ('58', '13', '15', '1513092773');
INSERT INTO `wd_fangwen` VALUES ('59', '13', '14', '1513092778');
INSERT INTO `wd_fangwen` VALUES ('60', '13', '17', '1513092783');
INSERT INTO `wd_fangwen` VALUES ('61', '13', '17', '1513092789');
INSERT INTO `wd_fangwen` VALUES ('62', '13', '15', '1513093294');
INSERT INTO `wd_fangwen` VALUES ('63', '13', '15', '1513094178');
INSERT INTO `wd_fangwen` VALUES ('64', '13', '15', '1513094987');
INSERT INTO `wd_fangwen` VALUES ('65', '13', '15', '1513094998');
INSERT INTO `wd_fangwen` VALUES ('66', '13', '15', '1513095024');
INSERT INTO `wd_fangwen` VALUES ('67', '13', '15', '1513095036');
INSERT INTO `wd_fangwen` VALUES ('68', '15', '16', '1513096987');
INSERT INTO `wd_fangwen` VALUES ('69', '16', '15', '1513097187');
INSERT INTO `wd_fangwen` VALUES ('70', '15', '16', '1513097649');
INSERT INTO `wd_fangwen` VALUES ('71', '13', '17', '1513179722');
INSERT INTO `wd_fangwen` VALUES ('72', '13', '15', '1513179744');

-- ----------------------------
-- Table structure for wd_file
-- ----------------------------
DROP TABLE IF EXISTS `wd_file`;
CREATE TABLE `wd_file` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `name` varchar(255) NOT NULL DEFAULT '' COMMENT '原始文件名',
  `savename` varchar(255) NOT NULL DEFAULT '' COMMENT '保存名称',
  `savepath` varchar(255) NOT NULL DEFAULT '' COMMENT '文件保存路径',
  `ext` char(5) NOT NULL DEFAULT '' COMMENT '文件后缀',
  `mime` char(40) NOT NULL DEFAULT '' COMMENT '文件mime类型',
  `size` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '文件大小',
  `md5` varchar(255) NOT NULL DEFAULT '' COMMENT '文件md5',
  `sha1` varchar(255) NOT NULL DEFAULT '' COMMENT '文件 sha1编码',
  `location` tinyint(3) unsigned NOT NULL DEFAULT '0' COMMENT '文件保存位置',
  `create_time` int(10) unsigned NOT NULL COMMENT '上传时间',
  `download` int(10) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_md5` (`md5`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='文件表';

-- ----------------------------
-- Records of wd_file
-- ----------------------------
INSERT INTO `wd_file` VALUES ('1', 'player.png', '97b1296ce2180edfb65ee01e5041daf2.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '3882', 'd51021a616f656dcc524930886228a3c', 'fd88043d843f5a19dc611caa1596057e52ae3b7c', '1', '1507544829', '0');
INSERT INTO `wd_file` VALUES ('2', 'weixinhhh.jpg', '2771723b6c7225616a541a46a8f973d8.jpg', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'jpg', 'image/jpeg', '25100', 'a200d875eb096727e2abb78e8c7f3c26', 'a7086d55368c286610730529619f0c0f7ec176c0', '1', '1507723300', '0');
INSERT INTO `wd_file` VALUES ('3', 'TIM截图20170728175849.png', 'ac4780fa3f0c17bf140f075f7d018e33.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '374099', '9a26756079581aba7240b7b820dea343', '25d84c2661b7e6fcc2d9ab7779e1e7db6faf828e', '1', '1510048319', '0');
INSERT INTO `wd_file` VALUES ('4', '4.png', '7b965952b4f220d7270ddae4e0a64e4b.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '3478', '65ca766f8c0087670eb74900392524f7', '73246f03489954ef740cc2299a1d62e120225354', '1', '1510073285', '0');
INSERT INTO `wd_file` VALUES ('5', 'b_02.png', '5d363d02c37ff79cdaf0279707d26079.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '403422', '219365148fb7f4662021f6931223c578', '811da96d67436ac045aa3c67c663b74a63bd244e', '1', '1510154888', '0');
INSERT INTO `wd_file` VALUES ('6', '666_02.png', '4ce833654f6e7aec97e6f4a6fd42cc9e.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '269685', 'b07df020fb73891c59a9af8ec0a31837', '6801018985fb135554fc0f733a0391dfeb8e6a8e', '1', '1510155084', '0');
INSERT INTO `wd_file` VALUES ('7', '5.png', '8d6e0cf397faaa0de86c5d69c710f245.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '3942', '892d11b289d1501bdeb28c520ee53601', 'c8ba291b9df267ca7b0a98b04879d8b0cb1bcb32', '1', '1510461454', '0');
INSERT INTO `wd_file` VALUES ('8', 'TIM截图20171114221851.png', '1be0f48fe95e7d91d0c86d907f85f184.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '386255', '120a74b29b94cfc8c9cc0e6fc53b6c3d', 'd32a867ca97ff026e1441dfb5d014c2ae2492798', '1', '1510669170', '0');
INSERT INTO `wd_file` VALUES ('9', 'TIM截图20171114221836.png', '039fbc9e363625a51b64dcde7a8714f7.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '32482', '6473b08b7181c3ff72a1f6b7ab4b5898', '4e03f8b8f4ba61c8b7d40fed66bb447ab5faa0ca', '1', '1510669813', '0');
INSERT INTO `wd_file` VALUES ('10', 'back.png', 'df89e48dcedc9565f2b92a1f3cd8f892.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '1720', 'be5514b83654212a26a0f772a9bb5632', '9f3550b5843b661395912a8519455a8a299978ce', '1', '1510673032', '0');
INSERT INTO `wd_file` VALUES ('11', '微信图片_20171109194317.png', '460256144cdf86425ae2ccad9e3e1955.png', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'png', 'image/png', '605289', '0340033c5a3225613baf78939e2471fd', 'ecfc04703ca282f6370078aa0f9c831e715fe7fe', '1', '1510673039', '0');
INSERT INTO `wd_file` VALUES ('12', '23.jpg', 'ed87aee273f995c5b79a042a8163bd86.jpg', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'jpg', 'image/jpeg', '225863', 'ea0f8843a032410af7847188faba0d33', '27438a5fa1270bf0a6de3ffb1e6ab4400d7f4655', '1', '1511865445', '0');
INSERT INTO `wd_file` VALUES ('13', '105.jpg', 'ed2ef7a3ba4fc317841a3c9bb60632fa.jpg', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'jpg', 'image/jpeg', '405477', 'f305a84e7d1ad2008dbcfb918d164b61', 'd345f181380414229a8f4a0f01e1a923fd091d7b', '1', '1511865905', '0');
INSERT INTO `wd_file` VALUES ('14', '9213463_b.jpg', 'becbf1507fdf6ec26c1ec7f41c2d8bc4.jpg', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'jpg', 'image/jpeg', '207741', '64b6f1bd0c1df9668a3ff74a8591f256', '0e7ba615ca17484c01810847f65a5ec456d0bfc8', '1', '1511875056', '0');
INSERT INTO `wd_file` VALUES ('15', '6243430.jpg', 'b7541c1cf3d6311251d50cbb54716c2a.jpg', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'jpg', 'image/jpeg', '255901', 'a89a4c5d25d85537d319284ea3ee23d0', '49498875b65bfbbaf951610f3336c1369a703546', '1', '1511875718', '0');
INSERT INTO `wd_file` VALUES ('16', 'PIC95_1024.jpg', '16c4093cd53e9666806582678157f30c.jpg', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'jpg', 'image/jpeg', '453531', '4268cad9098fc21b11627088d4c6a9e2', '75c182a7157262e9d3e4df956cabe3fe1574fe63', '1', '1511876014', '0');
INSERT INTO `wd_file` VALUES ('17', '2022378.jpg', '0f01541946588f0f8bdc72c20722db97.jpg', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', 'jpg', 'image/jpeg', '301790', '37737f00c918bab876201c919dd1d0cc', 'ee0ed77ba981d37c44282fd6d56643f8a252d72c', '1', '1511957427', '0');

-- ----------------------------
-- Table structure for wd_forum
-- ----------------------------
DROP TABLE IF EXISTS `wd_forum`;
CREATE TABLE `wd_forum` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '用户',
  `title` varchar(100) NOT NULL COMMENT '标题',
  `open` tinyint(1) NOT NULL DEFAULT '1' COMMENT '显示1 0不显示',
  `choice` tinyint(1) NOT NULL DEFAULT '0' COMMENT '精贴',
  `settop` tinyint(1) NOT NULL DEFAULT '0' COMMENT '顶置',
  `praise` varchar(11) NOT NULL DEFAULT '0' COMMENT '赞',
  `view` varchar(11) NOT NULL DEFAULT '0' COMMENT '浏览量',
  `time` varchar(11) NOT NULL COMMENT '时间',
  `reply` varchar(11) NOT NULL DEFAULT '0' COMMENT '回复',
  `thumb` varchar(100) DEFAULT NULL COMMENT '关键词',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `content` text NOT NULL COMMENT '内容',
  `ftype` tinyint(1) DEFAULT NULL COMMENT '类型，1文章，2技术交流，3动态',
  PRIMARY KEY (`id`,`reply`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_forum
-- ----------------------------
INSERT INTO `wd_forum` VALUES ('5', '6', '66666666666666', '1', '0', '0', '0', '0', '1511968533', '0', '/uploads/20171107/1512.jpg', null, '<p>666666666666</p>', '2');
INSERT INTO `wd_forum` VALUES ('6', '6', '111111111111111', '1', '0', '0', '0', '0', '1510073630', '0', '/uploads/20171107/1512.jpg', null, '<p>777777777777</p>', '2');
INSERT INTO `wd_forum` VALUES ('7', '6', '2222222222', '1', '0', '0', '0', '0', '1510073787', '0', '/uploads/20171107/1512.jpg', null, '<p>777777777777</p>', '2');
INSERT INTO `wd_forum` VALUES ('8', '6', '77777777777', '1', '0', '0', '0', '0', '1510073840', '0', '/uploads/20171107/1512.jpg', null, '<p>77777777777</p>', '1');
INSERT INTO `wd_forum` VALUES ('9', '6', '444444444', '1', '0', '0', '0', '0', '1510103596', '0', '/uploads/20171107/1512.jpg', null, '<p>6666666</p>', '1');
INSERT INTO `wd_forum` VALUES ('10', '6', '999999999999', '1', '0', '0', '0', '0', '1510103642', '0', '/uploads/20171107/1512.jpg', null, '<p>6666666<img src=\"http://localhost/1025/public/common/umeditor/php/upload/20171108/15101036393097.png\"/></p>', '1');
INSERT INTO `wd_forum` VALUES ('11', '6', 'ooooooooo', '1', '0', '0', '0', '0', '1510105110', '0', '/uploads/20171107/1512.jpg', null, '<p>oooooooo<img src=\"http://localhost/1025/public/common/umeditor/php/upload/20171108/15101051025613.png\"/></p>', '1');
INSERT INTO `wd_forum` VALUES ('12', '6', '8888888888888888', '1', '0', '0', '0', '0', '1510155098', '0', '/uploads/20171107/1512.jpg', null, '<p>8888888888888<img src=\"http://localhost/1025/public/common/umeditor/php/upload/20171108/15101550954704.png\"/></p>', '2');
INSERT INTO `wd_forum` VALUES ('13', '14', '汉·曹操《短歌行》', '1', '0', '0', '0', '67', '1511876683', '0', '/uploads/20171107/1512.jpg', null, '<p>对酒当歌 人生几何</p>', '2');
INSERT INTO `wd_forum` VALUES ('14', '14', '那个喝醉的夜晚挡不住我们的步伐', '1', '0', '0', '0', '11', '1511876808', '0', '/uploads/20171107/1512.jpg', null, '<p>那个喝醉的夜晚挡不住我们的步伐</p>', '3');
INSERT INTO `wd_forum` VALUES ('15', '14', 'fffffffffffffffffffff', '1', '0', '0', '0', '15', '1511876850', '0', '/uploads/20171107/1512.jpg', null, '<p>aaaaaaaaaaaaaaaaaaaaaaa</p>', '3');
INSERT INTO `wd_forum` VALUES ('16', '13', '将进酒 李白', '1', '0', '0', '0', '0', '1511957475', '0', '/uploads/20171107/1512.jpg', null, '<p>劝君更尽一杯酒，西阳关外无人敌<br/></p>', '1');
INSERT INTO `wd_forum` VALUES ('17', '15', '的夜晚挡不住我们的步伐', '1', '0', '0', '0', '0', '1511957475', '0', '/uploads/20171107/1512.jpg', null, '<p>劝君更尽一杯酒，西阳关外无人敌<br/></p>', '1');
INSERT INTO `wd_forum` VALUES ('20', '13', 'qwertyuiujyht', '1', '0', '0', '0', '0', '1512200869', '0', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', null, '<p>qwerthtygrfew<br/></p>', '1');
INSERT INTO `wd_forum` VALUES ('18', '13', '别人笑我太疯癫', '1', '0', '0', '0', '0', '1511963093', '0', '/uploads/20171107/1512.jpg', null, '<p>我笑他人看不穿<br/></p>', '1');
INSERT INTO `wd_forum` VALUES ('19', '13', '鸳鸯双栖蝶双飞', '1', '0', '0', '0', '0', '1511968533', '0', '/uploads/20171107/1512.jpg', null, '<p>满园春色惹人醉<br/></p>', '1');
INSERT INTO `wd_forum` VALUES ('21', '13', '测试222222222222222', '1', '0', '0', '0', '0', '1512469799', '0', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', null, '<p>图片大小</p>', '1');
INSERT INTO `wd_forum` VALUES ('22', '16', '蚕丛及鱼凫 开国何茫然', '1', '0', '0', '0', '0', '1512487704', '0', '/uploads/20171107/1512.jpg', null, '<p>尔来四万八千岁 不与秦塞通人烟<br/></p>', '1');

-- ----------------------------
-- Table structure for wd_forumcate
-- ----------------------------
DROP TABLE IF EXISTS `wd_forumcate`;
CREATE TABLE `wd_forumcate` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL COMMENT '上级',
  `name` varchar(32) NOT NULL COMMENT '名称',
  `type` tinyint(1) NOT NULL DEFAULT '1' COMMENT '类型',
  `show` tinyint(1) NOT NULL DEFAULT '1' COMMENT '显示',
  `sidebar` tinyint(1) NOT NULL DEFAULT '1' COMMENT '侧栏',
  `sort` int(11) NOT NULL DEFAULT '1' COMMENT '排序',
  `pic` varchar(100) NOT NULL COMMENT '图片',
  `time` varchar(32) NOT NULL COMMENT '时间',
  `keywords` varchar(100) NOT NULL COMMENT '关键词',
  `description` varchar(200) NOT NULL COMMENT '描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='社区分类表';

-- ----------------------------
-- Records of wd_forumcate
-- ----------------------------
INSERT INTO `wd_forumcate` VALUES ('1', '0', '云播放', '1', '1', '1', '1', '/uploads/20171107/cimgpng.png', '1507394242', '云播放', '无需安装软件，只要有网就可以播放，方便');
INSERT INTO `wd_forumcate` VALUES ('2', '1', '电视剧', '1', '1', '1', '1', '', '1507553523', '电视剧，云播放，在线播放，', '电视剧，无需安装下载播放器，云播放，在线播放，快速播放，快速缓存');
INSERT INTO `wd_forumcate` VALUES ('3', '1', '电影', '1', '1', '1', '1', '', '1507553558', '电影', '电影，云播放，无需安装下载，安全，快速');

-- ----------------------------
-- Table structure for wd_love
-- ----------------------------
DROP TABLE IF EXISTS `wd_love`;
CREATE TABLE `wd_love` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `ltime` datetime NOT NULL,
  `cid` int(10) unsigned NOT NULL COMMENT '文章id',
  `uid` int(10) NOT NULL COMMENT '当前用户登录id',
  `mid` int(10) NOT NULL COMMENT ' author id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_love
-- ----------------------------
INSERT INTO `wd_love` VALUES ('47', '2017-12-08 00:08:31', '22', '13', '16');
INSERT INTO `wd_love` VALUES ('48', '2017-12-10 01:56:12', '4', '17', '5');
INSERT INTO `wd_love` VALUES ('49', '2017-12-10 02:09:54', '4', '13', '5');
INSERT INTO `wd_love` VALUES ('50', '2017-12-10 02:19:21', '5', '13', '6');
INSERT INTO `wd_love` VALUES ('51', '2017-12-12 23:34:35', '1', '13', '5');

-- ----------------------------
-- Table structure for wd_makecon
-- ----------------------------
DROP TABLE IF EXISTS `wd_makecon`;
CREATE TABLE `wd_makecon` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `prourl` varchar(200) DEFAULT NULL,
  `pdate` datetime DEFAULT NULL,
  `pname` varchar(30) DEFAULT NULL,
  `uid` int(10) DEFAULT NULL,
  `pstatus` tinyint(1) NOT NULL DEFAULT '1',
  `path` varchar(200) DEFAULT NULL,
  `count` int(10) DEFAULT '0',
  `minfo` text,
  `mtype` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_makecon
-- ----------------------------
INSERT INTO `wd_makecon` VALUES ('1', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '8', '王牌保镖7', '网络影视');
INSERT INTO `wd_makecon` VALUES ('2', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '4', '王牌保镖77', '网络影视');
INSERT INTO `wd_makecon` VALUES ('3', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '5', '王牌保镖55555555', '网络影视');
INSERT INTO `wd_makecon` VALUES ('4', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '38', '王牌保镖666668', '网络影视');
INSERT INTO `wd_makecon` VALUES ('5', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '9', '王牌保镖888', '网络影视');
INSERT INTO `wd_makecon` VALUES ('6', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '13', '2', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '5', '王牌保镖88332', '网络影视');
INSERT INTO `wd_makecon` VALUES ('7', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '2', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '10', '王牌保镖333', '网络影视');
INSERT INTO `wd_makecon` VALUES ('8', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '4', '王牌保镖ew23', '网络影视');
INSERT INTO `wd_makecon` VALUES ('9', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '2', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '0', '王牌保镖sad', '网络影视');
INSERT INTO `wd_makecon` VALUES ('10', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '王牌保镖aaa', '网络影视');
INSERT INTO `wd_makecon` VALUES ('11', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '2', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '王牌保镖aaa', '网络影视');
INSERT INTO `wd_makecon` VALUES ('12', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '王牌保镖tttttttttss', '网络影视');
INSERT INTO `wd_makecon` VALUES ('13', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '13', '2', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '1', '王牌保镖ttttt', '网络影视');
INSERT INTO `wd_makecon` VALUES ('14', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '王牌保镖e', '网络影视');
INSERT INTO `wd_makecon` VALUES ('15', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '2', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '王牌保镖eeeeee', '网络影视');
INSERT INTO `wd_makecon` VALUES ('16', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '1', '王牌保镖rrrrr', '网络影视');
INSERT INTO `wd_makecon` VALUES ('17', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '0', '王牌保镖fff', '网络影视');
INSERT INTO `wd_makecon` VALUES ('18', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '13', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '1', '万大网络承接软件开发43', '网络影视');
INSERT INTO `wd_makecon` VALUES ('19', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发333333', '网络影视');
INSERT INTO `wd_makecon` VALUES ('20', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发rrrrrrrr', '网络影视');
INSERT INTO `wd_makecon` VALUES ('21', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '2', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '0', '万大网络承接软件开发h', '网络影视');
INSERT INTO `wd_makecon` VALUES ('22', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('23', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '2', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('24', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '2', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '1', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('25', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('26', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('27', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('28', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('29', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('30', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('31', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('32', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('33', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('34', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('35', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('36', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('37', '/uploads/20171107/cimgpng.png', '2017-11-14 22:27:36', '蜘蛛侠:英雄归来', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('38', '/uploads/20171107/cimgpng.png', '2017-11-14 22:30:46', '王牌保镖', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('39', '/uploads/20171107/cimgpng.png', '2017-11-14 23:23:42', '网盘', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('40', '/uploads/20171107/cimgpng.png', '2017-11-14 23:24:10', '切尔', '6', '1', 'http://player.youku.com/embed/XMzExNDgyNzU0NA==', '0', '万大网络承接软件开发', '网络影视');
INSERT INTO `wd_makecon` VALUES ('41', '/uploads/20171107/cimgpng.png', '2017-11-28 18:45:16', 'aaaaaaaaaaaaa', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '2', null, null);
INSERT INTO `wd_makecon` VALUES ('42', '/uploads/20171107/cimgpng.png', '2017-11-28 21:17:39', 'asddfgkjhgfs', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '4', null, null);
INSERT INTO `wd_makecon` VALUES ('43', '/uploads/20171107/cimgpng.png', '2017-11-28 21:28:41', '猎场', '6', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '102', null, null);
INSERT INTO `wd_makecon` VALUES ('44', '/uploads/20171107/cimgpng.png', '2017-11-28 21:33:40', 'sfghgf', '13', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '35', null, null);
INSERT INTO `wd_makecon` VALUES ('45', '/uploads/20171107/cimgpng.png', '2017-11-28 21:41:47', 'aa的作品', '14', '1', 'http://player.youku.com/embed/XMzEyMTcwNjAyMA==', '52', null, null);

-- ----------------------------
-- Table structure for wd_message
-- ----------------------------
DROP TABLE IF EXISTS `wd_message`;
CREATE TABLE `wd_message` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '所属会员',
  `touid` int(11) NOT NULL DEFAULT '0' COMMENT '发送对象',
  `type` tinyint(3) NOT NULL DEFAULT '1' COMMENT '1系统消息2帖子动态',
  `content` text NOT NULL COMMENT '内容',
  `time` varchar(32) NOT NULL COMMENT '时间',
  `status` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态 1 显示  2 隐藏',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='消息表';

-- ----------------------------
-- Records of wd_message
-- ----------------------------
INSERT INTO `wd_message` VALUES ('1', '5', '5', '2', '4', '1507544946', '1');
INSERT INTO `wd_message` VALUES ('2', '5', '5', '2', '4', '1507550081', '1');
INSERT INTO `wd_message` VALUES ('3', '5', '5', '2', '4', '1507550835', '1');

-- ----------------------------
-- Table structure for wd_readmessage
-- ----------------------------
DROP TABLE IF EXISTS `wd_readmessage`;
CREATE TABLE `wd_readmessage` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `uid` int(11) NOT NULL COMMENT '会员',
  `mid` int(11) NOT NULL DEFAULT '0' COMMENT '消息对象',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='消息表';

-- ----------------------------
-- Records of wd_readmessage
-- ----------------------------

-- ----------------------------
-- Table structure for wd_setmsg
-- ----------------------------
DROP TABLE IF EXISTS `wd_setmsg`;
CREATE TABLE `wd_setmsg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender_id` int(11) NOT NULL COMMENT '发送者 真实id',
  `accept_id` int(11) NOT NULL COMMENT '接受者真实id',
  `content` varchar(255) DEFAULT NULL COMMENT '内容',
  `type` tinyint(4) NOT NULL DEFAULT '1' COMMENT '类型 私信消息1',
  `status` tinyint(4) NOT NULL DEFAULT '1' COMMENT '消息状态 1：未读 2：已读 3：删除',
  `time` int(11) NOT NULL COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_setmsg
-- ----------------------------
INSERT INTO `wd_setmsg` VALUES ('1', '13', '15', '第五位', '1', '1', '1512903813');
INSERT INTO `wd_setmsg` VALUES ('2', '13', '15', '你是谁 我是A', '1', '1', '1512906834');
INSERT INTO `wd_setmsg` VALUES ('3', '13', '14', '你好啊', '1', '1', '1512908469');
INSERT INTO `wd_setmsg` VALUES ('4', '13', '16', 'rdfkyku', '1', '1', '1513092749');
INSERT INTO `wd_setmsg` VALUES ('5', '15', '13', '滚', '1', '1', '1512908469');
INSERT INTO `wd_setmsg` VALUES ('6', '16', '13', '25165', '1', '1', '1512908469');
INSERT INTO `wd_setmsg` VALUES ('7', '15', '16', 'nimabide', '1', '1', '1513096998');
INSERT INTO `wd_setmsg` VALUES ('8', '15', '16', 'laji', '1', '1', '1513097006');
INSERT INTO `wd_setmsg` VALUES ('9', '16', '15', '哈哈哈哈', '1', '1', '1513097006');
INSERT INTO `wd_setmsg` VALUES ('10', '16', '15', 'ergrrrgr', '1', '1', '1513097327');
INSERT INTO `wd_setmsg` VALUES ('11', '15', '16', '你个垃圾', '1', '1', '1513097668');
INSERT INTO `wd_setmsg` VALUES ('12', '16', '15', 'gunnimabi', '1', '1', '1513097689');
INSERT INTO `wd_setmsg` VALUES ('13', '13', '17', 'opdhwefurhui', '1', '1', '1513179732');

-- ----------------------------
-- Table structure for wd_user
-- ----------------------------
DROP TABLE IF EXISTS `wd_user`;
CREATE TABLE `wd_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `point` int(11) NOT NULL DEFAULT '0' COMMENT '积分',
  `userip` varchar(32) NOT NULL COMMENT 'IP',
  `username` varchar(32) NOT NULL COMMENT '名称',
  `password` varchar(200) NOT NULL COMMENT '密码',
  `userhead` varchar(100) DEFAULT '/uploads/20171107/cimgpng.png' COMMENT '头像',
  `email` varchar(32) NOT NULL COMMENT '邮箱',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机',
  `regtime` varchar(32) NOT NULL COMMENT '注册时间',
  `grades` tinyint(1) NOT NULL DEFAULT '0' COMMENT '等级',
  `sex` tinyint(1) NOT NULL DEFAULT '2' COMMENT '性别 男2 女 1',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '验证1表示正常2邮箱验证3手机认证5手机邮箱全部认证',
  `userhome` varchar(32) DEFAULT NULL COMMENT '家乡',
  `description` varchar(200) DEFAULT NULL COMMENT '描述',
  `last_login_time` varchar(20) DEFAULT '0' COMMENT '最后登陆时间',
  `last_login_ip` varchar(50) DEFAULT '' COMMENT '最后登录IP',
  `name` varchar(20) DEFAULT NULL COMMENT '姓名',
  `usertype` tinyint(1) DEFAULT NULL COMMENT '用户类型1文章 2技术交流  3圈子 4作品',
  `hangye` varchar(100) DEFAULT NULL COMMENT '行业',
  `birth` varchar(50) DEFAULT NULL COMMENT '生日',
  `zhiwei` varchar(50) DEFAULT NULL COMMENT '职位',
  `company` varchar(100) DEFAULT NULL COMMENT '在职公司',
  `info` varchar(200) DEFAULT NULL COMMENT '个人简介',
  `tech` varchar(200) DEFAULT NULL COMMENT '技能标签',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usermail` (`email`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of wd_user
-- ----------------------------
INSERT INTO `wd_user` VALUES ('6', '0', '0.0.0.0', 'szg', '7fef6171469e80d32c0559f88b377245', '/uploads/20171107/cimgpng.png', '834118115@qq.com', '13651858695', '2017-11-07 11:20:35', '0', '2', '1', '江苏,淮安,洪泽', null, '2017-12-10 16:38:16', '127.0.0.1', '石志刚', '1', '影视', '2003-1-16', '经理', '上海万大网络科技有限公司', '软件开发工程师', '软件开发工程师');
INSERT INTO `wd_user` VALUES ('13', '0', '127.0.0.1', 'aa', '7fef6171469e80d32c0559f88b377245', '/uploads/20171128/b7541c1cf3d6311251d50cbb54716c2a.jpg', '834118114@qq.com', '13472851836', '2017-11-28 18:29:46', '0', '2', '1', '江苏,淮安,洪泽', null, '2017-12-18 00:01:58', '127.0.0.1', '石志刚1', '1', '影视', '2003-1-16', '经理', '上海万大网络科技有限公司', '软件开发工程师', '软件、开发、工程');
INSERT INTO `wd_user` VALUES ('14', '0', '127.0.0.1', 'bb', '7fef6171469e80d32c0559f88b377245', '/uploads/20171107/cimgpng.png', '834118114@163.com', '18201830954', '2017-11-28 18:30:13', '0', '2', '1', '江苏,淮安,洪泽', null, '2017-11-28 21:35:35', '127.0.0.1', '石志刚2', '2', '影视', '2003-1-16', '经理', '上海万大网络科技有限公司', '软件开发工程师', '软件开发工程师？？？？？？ 导演 演员 诗人');
INSERT INTO `wd_user` VALUES ('15', '0', '127.0.0.1', 'cc', '7fef6171469e80d32c0559f88b377245', '/uploads/20171107/cimgpng.png', '834118114@126.com', '18213654951', '2017-11-28 18:30:50', '0', '1', '1', '江苏,淮安,洪泽', null, '2017-12-13 00:54:00', '127.0.0.1', '石志刚3', '3', '影视', '2003-1-16', '经理', '上海万大网络科技有限公司', '软件开发工程师', '软件开发工程师');
INSERT INTO `wd_user` VALUES ('16', '0', '127.0.0.1', 'test', '7fef6171469e80d32c0559f88b377245', '/uploads/20171107/cimgpng.png', '123456@qq.com', '12345678910', '2017-12-01 21:19:36', '0', '2', '1', '吉林,四平,公主岭', null, '2017-12-13 00:46:19', '127.0.0.1', 'vv', '1', '技术', '2003-10-17', '经理', '', '软件开发工程师', '软件、开发、工程');
INSERT INTO `wd_user` VALUES ('17', '0', '127.0.0.1', '123456', '967cdece05c6513b22f03f42c93e7242', '/uploads/20171107/cimgpng.png', 'admin123@qq.com', '13472514254', '2017-12-09 22:44:50', '0', '2', '1', '江苏,盐城,阜宁', null, '2017-12-09 22:45:08', '127.0.0.1', 'qqqqq', '2', '电影', '2003-4-17', '老板', '上海环球', '', '电视、电脑');

-- ----------------------------
-- Table structure for wd_usergrade
-- ----------------------------
DROP TABLE IF EXISTS `wd_usergrade`;
CREATE TABLE `wd_usergrade` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) NOT NULL COMMENT '名称',
  `score` int(11) NOT NULL COMMENT '等级所需积分',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 COMMENT='会员等级表';

-- ----------------------------
-- Records of wd_usergrade
-- ----------------------------
INSERT INTO `wd_usergrade` VALUES ('1', 'VIP会员', '10000');
INSERT INTO `wd_usergrade` VALUES ('2', '普通会员', '1000');

-- ----------------------------
-- Table structure for wd_ver
-- ----------------------------
DROP TABLE IF EXISTS `wd_ver`;
CREATE TABLE `wd_ver` (
  `vid` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `vimg` varchar(200) NOT NULL,
  `vyear` varchar(10) DEFAULT NULL,
  `vzhiye` varchar(50) DEFAULT NULL,
  `uid` int(10) unsigned NOT NULL,
  `vstatus` tinyint(1) DEFAULT NULL,
  `vdate` datetime DEFAULT NULL,
  PRIMARY KEY (`vid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of wd_ver
-- ----------------------------
INSERT INTO `wd_ver` VALUES ('2', '/uploads/20171107/cimgpng.png', '2009', '导演', '6', '1', null);

-- ----------------------------
-- Table structure for wd_zan
-- ----------------------------
DROP TABLE IF EXISTS `wd_zan`;
CREATE TABLE `wd_zan` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `uid` tinyint(3) unsigned NOT NULL COMMENT '顶部还是底部',
  `sid` tinyint(3) unsigned NOT NULL COMMENT '对方id或者帖子id或者回复的id',
  `time` varchar(20) DEFAULT '0' COMMENT '操作时间',
  `type` tinyint(1) unsigned NOT NULL DEFAULT '1' COMMENT '状态  0 好友  1 帖子2 回复评论',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='导航表';

-- ----------------------------
-- Records of wd_zan
-- ----------------------------
SET FOREIGN_KEY_CHECKS=1;
