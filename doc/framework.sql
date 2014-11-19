/*
Navicat MySQL Data Transfer

Source Server         : localhost
Source Server Version : 50096
Source Host           : localhost:3306
Source Database       : framework

Target Server Type    : MYSQL
Target Server Version : 50096
File Encoding         : 65001

Date: 2014-11-19 14:28:52
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `dicdata`
-- ----------------------------
DROP TABLE IF EXISTS `dicdata`;
CREATE TABLE `dicdata` (
  `id` varchar(36) NOT NULL default '',
  `dic_code` varchar(50) NOT NULL default '',
  `dic_key` varchar(50) NOT NULL default '',
  `dic_value` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dicdata
-- ----------------------------
INSERT INTO `dicdata` VALUES ('1', 'common.istrue', 'Y', '是');
INSERT INTO `dicdata` VALUES ('2', 'common.istrue', 'N', '否');
INSERT INTO `dicdata` VALUES ('297e22cc49a78ca90149a78ca93f0000', 'tyzlk.common.jslocation', 'list', '列表');
INSERT INTO `dicdata` VALUES ('297e22cc49a78ca90149a78ca93f0001', 'tyzlk.common.jslocation', 'form', '表单');
INSERT INTO `dicdata` VALUES ('297e22cc49a862670149a862670d0000', 'tyzlk.plat.shbgn', 'isfwq_ywclj', '业务处理机');
INSERT INTO `dicdata` VALUES ('297e22cc49a862670149a862670d0001', 'tyzlk.plat.shbgn', 'isfwq_sjkfwq', '数据库服务器');
INSERT INTO `dicdata` VALUES ('297e22cc49a862670149a862670d0002', 'tyzlk.plat.shbgn', 'isfwq_jkfwq', '接口服务器');
INSERT INTO `dicdata` VALUES ('297e22cc49a8b1950149a8b1958f0000', 'tyzlk.plat.shbgn', 'iswlshb_fhq', '防火墙');
INSERT INTO `dicdata` VALUES ('297e22cc49a8b4910149a8b491ca0001', 'tyzlk.plat.shbgn', 'iswlshb_jhj', '交换机');
INSERT INTO `dicdata` VALUES ('297e22cc49a8b4910149a8b491ca0002', 'tyzlk.plat.shbgn', 'iswlshb_fzjh', '负载均衡');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6b5c0000', 'tyzlk.common.province', 'AH', '安徽');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0001', 'tyzlk.common.province', 'BJ', '北京');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0002', 'tyzlk.common.province', 'CQ', '重庆');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0003', 'tyzlk.common.province', 'FJ', '福建');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0004', 'tyzlk.common.province', 'GD', '广东');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0005', 'tyzlk.common.province', 'GS', '甘肃');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0006', 'tyzlk.common.province', 'GX', '广西');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0007', 'tyzlk.common.province', 'GZ', '贵州');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0008', 'tyzlk.common.province', 'HEB', '河北');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6baa0009', 'tyzlk.common.province', 'HEN', '河南');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bb9000a', 'tyzlk.common.province', 'HLJ', '黑龙江');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bb9000b', 'tyzlk.common.province', 'HN', '海南');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bb9000c', 'tyzlk.common.province', 'HUB', '湖北');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bb9000d', 'tyzlk.common.province', 'HUN', '湖南');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bc9000e', 'tyzlk.common.province', 'JL', '吉林');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bc9000f', 'tyzlk.common.province', 'JS', '江苏');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bc90010', 'tyzlk.common.province', 'JX', '江西');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bc90011', 'tyzlk.common.province', 'LN', '辽宁');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bc90012', 'tyzlk.common.province', 'NM', '内蒙');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bc90013', 'tyzlk.common.province', 'NX', '宁夏');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bc90014', 'tyzlk.common.province', 'QH', '青海');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd80015', 'tyzlk.common.province', 'SC', '四川');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd80016', 'tyzlk.common.province', 'SD', '山东');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd80017', 'tyzlk.common.province', 'SH', '上海');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd80018', 'tyzlk.common.province', 'SX', '陕西');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd80019', 'tyzlk.common.province', 'SXI', '山西');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd8001a', 'tyzlk.common.province', 'TJ', '天津');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd8001b', 'tyzlk.common.province', 'XJ', '新疆');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd8001c', 'tyzlk.common.province', 'XZ', '西藏');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd8001d', 'tyzlk.common.province', 'YN', '云南');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd8001e', 'tyzlk.common.province', 'ZJ', '浙江');
INSERT INTO `dicdata` VALUES ('4028b881499eee6b01499eee6bd8001f', 'tyzlk.common.province', 'JT', '集团');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8020000', 'tyzlk.common.ywxtbs', 'UDB', 'UDB');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120001', 'tyzlk.common.ywxtbs', 'MMSC', '彩信中心');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120002', 'tyzlk.common.ywxtbs', 'WAPGW', 'WAP网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120003', 'tyzlk.common.ywxtbs', 'ISAG', 'ISAG');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120004', 'tyzlk.common.ywxtbs', 'ISMP', 'ISMP');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120005', 'tyzlk.common.ywxtbs', 'SMSC', '短信中心');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120006', 'tyzlk.common.ywxtbs', 'SMG', '短信互通网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120007', 'tyzlk.common.ywxtbs', 'SMSGW', '短信业务网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120008', 'tyzlk.common.ywxtbs', 'IVR', 'IVR');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8120009', 'tyzlk.common.ywxtbs', 'MILR', '移动上网日志留存系统');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b812000a', 'tyzlk.common.ywxtbs', 'CRBT', '彩铃');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b821000b', 'tyzlk.common.ywxtbs', 'NSAG', 'NSAG');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b821000c', 'tyzlk.common.ywxtbs', 'ISAGR', 'ISAG-Router');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b821000d', 'tyzlk.common.ywxtbs', 'NMSC', 'NMSC');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b821000e', 'tyzlk.common.ywxtbs', 'MMSIG', '彩信互通网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b821000f', 'tyzlk.common.ywxtbs', 'MMSPA', '彩信相册');
INSERT INTO `dicdata` VALUES ('4028b881499ef0b801499ef0b8210010', 'tyzlk.common.ywxtbs', 'ISMG', '短信一级网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2047c0000', 'tyzlk.common.ptbh', '1', 'NMSC');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0001', 'tyzlk.common.ptbh', '2', '短信中心');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0002', 'tyzlk.common.ptbh', '3', '短信互通网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0003', 'tyzlk.common.ptbh', '4', '短信网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0004', 'tyzlk.common.ptbh', '5', 'IVR平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0005', 'tyzlk.common.ptbh', '6', 'ISMP');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0006', 'tyzlk.common.ptbh', '7', 'ISAG');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0007', 'tyzlk.common.ptbh', '8', 'ISAG Router');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0008', 'tyzlk.common.ptbh', '9', 'ENUM DNS');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c0009', 'tyzlk.common.ptbh', '10', '彩铃系统');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c000a', 'tyzlk.common.ptbh', '11', 'WAP网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c000b', 'tyzlk.common.ptbh', '12', 'WAP业务平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2048c000c', 'tyzlk.common.ptbh', '13', 'MMSC');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b000d', 'tyzlk.common.ptbh', '14', '定位系统');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b000e', 'tyzlk.common.ptbh', '15', 'Unija平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b000f', 'tyzlk.common.ptbh', '16', '流媒体');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0010', 'tyzlk.common.ptbh', '17', 'SPMC');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0011', 'tyzlk.common.ptbh', '18', '彩信互通网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0012', 'tyzlk.common.ptbh', '19', '省级融合支付平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0013', 'tyzlk.common.ptbh', '20', '总部融合支付平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0014', 'tyzlk.common.ptbh', '21', '天翼阅读平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0015', 'tyzlk.common.ptbh', '22', '商务领航平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0016', 'tyzlk.common.ptbh', '23', '综合IPN平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef2049b0017', 'tyzlk.common.ptbh', '24', '爱游戏平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0018', 'tyzlk.common.ptbh', '25', '手机报平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0019', 'tyzlk.common.ptbh', '26', 'WAP门户平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab001a', 'tyzlk.common.ptbh', '27', '定位调度平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab001b', 'tyzlk.common.ptbh', '28', '189邮箱');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab001c', 'tyzlk.common.ptbh', '29', '天翼空间');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab001d', 'tyzlk.common.ptbh', '30', '彩信相册');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab001e', 'tyzlk.common.ptbh', '35', 'UDB平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab001f', 'tyzlk.common.ptbh', '32', 'PIM平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0020', 'tyzlk.common.ptbh', '33', 'M2M');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0021', 'tyzlk.common.ptbh', '34', '移动上网日志留存系统');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0022', 'tyzlk.common.ptbh', '31', '省UDB平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0023', 'tyzlk.common.ptbh', '36', 'OTA平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0024', 'tyzlk.common.ptbh', '37', '云平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0025', 'tyzlk.common.ptbh', '38', '天翼视讯');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0026', 'tyzlk.common.ptbh', '39', '短信一级网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0027', 'tyzlk.common.ptbh', '40', 'CG网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0028', 'tyzlk.common.ptbh', '41', '网间AAA');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab0029', 'tyzlk.common.ptbh', '42', '国际信令检测');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab002a', 'tyzlk.common.ptbh', '43', '移动增值业务协议监测系统');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ab002b', 'tyzlk.common.ptbh', '44', '爱音乐');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba002c', 'tyzlk.common.ptbh', '45', '17900');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba002d', 'tyzlk.common.ptbh', '46', '4008');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba002e', 'tyzlk.common.ptbh', '47', '国漫欢迎短信');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba002f', 'tyzlk.common.ptbh', '48', '行业短信网关');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba0030', 'tyzlk.common.ptbh', '49', '终端自注册平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba0031', 'tyzlk.common.ptbh', '50', '综合VPN');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba0032', 'tyzlk.common.ptbh', '51', 'PRL平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba0033', 'tyzlk.common.ptbh', '52', '自写消息平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba0034', 'tyzlk.common.ptbh', '53', '车载信息化平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef20401499ef204ba0035', 'tyzlk.common.ptbh', '82', 'NSAG');
INSERT INTO `dicdata` VALUES ('4028b881499ef4ac01499ef4ac400000', 'tyzlk.basicinfo.ptlx', 'nll', '能力类');
INSERT INTO `dicdata` VALUES ('4028b881499ef4ac01499ef4ac500001', 'tyzlk.basicinfo.ptlx', 'gll', '管理类');
INSERT INTO `dicdata` VALUES ('4028b881499ef4ac01499ef4ac500002', 'tyzlk.basicinfo.ptlx', 'yyl', '应用类');
INSERT INTO `dicdata` VALUES ('4028b881499ef79501499ef795870000', 'tyzlk.basicinfo.ptyhqk', 'ypt', '云平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef79501499ef7959d0001', 'tyzlk.basicinfo.ptyhqk', 'bfypt', '部分云化平台');
INSERT INTO `dicdata` VALUES ('4028b881499ef79501499ef7959e0002', 'tyzlk.basicinfo.ptyhqk', 'wyh', '未云化');
INSERT INTO `dicdata` VALUES ('4028b88149a1bcf40149a1bcf46d0000', 'tyzlk.manage.shjrzhwg', 'issxjk', '接入实现设备级和业务级监控');
INSERT INTO `dicdata` VALUES ('4028b88149a1bcf40149a1bcf46d0001', 'tyzlk.manage.shjrzhwg', 'issxsbjk', '接入实现设备级监控');
INSERT INTO `dicdata` VALUES ('4028b88149a1bcf40149a1bcf46d0002', 'tyzlk.manage.shjrzhwg', 'isnojr', '没有接入');
INSERT INTO `dicdata` VALUES ('4028b88149a1c69e0149a1c69ed60003', 'tyzlk.manage.zchxtjr', 'isjrzhcx', '接入综合查询系统');
INSERT INTO `dicdata` VALUES ('4028b88149a1c69e0149a1c69ed60004', 'tyzlk.manage.zchxtjr', 'isnojrzhcx', '没有接入综合查询系统');
INSERT INTO `dicdata` VALUES ('4028b88149a1ce040149a1ce04c60000', 'tyzlk.manage.isaqjrsj', 'isjr', '已接入');
INSERT INTO `dicdata` VALUES ('4028b88149a1ce040149a1ce04d60001', 'tyzlk.manage.isaqjrsj', 'isnojr', '未接入');
INSERT INTO `dicdata` VALUES ('4028b88149a1d4b40149a1d4b4240000', 'tyzlk.business.ywzhyx', 'ishighest', '平台承载业务属于基础业务、战略性业务，重要性高');
INSERT INTO `dicdata` VALUES ('4028b88149a1d4b40149a1d4b4330001', 'tyzlk.business.ywzhyx', 'isbetter', '平台承载业务重要性较高');
INSERT INTO `dicdata` VALUES ('4028b88149a1d4b40149a1d4b4330002', 'tyzlk.business.ywzhyx', 'isgeneral', '平台承载业务重要性一般');
INSERT INTO `dicdata` VALUES ('4028b88149a1d4b40149a1d4b4330003', 'tyzlk.business.ywzhyx', 'islower', '平台承载业务重要性低');
INSERT INTO `dicdata` VALUES ('4028b88149a1d79f0149a1d79fa30000', 'tyzlk.business.ywshmzhq', 'ischshq', '成熟期');
INSERT INTO `dicdata` VALUES ('4028b88149a1d79f0149a1d79fb20001', 'tyzlk.business.ywshmzhq', 'ischzhq', '成长期');
INSERT INTO `dicdata` VALUES ('4028b88149a1d79f0149a1d79fb20002', 'tyzlk.business.ywshmzhq', 'isdrq', '导入期（孵化期）');
INSERT INTO `dicdata` VALUES ('4028b88149a1d79f0149a1d79fb20003', 'tyzlk.business.ywshmzhq', 'isshtq', '衰退期');
INSERT INTO `dicdata` VALUES ('4028b88149a1dbec0149a1dbecb10000', 'tyzlk.business.chzywzhyx', 'isjtzhd', '集团或省级重点、战略业务');
INSERT INTO `dicdata` VALUES ('4028b88149a1dbec0149a1dbecc00001', 'tyzlk.business.chzywzhyx', 'isptyw', '普通业务');
INSERT INTO `dicdata` VALUES ('4028b88149a1dbec0149a1dbecc00002', 'tyzlk.business.chzywzhyx', 'isnofzh', '明确不再发展的业务');
INSERT INTO `dicdata` VALUES ('4028b88149a1de6e0149a1de6ed30000', 'tyzlk.business.khlx', 'isdzhjkh', '党政军客户、集团客户');
INSERT INTO `dicdata` VALUES ('4028b88149a1de6e0149a1de6ee20001', 'tyzlk.business.khlx', 'isjtkh', '集团客户、行业客户、商业客户、公众客户');
INSERT INTO `dicdata` VALUES ('4028b88149a1de6e0149a1de6ee20002', 'tyzlk.business.khlx', 'ishykh', '行业客户、商业客户、公众客户');
INSERT INTO `dicdata` VALUES ('4028b88149a1e0db0149a1e0db440000', 'tyzlk.business.ywshx', 'isjtj', '集团级');
INSERT INTO `dicdata` VALUES ('4028b88149a1e0db0149a1e0db540001', 'tyzlk.business.ywshx', 'isshj', '省级');
INSERT INTO `dicdata` VALUES ('4028b88149a1e0db0149a1e0db540002', 'tyzlk.business.ywshx', 'islocal', '本地');
INSERT INTO `dicdata` VALUES ('4028b88149a1e4e40149a1e4e4f00000', 'tyzlk.plat.shjjg', 'issuccess', '成功');
INSERT INTO `dicdata` VALUES ('4028b88149a1e4e40149a1e4e4ff0001', 'tyzlk.plat.shjjg', 'iscallback', '回退');
INSERT INTO `dicdata` VALUES ('4028b88149a1e7e30149a1e7e3870000', 'tyzlk.plat.shblx', 'isfwq', '服务器');
INSERT INTO `dicdata` VALUES ('4028b88149a1e7e30149a1e7e3960001', 'tyzlk.plat.shblx', 'iswlshb', '网络设备');
INSERT INTO `dicdata` VALUES ('4028b88149a1e7e30149a1e7e3960002', 'tyzlk.plat.shblx', 'isxlqzhj', '信令前置机');
INSERT INTO `dicdata` VALUES ('4028b88149a1e7e30149a1e7e3960003', 'tyzlk.plat.shblx', 'iscch', '存储');
INSERT INTO `dicdata` VALUES ('4028b88149a1ef1a0149a1ef1afa0000', 'tyzlk.plat.shishjjq', 'isshj', '双机');
INSERT INTO `dicdata` VALUES ('4028b88149a1ef1a0149a1ef1b090001', 'tyzlk.plat.shishjjq', 'isjq', '集群');
INSERT INTO `dicdata` VALUES ('4028b88149a1f0890149a1f089da0000', 'tyzlk.plat.shidlshb', 'isdlshb', '平台独立设备');
INSERT INTO `dicdata` VALUES ('4028b88149a1f0890149a1f089ea0001', 'tyzlk.plat.shidlshb', 'isgyshb', '与其他平台共用设备');
INSERT INTO `dicdata` VALUES ('4028b88149a1f40a0149a1f40a6f0000', 'tyzlk.plat.yjchqnl', 'istgych', '可以通过堡垒机远程重启');
INSERT INTO `dicdata` VALUES ('4028b88149a1f40a0149a1f40a7e0001', 'tyzlk.plat.yjchqnl', 'isnoych', '不能通过堡垒机远程重启');
INSERT INTO `dicdata` VALUES ('4028b88149a1fa2a0149a1fa2abd0000', 'tyzlk.plat.czxtshq', 'isshq', '已授权');
INSERT INTO `dicdata` VALUES ('4028b88149a1fa2a0149a1fa2acc0001', 'tyzlk.plat.czxtshq', 'isnoshq', '未授权');
INSERT INTO `dicdata` VALUES ('4028b88149a1fcf40149a1fcf4b10000', 'tyzlk.plat.shijbrqjc', 'isjb', '具备');
INSERT INTO `dicdata` VALUES ('4028b88149a1fcf40149a1fcf4c10001', 'tyzlk.plat.shijbrqjc', 'isnojb', '不具备');
INSERT INTO `dicdata` VALUES ('4028b88149a1ffac0149a1ffac800000', 'tyzlk.plat.ptfqfyg', 'isfullmz', '满足');
INSERT INTO `dicdata` VALUES ('4028b88149a1ffac0149a1ffac8f0001', 'tyzlk.plat.ptfqfyg', 'isbigmz', '大部分满足');
INSERT INTO `dicdata` VALUES ('4028b88149a1ffac0149a1ffac8f0002', 'tyzlk.plat.ptfqfyg', 'islessmz', '小部分满足');
INSERT INTO `dicdata` VALUES ('4028b88149a1ffac0149a1ffac8f0003', 'tyzlk.plat.ptfqfyg', 'isnomz', '不满足');
INSERT INTO `dicdata` VALUES ('4028b88149a201aa0149a201aaac0000', 'tyzlk.plat.shijbnkaq', 'isjb', '具备');
INSERT INTO `dicdata` VALUES ('4028b88149a201aa0149a201aabb0001', 'tyzlk.plat.shijbnkaq', 'ispartjb', '部分具备');
INSERT INTO `dicdata` VALUES ('4028b88149a201aa0149a201aabb0002', 'tyzlk.plat.shijbnkaq', 'isnojb', '不具备');
INSERT INTO `dicdata` VALUES ('4028b88149a204160149a20416f90000', 'tyzlk.plat.gjshjbfnl', 'isjball', '具备网络异地备份功能及本地其他介质备份');
INSERT INTO `dicdata` VALUES ('4028b88149a204160149a20417090001', 'tyzlk.plat.gjshjbfnl', 'isjbyd', '具备异地介质备份');
INSERT INTO `dicdata` VALUES ('4028b88149a204160149a20417090002', 'tyzlk.plat.gjshjbfnl', 'isjblocal', '本地备份能力');
INSERT INTO `dicdata` VALUES ('4028b88149a204160149a20417090003', 'tyzlk.plat.gjshjbfnl', 'isnojb', '不具备备份功能');
INSERT INTO `dicdata` VALUES ('4028b88149a208580149a20858dc0000', 'tyzlk.business.ywshmzhqyy', 'ischsh', '成熟期');
INSERT INTO `dicdata` VALUES ('4028b88149a208580149a20858ec0001', 'tyzlk.business.ywshmzhqyy', 'isyrchz', '引入期（孵化期）、成长期');
INSERT INTO `dicdata` VALUES ('4028b88149a208580149a20858fb0002', 'tyzlk.business.ywshmzhqyy', 'issht', '衰退期');

-- ----------------------------
-- Table structure for `online_cgreport_head`
-- ----------------------------
DROP TABLE IF EXISTS `online_cgreport_head`;
CREATE TABLE `online_cgreport_head` (
  `ID` varchar(36) NOT NULL,
  `CGR_SQL` longtext NOT NULL,
  `CODE` varchar(36) NOT NULL,
  `CONTENT` longtext NOT NULL,
  `NAME` varchar(100) NOT NULL,
  `ISCHART` varchar(2) NOT NULL default 'N',
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of online_cgreport_head
-- ----------------------------
INSERT INTO `online_cgreport_head` VALUES ('4dd7b0e035f74b5dbc145bf3e0a319d1', 'select a.recordOpeningTime,a.billtype,a.ratinggroup,round(a.uplink/1024/1024/100,2) as uplink,round(a.downlink/1024/1024,2) as downlink,round(a.duration/3600,2) as duration from ratinggroup_day  a order by  recordOpeningTime,(uplink+downlink) desc', 't_s_log', 't_s_log', 't_s_log', 'Y');
INSERT INTO `online_cgreport_head` VALUES ('890e668ffd6844698616817acdabb19a', 'select NAME,URL,SYRESOURCE_ID from syresource', 'fffff', 'fff', '标题', 'N');

-- ----------------------------
-- Table structure for `online_cgreport_item`
-- ----------------------------
DROP TABLE IF EXISTS `online_cgreport_item`;
CREATE TABLE `online_cgreport_item` (
  `ID` varchar(36) NOT NULL,
  `S_FLAG` varchar(2) default NULL,
  `S_MODE` varchar(10) default NULL,
  `CGRHEAD_ID` varchar(36) default NULL,
  `DICT_CODE` varchar(36) default NULL,
  `FIELD_HREF` varchar(120) default NULL,
  `FIELD_NAME` varchar(36) default NULL,
  `FIELD_TXT` longtext,
  `FIELD_WIDTH` int(11) default NULL,
  `FIELD_TYPE` varchar(10) default NULL,
  `IS_SHOW` varchar(5) default NULL,
  `ORDER_NUM` int(11) default NULL,
  `REPLACE_VA` varchar(36) default NULL,
  `CHART_FIELD` varchar(36) default NULL,
  `DEFAULT_VALUE` varchar(50) default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of online_cgreport_item
-- ----------------------------
INSERT INTO `online_cgreport_item` VALUES ('520b038b3e684c22a62e5a78d8cb5539', 'Y', 'single', '890e668ffd6844698616817acdabb19a', '', '', 'SYRESOURCE_ID', '资源id', '300', 'String', 'Y', '3', '', '', '');
INSERT INTO `online_cgreport_item` VALUES ('8aad94b2c45d440faad230283b4802da', 'Y', 'single', '890e668ffd6844698616817acdabb19a', '', '', 'URL', 'url地址', '300', 'String', 'Y', '2', '', '', '');
INSERT INTO `online_cgreport_item` VALUES ('965303354d154f2d8a022178a5acf1f8', 'Y', 'single', '890e668ffd6844698616817acdabb19a', '', '', 'NAME', '名称', '300', 'String', 'Y', '1', '', '', '');

-- ----------------------------
-- Table structure for `online_head`
-- ----------------------------
DROP TABLE IF EXISTS `online_head`;
CREATE TABLE `online_head` (
  `id` varchar(36) NOT NULL default '',
  `tablename` varchar(50) NOT NULL default '',
  `title` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of online_head
-- ----------------------------
INSERT INTO `online_head` VALUES ('1', 'sys_config_para', '系统参数');
INSERT INTO `online_head` VALUES ('2', 'dicdata', '数据字典');
INSERT INTO `online_head` VALUES ('4028b881499899220149989cd5e50002', 'tyzlk_manage_department', '维护单位');
INSERT INTO `online_head` VALUES ('4028b88149989922014998a98841000d', 'tyzlk_manage_person', '维护人员信息');
INSERT INTO `online_head` VALUES ('4028b88149989922014998ae4364001c', 'tyzlk_manage_manufacturer_person', '厂商维护人员信息');
INSERT INTO `online_head` VALUES ('4028b881499c7fe301499c8101dd0002', 'tyzlk_manage_interface_system', '平台对外接入管理类系统情况');
INSERT INTO `online_head` VALUES ('4028b881499c7fe301499c9234ab0011', 'tyzlk_manage_plat_gradeinfo', '平台分等级情况');
INSERT INTO `online_head` VALUES ('4028b881499cb17501499cb8824a0019', 'tyzlk_plat_device_info', '平台硬件信息');
INSERT INTO `online_head` VALUES ('4028b881499cb17501499cc0d02b0039', 'tyzlk_plat_fault_info', '平台故障信息');
INSERT INTO `online_head` VALUES ('4028b881499cb17501499cc9256f0069', 'tyzlk_plat_security_info', '平台安全信息');
INSERT INTO `online_head` VALUES ('4028b881499cb17501499ccf90d80070', 'tyzlk_business_busiinfo', '平台业务信息');
INSERT INTO `online_head` VALUES ('4028b881499cb17501499cd38552007e', 'tyzlk_business_logicinfo', '平台逻辑信息');
INSERT INTO `online_head` VALUES ('4028b881499cb17501499ce06932009c', 'tyzlk_plat_soft_info', '平台软件信息');

-- ----------------------------
-- Table structure for `online_head_enhance_js`
-- ----------------------------
DROP TABLE IF EXISTS `online_head_enhance_js`;
CREATE TABLE `online_head_enhance_js` (
  `id` varchar(36) NOT NULL default '' COMMENT 'ID字段',
  `headid` varchar(36) NOT NULL default '' COMMENT '所属HEAD表ID',
  `js_location` varchar(10) NOT NULL COMMENT 'js位置：list，列表，form,表单',
  `jscontent` longtext NOT NULL COMMENT 'JS内容',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='JS增强';

-- ----------------------------
-- Records of online_head_enhance_js
-- ----------------------------
INSERT INTO `online_head_enhance_js` VALUES ('297e22cc49a88b820149a8b7ed670000', '4028b881499cb17501499cb8824a0019', 'form', '$(function(){\r\n    $(\'#device_type\').combobox({\r\n	    onSelect: function(_record){\r\n		var device_type = $(\'#device_type\').combobox(\'getValue\');\r\n	  	var url = fullpath + \'/dicDataController.do?likeQueryDic&dic_code=tyzlk.plat.shbgn&dic_key=\'+device_type+\'_\';\r\n		$(\'#device_funtion\').combobox(\'setValue\',\'\');\r\n		$(\'#device_funtion\').combobox(\'reload\',url); \r\n	    }\r\n    });\r\n});');

-- ----------------------------
-- Table structure for `online_item`
-- ----------------------------
DROP TABLE IF EXISTS `online_item`;
CREATE TABLE `online_item` (
  `id` varchar(36) NOT NULL default '',
  `headid` varchar(36) NOT NULL default '',
  `fieldname` varchar(50) NOT NULL default '',
  `fieldtitle` varchar(50) NOT NULL default '',
  `fieldtype` varchar(10) NOT NULL default '',
  `isquery` varchar(10) NOT NULL default 'N',
  `isshow` varchar(10) NOT NULL default 'Y',
  `is_exact_match` varchar(10) NOT NULL default 'Y',
  `is_addupdate` varchar(10) default NULL,
  `order_num` int(11) default NULL,
  `data_options` varchar(100) default '',
  `dic_code` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of online_item
-- ----------------------------
INSERT INTO `online_item` VALUES ('4', '2', 'dic_code', '字典代码', 'text', 'Y', 'Y', 'N', 'Y', '1', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49976196014997965eb40009', '1', 'para_value', '参数值', 'text', 'Y', 'Y', 'N', 'Y', '1', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49976196014997965eb4000a', '1', 'para_desc', '描述', 'text', 'N', 'Y', 'Y', 'Y', '1', '', '');
INSERT INTO `online_item` VALUES ('4028946a49976196014997965eb4000b', '1', 'para_name', '参数名称', 'text', 'Y', 'Y', 'N', 'Y', '1', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e75fd0007', '4028b881499cb17501499cb8824a0019', 'device_remote_reboot', '硬件远程重启能力', 'combobox', 'N', 'Y', 'Y', 'Y', '20', 'required:true', 'tyzlk.plat.yjchqnl');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e75fd0008', '4028b881499cb17501499cb8824a0019', 'is_jifang_address', '机房地址', 'text', 'N', 'Y', 'Y', 'Y', '19', '', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e75fd0009', '4028b881499cb17501499cb8824a0019', 'is_plat_alone_device', '是否平台独立设备', 'combobox', 'N', 'Y', 'Y', 'Y', '18', 'required:true', 'tyzlk.plat.shidlshb');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e75fd000a', '4028b881499cb17501499cb8824a0019', 'is_double_or_multi', '是否双机/集群', 'combobox', 'N', 'Y', 'Y', 'Y', '17', 'required:true', 'tyzlk.plat.shishjjq');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d000b', '4028b881499cb17501499cb8824a0019', 'device_manufacturer', '设备厂商', 'text', 'Y', 'Y', 'Y', 'Y', '15', '', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d000c', '4028b881499cb17501499cb8824a0019', 'device_zc_no', '资产编号', 'text', 'N', 'Y', 'Y', 'Y', '14', '', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d000d', '4028b881499cb17501499cb8824a0019', 'device_typeno', '设备型号', 'text', 'Y', 'Y', 'Y', 'Y', '13', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d000e', '4028b881499cb17501499cb8824a0019', 'device_funtion', '设备功能', 'combobox', 'N', 'Y', 'Y', 'Y', '12', '', 'tyzlk.plat.shbgn');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d000f', '4028b881499cb17501499cb8824a0019', 'device_type', '设备类型', 'combobox', 'N', 'Y', 'Y', 'Y', '11', 'required:true', 'tyzlk.plat.shblx');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0010', '4028b881499cb17501499cb8824a0019', 'device_seqno', '设备序列号', 'text', 'N', 'Y', 'Y', 'Y', '10', '', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0011', '4028b881499cb17501499cb8824a0019', 'device_starttime', '设备启用时间', 'date', 'N', 'Y', 'Y', 'Y', '9', '', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0012', '4028b881499cb17501499cb8824a0019', 'eth_size', '网卡个数', 'text', 'N', 'Y', 'Y', 'Y', '8', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0013', '4028b881499cb17501499cb8824a0019', 'hardware_size', '硬盘大小', 'text', 'N', 'Y', 'Y', 'Y', '7', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0014', '4028b881499cb17501499cb8824a0019', 'memory_size', '内存大小', 'text', 'N', 'Y', 'Y', 'Y', '6', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0015', '4028b881499cb17501499cb8824a0019', 'cpu_count', 'CPU颗数', 'text', 'N', 'Y', 'Y', 'Y', '5', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0016', '4028b881499cb17501499cb8824a0019', 'host_service_ip', '主机服务IP', 'text', 'N', 'Y', 'Y', 'Y', '4', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0017', '4028b881499cb17501499cb8824a0019', 'host_name', '主机名称', 'text', 'N', 'Y', 'Y', 'Y', '3', '', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e760d0018', '4028b881499cb17501499cb8824a0019', 'host_is_device', '主机是否为物理设备', 'combobox', 'N', 'Y', 'Y', 'Y', '2', 'required:true', 'common.istrue');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e761c0019', '4028b881499cb17501499cb8824a0019', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac5e761c001a', '4028b881499cb17501499cb8824a0019', 'is_core_device', '是否为核心设备', 'combobox', 'N', 'Y', 'Y', 'Y', '16', 'required:true', 'common.istrue');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac9050fd002b', '4028b88149989922014998a98841000d', 'email', '邮箱', 'text', 'N', 'Y', 'Y', 'Y', '4', '', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac9050fd002c', '4028b88149989922014998a98841000d', 'phone', '手机', 'text', 'Y', 'Y', 'Y', 'Y', '3', 'required:true,validType:\"mobile\"', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac9050fd002d', '4028b88149989922014998a98841000d', 'name', '姓名', 'text', 'Y', 'Y', 'Y', 'Y', '2', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028946a49ac2a800149ac9050fd002e', '4028b88149989922014998a98841000d', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22264450015', '4028b881499899220149989cd5e50002', 'department', '维护单位', 'text', 'Y', 'Y', 'Y', 'Y', '2', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22264450016', '4028b881499899220149989cd5e50002', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a226fc79002b', '4028b88149989922014998ae4364001c', 'email', '邮箱', 'text', 'N', 'Y', 'Y', 'Y', '4', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a226fc79002c', '4028b88149989922014998ae4364001c', 'phone', '电话', 'text', 'Y', 'Y', 'Y', 'Y', '3', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a226fc79002d', '4028b88149989922014998ae4364001c', 'name', '姓名', 'text', 'Y', 'Y', 'Y', 'Y', '2', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a226fc79002e', '4028b88149989922014998ae4364001c', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22b2823003a', '4028b881499c7fe301499c8101dd0002', 'is_nrzhwg', '是否纳入综合网管系统', 'combobox', 'N', 'Y', 'Y', 'Y', '5', 'required:true', 'common.istrue');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22b2824003b', '4028b881499c7fe301499c8101dd0002', 'is_security_sj', '是否安全接入审计', 'combobox', 'N', 'Y', 'Y', 'Y', '4', 'required:true', 'tyzlk.manage.isaqjrsj');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22b2824003c', '4028b881499c7fe301499c8101dd0002', 'jr_system_zc', '支撑系统接入', 'combobox', 'N', 'Y', 'Y', 'Y', '3', 'required:true', 'tyzlk.manage.zchxtjr');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22b2824003d', '4028b881499c7fe301499c8101dd0002', 'jrzhwg_info', '是否接入综合网管', 'combobox', 'N', 'Y', 'Y', 'Y', '2', 'required:true', 'tyzlk.manage.shjrzhwg');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22b2825003e', '4028b881499c7fe301499c8101dd0002', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22d91560041', '4028b881499c7fe301499c9234ab0011', 'plat_business_grade', '平台业务等级', 'text', 'N', 'Y', 'Y', 'Y', '3', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22d91560042', '4028b881499c7fe301499c9234ab0011', 'plat_ability_grade', '平台能力等级', 'text', 'N', 'Y', 'Y', 'Y', '2', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a22d91560043', '4028b881499c7fe301499c9234ab0011', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a26d719000b2', '4028b881499cb17501499cc0d02b0039', 'fault_resolved_time', '故障修复时间', 'date', 'N', 'Y', 'Y', 'Y', '5', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a26d719000b3', '4028b881499cb17501499cc0d02b0039', 'fault_desc', '故障描述', 'text', 'N', 'Y', 'Y', 'Y', '4', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a26d719000b4', '4028b881499cb17501499cc0d02b0039', 'fault_starttime', '故障发生时间', 'date', 'N', 'Y', 'Y', 'Y', '3', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a26d719000b5', '4028b881499cb17501499cc0d02b0039', 'fault_id', '服保系统故障ID号', 'text', 'Y', 'Y', 'Y', 'Y', '2', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a26d719000b6', '4028b881499cb17501499cc0d02b0039', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a272865a00be', '4028b881499cb17501499cc9256f0069', 'is_bak_kvm', '是否具备KVM', 'combobox', 'N', 'Y', 'Y', 'Y', '6', 'required:true', 'tyzlk.plat.shijbrqjc');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a272866300bf', '4028b881499cb17501499cc9256f0069', 'important_data_bakability', '关键数据备份能力', 'combobox', 'N', 'Y', 'Y', 'Y', '5', 'required:true', 'tyzlk.plat.gjshjbfnl');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a272866400c0', '4028b881499cb17501499cc9256f0069', 'is_passord_auth_fun', '是否具备密码符合内控安全管理功能', 'combobox', 'N', 'Y', 'Y', 'Y', '4', 'required:true', 'tyzlk.plat.shijbnkaq');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a272866400c1', '4028b881499cb17501499cc9256f0069', 'is_plat_zone_auth_fun', '平台分权分域功能', 'combobox', 'N', 'Y', 'Y', 'Y', '3', 'required:true', 'tyzlk.plat.ptfqfyg');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a272866500c2', '4028b881499cb17501499cc9256f0069', 'is_jbrqjcfh', '是否具备入侵检测防护', 'combobox', 'N', 'Y', 'Y', 'Y', '2', 'required:true', 'tyzlk.plat.shijbrqjc');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a272866600c3', '4028b881499cb17501499cc9256f0069', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb00fb', '4028b881499cb17501499ccf90d80070', 'plat_day_avg_value', '日均业务量', 'text', 'N', 'Y', 'Y', 'Y', '13', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb00fc', '4028b881499cb17501499ccf90d80070', 'plat_system_design_ability', '系统软件设计处理能力', 'text', 'N', 'Y', 'Y', 'Y', '12', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb00fd', '4028b881499cb17501499ccf90d80070', 'plat_busy_value', '忙时业务量', 'text', 'N', 'Y', 'Y', 'Y', '11', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb00fe', '4028b881499cb17501499ccf90d80070', 'plat_year_income', '平台年收入', 'text', 'N', 'Y', 'Y', 'Y', '10', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb00ff', '4028b881499cb17501499ccf90d80070', 'plat_mon_active_count', '平台月活跃用户数', 'text', 'N', 'Y', 'Y', 'Y', '9', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0100', '4028b881499cb17501499ccf90d80070', 'plat_resister_count', '平台注册用户数', 'text', 'N', 'Y', 'Y', 'Y', '8', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0101', '4028b881499cb17501499ccf90d80070', 'busi_attribute', '业务属性', 'combobox', 'N', 'Y', 'Y', 'Y', '7', 'required:true', 'tyzlk.business.ywshx');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0102', '4028b881499cb17501499ccf90d80070', 'customer_type', '客户类型', 'combobox', 'N', 'Y', 'Y', 'Y', '6', 'required:true', 'tyzlk.business.khlx');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0103', '4028b881499cb17501499ccf90d80070', 'product_ids', '产品ID列表', 'text', 'N', 'Y', 'Y', 'Y', '5', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0104', '4028b881499cb17501499ccf90d80070', 'busi_ids', '业务ID列表', 'text', 'N', 'Y', 'Y', 'Y', '4', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0105', '4028b881499cb17501499ccf90d80070', 'busi_importinfo', '业务重要性', 'combobox', 'N', 'Y', 'Y', 'Y', '3', 'required:true', 'tyzlk.business.ywzhyx');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0106', '4028b881499cb17501499ccf90d80070', 'busi_smzq', '业务生命周期', 'combobox', 'N', 'Y', 'Y', 'Y', '2', 'required:true', 'tyzlk.business.ywshmzhq');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a283f8eb0107', '4028b881499cb17501499ccf90d80070', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d4012b', '4028b881499cb17501499ce06932009c', 'busi_version', '业务版本号', 'text', 'N', 'Y', 'Y', 'Y', '9', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d4012c', '4028b881499cb17501499ce06932009c', 'host_busi_id', '主机所属业务模块', 'text', 'N', 'Y', 'Y', 'Y', '8', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d4012d', '4028b881499cb17501499ce06932009c', 'component_isauth', '中间件授权情况', 'combobox', 'N', 'Y', 'Y', 'Y', '7', 'required:true', 'tyzlk.plat.czxtshq');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d4012e', '4028b881499cb17501499ce06932009c', 'component_info', '中间件', 'text', 'N', 'Y', 'Y', 'Y', '6', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d4012f', '4028b881499cb17501499ce06932009c', 'db_auth', '数据库授权情况', 'combobox', 'N', 'Y', 'Y', 'Y', '5', 'required:true', 'tyzlk.plat.czxtshq');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d40130', '4028b881499cb17501499ce06932009c', 'db_version', '数据库版本', 'text', 'N', 'Y', 'Y', 'Y', '4', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d40131', '4028b881499cb17501499ce06932009c', 'operate_isauth', '操作系统授权情况', 'combobox', 'N', 'Y', 'Y', 'Y', '3', 'required:true', 'tyzlk.plat.czxtshq');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d40132', '4028b881499cb17501499ce06932009c', 'operate_system', '操作系统', 'text', 'N', 'Y', 'Y', 'Y', '2', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a21c600149a287f1d40133', '4028b881499cb17501499ce06932009c', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4380002', '4028b881499cb17501499cd38552007e', 'local_port_type', '本端接口类型', 'text', 'N', 'Y', 'Y', 'Y', '8', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4550003', '4028b881499cb17501499cd38552007e', 'remote_plat_port', '对端端口号', 'text', 'N', 'Y', 'Y', 'Y', '7', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4550004', '4028b881499cb17501499cd38552007e', 'local_plat_port', '本端端口号', 'text', 'N', 'Y', 'Y', 'Y', '6', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4560005', '4028b881499cb17501499cd38552007e', 'remote_plat_ip_url', '对端IP或URL', 'text', 'N', 'Y', 'Y', 'Y', '5', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4560006', '4028b881499cb17501499cd38552007e', 'local_plat_ip_url', '本端IP或URL', 'text', 'N', 'Y', 'Y', 'Y', '4', 'required:true', '');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4560007', '4028b881499cb17501499cd38552007e', 'remote_plat_type', '对端接口类型', 'text', 'N', 'Y', 'Y', 'Y', '3', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4560008', '4028b881499cb17501499cd38552007e', 'remote_plat_name', '对端平台名称', 'text', 'N', 'Y', 'Y', 'Y', '2', '', '');
INSERT INTO `online_item` VALUES ('4028b88149a29cbd0149a29dc4570009', '4028b881499cb17501499cd38552007e', 'plat_id', '平台名称', 'combobox', 'Y', 'Y', 'Y', 'Y', '1', 'required:true', 'select id as dic_key,platname as dic_value from tyzlk_plat_info');
INSERT INTO `online_item` VALUES ('5', '2', 'dic_key', '字典KEY', 'text', 'N', 'Y', 'Y', 'Y', '1', 'required:true', '');
INSERT INTO `online_item` VALUES ('6', '2', 'dic_value', '字典值', 'text', 'N', 'Y', 'Y', 'Y', '1', 'required:true', '');

-- ----------------------------
-- Table structure for `syresource`
-- ----------------------------
DROP TABLE IF EXISTS `syresource`;
CREATE TABLE `syresource` (
  `ID` varchar(36) NOT NULL,
  `CREATEDATETIME` datetime default NULL,
  `DESCRIPTION` varchar(200) default NULL,
  `ICONCLS` varchar(100) default NULL,
  `NAME` varchar(100) NOT NULL,
  `SEQ` int(11) default NULL,
  `TARGET` varchar(100) default NULL,
  `UPDATEDATETIME` datetime default NULL,
  `URL` varchar(200) default NULL,
  `SYRESOURCE_ID` varchar(36) default NULL,
  `SYRESOURCETYPE_ID` varchar(36) default NULL,
  PRIMARY KEY  (`ID`),
  KEY `FK_n8kk2inhw4y4gax3nra2etfup` (`SYRESOURCE_ID`),
  KEY `FK_93qfpiiuk3rwb32gc5mcmmlgh` (`SYRESOURCETYPE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of syresource
-- ----------------------------
INSERT INTO `syresource` VALUES ('297e22cc49a1a82d0149a1adc6ef0000', '2014-11-12 09:46:00', '平台建设信息', 'ext-icon-server_add', '平台建设信息', '10', '', '2014-11-12 09:46:00', '/page/basicinfo/platConstructionInfoList.jsp', '4028946a4998025a01499952273a0001', '0');
INSERT INTO `syresource` VALUES ('297e22cc49a342770149a3464ec20000', '2014-11-12 17:12:14', '平台软件升级信息', 'ext-icon-computer_go', '平台软件升级信息', '10', '', '2014-11-12 17:12:14', '/page/basicinfo/platSoftUpdateInfoList.jsp', '4028946a4998025a01499952273a0001', '0');
INSERT INTO `syresource` VALUES ('297e22cc49a6fd960149a6fd96ff0000', '2014-11-12 15:31:07', '添加平台软件升级信息', 'ext-icon-page_white_wrench', '添加平台软件升级信息', '1', '', '2014-11-12 15:31:07', '/platSoftUpdateInfoController.do!save', '297e22cc49a342770149a3464ec20000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a6fd960149a6fd96ff0001', '2014-11-12 15:32:23', '编辑平台软件升级信息', 'ext-icon-page_white_wrench', '编辑平台软件升级信息', '2', '', '2014-11-12 15:32:23', '/platSoftUpdateInfoController.do!update', '297e22cc49a342770149a3464ec20000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a6fd960149a6fd96ff0002', '2014-11-12 15:33:27', '删除平台软件升级信息', 'ext-icon-page_white_wrench', '删除平台软件升级信息', '3', '', '2014-11-12 15:34:44', '/platSoftUpdateInfoController.do!delete', '297e22cc49a342770149a3464ec20000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a6fd960149a6fd96ff0003', '2014-11-12 15:36:02', '查看平台软件升级信息', 'ext-icon-page_white_wrench', '查看平台软件升级信息', '4', '', '2014-11-12 15:47:16', '/platSoftUpdateInfoController.do!view', '297e22cc49a342770149a3464ec20000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a6fd960149a6fd96ff0004', '2014-11-12 15:36:57', '平台软件升级信息列表', 'ext-icon-page_white_wrench', '平台软件升级信息列表', '10', '', '2014-11-12 15:36:57', '/platSoftUpdateInfoController.do!list', '297e22cc49a342770149a3464ec20000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a704950149a70495fe0000', '2014-11-12 15:31:07', '添加平台建设信息', 'ext-icon-page_white_wrench', '添加平台建设信息', '1', '', '2014-11-12 15:31:07', '/platConstructionController.do!save', '297e22cc49a1a82d0149a1adc6ef0000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a704950149a70495fe0001', '2014-11-12 15:32:23', '编辑平台建设信息', 'ext-icon-page_white_wrench', '编辑平台建设信息', '2', '', '2014-11-12 15:32:23', '/platConstructionController.do!update', '297e22cc49a1a82d0149a1adc6ef0000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a704950149a70495fe0002', '2014-11-12 15:33:27', '删除平台建设信息', 'ext-icon-page_white_wrench', '删除平台建设信息', '3', '', '2014-11-12 15:34:44', '/platConstructionController.do!delete', '297e22cc49a1a82d0149a1adc6ef0000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a704950149a70495fe0003', '2014-11-12 15:36:02', '查看平台建设信息', 'ext-icon-page_white_wrench', '查看平台建设信息', '4', '', '2014-11-12 15:47:16', '/platConstructionController.do!view', '297e22cc49a1a82d0149a1adc6ef0000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a704950149a70495fe0004', '2014-11-12 15:36:57', '平台建设信息列表', 'ext-icon-page_white_wrench', '平台建设信息列表', '10', '', '2014-11-12 15:36:57', '/platConstructionController.do!list', '297e22cc49a1a82d0149a1adc6ef0000', '1');
INSERT INTO `syresource` VALUES ('297e22cc49a7dab90149a7de9e250000', '2014-11-13 14:37:04', '单表配置增强JS信息', 'ext-icon-bell_add', '单表配置增强JS信息', '10', '', '2014-11-13 14:37:04', '/system/onlineHeadEnhanceJsList.jsp', 'xtbb', '0');
INSERT INTO `syresource` VALUES ('4028946a497865da0149786a89bd0000', '2014-11-04 09:28:08', '定时任务配置', 'ext-icon-time', '定时任务配置', '6', '', '2014-11-06 13:35:00', '/system/sysJobInterfaceList.jsp', 'xtgl', '0');
INSERT INTO `syresource` VALUES ('4028946a497931a401497936e6fb0000', '2014-11-04 13:11:21', '系统参数', 'ext-icon-server_lightning', '系统参数', '4', '', '2014-11-06 13:36:48', '/onlineTableController.do?goListPage&configId=1', 'xtgl', '0');
INSERT INTO `syresource` VALUES ('4028946a49838bce0149838d86ad0000', '2014-11-06 13:22:10', '数据字典KEY,VALUE', 'ext-icon-page_copy', '字典管理', '5', '', '2014-11-06 13:35:12', '/onlineTableController.do?goListPage&configId=2', 'xtgl', '0');
INSERT INTO `syresource` VALUES ('4028946a498453e901498458fd220000', '2014-11-06 17:04:24', '动态报表配置', 'ext-icon-cog_delete', '动态报表配置', '2', '', '2014-11-10 13:19:46', '/system/onlineCgreportConfigList.jsp', 'xtbb', '0');
INSERT INTO `syresource` VALUES ('4028946a4998025a01499952273a0001', '2014-11-10 18:48:58', '基本信息维护', 'ext-icon-shape_align_right', '基本维护', '1', '', '2014-11-10 18:48:58', '', '', '0');
INSERT INTO `syresource` VALUES ('4028946a4998025a0149995342270002', '2014-11-10 18:50:10', '业务信息维护', 'ext-icon-layout_sidebar', '业务维护', '2', '', '2014-11-10 18:50:10', '', '', '0');
INSERT INTO `syresource` VALUES ('4028946a4998025a01499958058f0003', '2014-11-10 18:55:23', '平台信息管理', 'ext-icon-lightbulb', '平台基本信息', '1', '', '2014-11-13 16:13:46', '/page/basicinfo/platInfoList.jsp', '4028946a4998025a01499952273a0001', '0');
INSERT INTO `syresource` VALUES ('4028946a49a2bdad0149a2e9bbe20000', '2014-11-12 15:31:07', '添加平台信息', 'ext-icon-page_white_wrench', '添加平台信息', '1', '', '2014-11-12 15:31:07', '/tyzlkPlatInfoController.do!save', '4028946a4998025a01499958058f0003', '1');
INSERT INTO `syresource` VALUES ('4028946a49a2bdad0149a2eae4df0001', '2014-11-12 15:32:23', '编辑平台信息', 'ext-icon-page_white_wrench', '编辑平台信息', '2', '', '2014-11-12 15:32:23', '/tyzlkPlatInfoController.do!update', '4028946a4998025a01499958058f0003', '1');
INSERT INTO `syresource` VALUES ('4028946a49a2bdad0149a2ebdeec0002', '2014-11-12 15:33:27', '删除平台信息', 'ext-icon-page_white_wrench', '删除平台信息', '3', '', '2014-11-12 15:34:44', '/tyzlkPlatInfoController.do!delete', '4028946a4998025a01499958058f0003', '1');
INSERT INTO `syresource` VALUES ('4028946a49a2bdad0149a2ee3d8a0003', '2014-11-12 15:36:02', '查看平台信息', 'ext-icon-page_white_wrench', '查看平台信息', '4', '', '2014-11-12 15:47:16', '/tyzlkPlatInfoController.do!view', '4028946a4998025a01499958058f0003', '1');
INSERT INTO `syresource` VALUES ('4028946a49a2bdad0149a2ef12c70004', '2014-11-12 15:36:57', '平台信息列表', 'ext-icon-page_white_wrench', '平台信息列表', '10', '', '2014-11-12 15:36:57', '/tyzlkPlatInfoController.do!list', '4028946a4998025a01499958058f0003', '1');
INSERT INTO `syresource` VALUES ('4028946a49a330910149a33091b10000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cb8824a0019!save', '4028b881499cb07e01499cbb926a0000', '1');
INSERT INTO `syresource` VALUES ('4028946a49a330910149a33091b10001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cb8824a0019!update', '4028b881499cb07e01499cbb926a0000', '1');
INSERT INTO `syresource` VALUES ('4028946a49a330910149a33091b10002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cb8824a0019!delete', '4028b881499cb07e01499cbb926a0000', '1');
INSERT INTO `syresource` VALUES ('4028946a49a330910149a33091b10003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cb8824a0019!view', '4028b881499cb07e01499cbb926a0000', '1');
INSERT INTO `syresource` VALUES ('4028946a49a330910149a33091b10004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cb8824a0019!list', '4028b881499cb07e01499cbb926a0000', '1');
INSERT INTO `syresource` VALUES ('4028b881499898c4014998ce73780001', '2014-11-10 16:25:07', '管理维护信息', 'ext-icon-bullet_wrench', '管理维护', '3', '', '2014-11-10 18:47:44', '', '', '0');
INSERT INTO `syresource` VALUES ('4028b8814998e013014998edf14c0000', '2014-11-10 16:59:31', '维护单位', 'ext-icon-computer_key', '维护单位', '1', '', '2014-11-10 17:05:16', '/onlineTableController.do?goListPage&configId=4028b881499899220149989cd5e50002', '4028b881499898c4014998ce73780001', '0');
INSERT INTO `syresource` VALUES ('4028b8814998e013014998f20cef0001', '2014-11-10 17:04:00', '维护人员信息', 'ext-icon-user_gray', '维护人员信息', '2', '', '2014-11-10 17:04:00', '/onlineTableController.do?goListPage&configId=4028b88149989922014998a98841000d', '4028b881499898c4014998ce73780001', '0');
INSERT INTO `syresource` VALUES ('4028b8814998e013014998f67a2d0002', '2014-11-10 17:08:50', '厂商维护人员信息', 'ext-icon-group_key', '厂商维护人员信息', '3', '', '2014-11-10 17:12:06', '/onlineTableController.do?goListPage&configId=4028b88149989922014998ae4364001c', '4028b881499898c4014998ce73780001', '0');
INSERT INTO `syresource` VALUES ('4028b881499c7d6901499c828d5d0000', '2014-11-11 09:40:41', '平台对外接入管理类系统情况', 'ext-icon-cog', '平台对外接入', '5', '', '2014-11-11 10:11:32', '/onlineTableController.do?goListPage&configId=4028b881499c7fe301499c8101dd0002', '4028b881499898c4014998ce73780001', '0');
INSERT INTO `syresource` VALUES ('4028b881499c7d6901499c9d44ec0001', '2014-11-11 10:09:52', '平台分等级情况', 'ext-icon-cog_edit', '平台分等级情况', '6', '', '2014-11-11 10:11:40', '/onlineTableController.do?goListPage&configId=4028b881499c7fe301499c9234ab0011', '4028b881499898c4014998ce73780001', '0');
INSERT INTO `syresource` VALUES ('4028b881499cb07e01499cbb926a0000', '2014-11-11 10:42:58', '平台硬件信息', 'ext-icon-server', '平台硬件信息', '4', '', '2014-11-11 10:42:58', '/onlineTableController.do?goListPage&configId=4028b881499cb17501499cb8824a0019', '4028946a4998025a01499952273a0001', '0');
INSERT INTO `syresource` VALUES ('4028b881499cb07e01499cbef3d30001', '2014-11-11 10:46:40', '平台软件信息', 'ext-icon-page_save', '平台软件信息', '5', '', '2014-11-11 11:23:39', '/onlineTableController.do?goListPage&configId=4028b881499cb17501499ce06932009c', '4028946a4998025a01499952273a0001', '0');
INSERT INTO `syresource` VALUES ('4028b881499cb07e01499cc6d9bf0003', '2014-11-11 10:55:17', '平台故障信息', 'ext-icon-table_error', '平台故障信息', '6', '', '2014-11-11 10:55:17', '/onlineTableController.do?goListPage&configId=4028b881499cb17501499cc0d02b0039', '4028946a4998025a01499952273a0001', '0');
INSERT INTO `syresource` VALUES ('4028b881499cb07e01499ccafa0c0004', '2014-11-11 10:59:48', '平台安全信息', 'ext-icon-table_delete', '平台安全信息', '7', '', '2014-11-11 10:59:48', '/onlineTableController.do?goListPage&configId=4028b881499cb17501499cc9256f0069', '4028946a4998025a01499952273a0001', '0');
INSERT INTO `syresource` VALUES ('4028b881499cb07e01499cd127c10005', '2014-11-11 11:06:33', '平台业务信息', 'ext-icon-user_gray', '平台业务信息', '1', '', '2014-11-11 11:06:33', '/onlineTableController.do?goListPage&configId=4028b881499cb17501499ccf90d80070', '4028946a4998025a0149995342270002', '0');
INSERT INTO `syresource` VALUES ('4028b881499cb07e01499cd8e8b50006', '2014-11-11 11:15:01', '平台逻辑信息', 'ext-icon-user_go', '平台逻辑信息', '2', '', '2014-11-11 11:15:01', '/onlineTableController.do?goListPage&configId=4028b881499cb17501499cd38552007e', '4028946a4998025a0149995342270002', '0');
INSERT INTO `syresource` VALUES ('4028b88149a46a180149a46a18740000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499899220149989cd5e50002!save', '4028b8814998e013014998edf14c0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a46a180149a46a18740001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499899220149989cd5e50002!update', '4028b8814998e013014998edf14c0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a46a180149a46a18740002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499899220149989cd5e50002!delete', '4028b8814998e013014998edf14c0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a46a180149a46a18740003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499899220149989cd5e50002!view', '4028b8814998e013014998edf14c0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a46a180149a46a18740004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499899220149989cd5e50002!list', '4028b8814998e013014998edf14c0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a48f5e0149a48f5ee60000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b88149989922014998a98841000d!save', '4028b8814998e013014998f20cef0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a48f5e0149a48f5ee60001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b88149989922014998a98841000d!update', '4028b8814998e013014998f20cef0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a48f5e0149a48f5ee60002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b88149989922014998a98841000d!delete', '4028b8814998e013014998f20cef0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a48f5e0149a48f5ee60003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b88149989922014998a98841000d!view', '4028b8814998e013014998f20cef0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a48f5e0149a48f5ee60004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b88149989922014998a98841000d!list', '4028b8814998e013014998f20cef0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a493640149a49364780000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b88149989922014998ae4364001c!save', '4028b8814998e013014998f67a2d0002', '1');
INSERT INTO `syresource` VALUES ('4028b88149a493640149a49364780001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b88149989922014998ae4364001c!update', '4028b8814998e013014998f67a2d0002', '1');
INSERT INTO `syresource` VALUES ('4028b88149a493640149a49364780002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b88149989922014998ae4364001c!delete', '4028b8814998e013014998f67a2d0002', '1');
INSERT INTO `syresource` VALUES ('4028b88149a493640149a49364780003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b88149989922014998ae4364001c!view', '4028b8814998e013014998f67a2d0002', '1');
INSERT INTO `syresource` VALUES ('4028b88149a493640149a49364780004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b88149989922014998ae4364001c!list', '4028b8814998e013014998f67a2d0002', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e5f90149a6e5f9d30000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c8101dd0002!save', '4028b881499c7d6901499c828d5d0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e5f90149a6e5f9d30001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c8101dd0002!update', '4028b881499c7d6901499c828d5d0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e5f90149a6e5f9d30002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c8101dd0002!delete', '4028b881499c7d6901499c828d5d0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e5f90149a6e5f9d30003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c8101dd0002!view', '4028b881499c7d6901499c828d5d0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e5f90149a6e5f9d30004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c8101dd0002!list', '4028b881499c7d6901499c828d5d0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e7cf0149a6e7cf3b0000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c9234ab0011!save', '4028b881499c7d6901499c9d44ec0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e7cf0149a6e7cf3b0001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c9234ab0011!update', '4028b881499c7d6901499c9d44ec0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e7cf0149a6e7cf3b0002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c9234ab0011!delete', '4028b881499c7d6901499c9d44ec0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e7cf0149a6e7cf3b0003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c9234ab0011!view', '4028b881499c7d6901499c9d44ec0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e7cf0149a6e7cf3b0004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499c7fe301499c9234ab0011!list', '4028b881499c7d6901499c9d44ec0001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e9730149a6e973820000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ce06932009c!save', '4028b881499cb07e01499cbef3d30001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e9730149a6e973820001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ce06932009c!update', '4028b881499cb07e01499cbef3d30001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e9730149a6e973820002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ce06932009c!delete', '4028b881499cb07e01499cbef3d30001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e9730149a6e973820003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ce06932009c!view', '4028b881499cb07e01499cbef3d30001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6e9730149a6e973820004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ce06932009c!list', '4028b881499cb07e01499cbef3d30001', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6eb8b0149a6eb8bc90000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc0d02b0039!save', '4028b881499cb07e01499cc6d9bf0003', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6eb8b0149a6eb8bc90001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc0d02b0039!update', '4028b881499cb07e01499cc6d9bf0003', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6eb8b0149a6eb8bc90002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc0d02b0039!delete', '4028b881499cb07e01499cc6d9bf0003', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6eb8b0149a6eb8bc90003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc0d02b0039!view', '4028b881499cb07e01499cc6d9bf0003', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6eb8b0149a6eb8bc90004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc0d02b0039!list', '4028b881499cb07e01499cc6d9bf0003', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ecc70149a6ecc7300000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc9256f0069!save', '4028b881499cb07e01499ccafa0c0004', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ecc70149a6ecc7300001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc9256f0069!update', '4028b881499cb07e01499ccafa0c0004', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ecc70149a6ecc7300002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc9256f0069!delete', '4028b881499cb07e01499ccafa0c0004', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ecc70149a6ecc7300003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc9256f0069!view', '4028b881499cb07e01499ccafa0c0004', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ecc70149a6ecc7300004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cc9256f0069!list', '4028b881499cb07e01499ccafa0c0004', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ee0a0149a6ee0a500000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ccf90d80070!save', '4028b881499cb07e01499cd127c10005', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ee0a0149a6ee0a500001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ccf90d80070!update', '4028b881499cb07e01499cd127c10005', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ee0a0149a6ee0a500002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ccf90d80070!delete', '4028b881499cb07e01499cd127c10005', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ee0a0149a6ee0a500003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ccf90d80070!view', '4028b881499cb07e01499cd127c10005', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ee0a0149a6ee0a500004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499cb17501499ccf90d80070!list', '4028b881499cb07e01499cd127c10005', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ef220149a6ef22ba0000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cd38552007e!save', '4028b881499cb07e01499cd8e8b50006', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ef220149a6ef22ba0001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cd38552007e!update', '4028b881499cb07e01499cd8e8b50006', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ef220149a6ef22ba0002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cd38552007e!delete', '4028b881499cb07e01499cd8e8b50006', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ef220149a6ef22ba0003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cd38552007e!view', '4028b881499cb07e01499cd8e8b50006', '1');
INSERT INTO `syresource` VALUES ('4028b88149a6ef220149a6ef22ba0004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/4028b881499cb17501499cd38552007e!list', '4028b881499cb07e01499cd8e8b50006', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0aa90149ac0aa94c0000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/1!save', '4028946a497931a401497936e6fb0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0aa90149ac0aa94c0001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/1!update', '4028946a497931a401497936e6fb0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0aa90149ac0aa94c0002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/1!delete', '4028946a497931a401497936e6fb0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0aa90149ac0aa94c0003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/1!view', '4028946a497931a401497936e6fb0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0aa90149ac0aa94c0004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/1!list', '4028946a497931a401497936e6fb0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0e8f0149ac0e8f2e0000', '2014-11-12 15:36:57', '添加', 'ext-icon-page_white_wrench', '添加', '1', '', '2014-11-12 15:36:57', '/2!save', '4028946a49838bce0149838d86ad0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0e8f0149ac0e8f2e0001', '2014-11-12 15:36:57', '修改', 'ext-icon-page_white_wrench', '修改', '2', '', '2014-11-12 15:36:57', '/2!update', '4028946a49838bce0149838d86ad0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0e8f0149ac0e8f2e0002', '2014-11-12 15:36:57', '删除', 'ext-icon-page_white_wrench', '删除', '3', '', '2014-11-12 15:36:57', '/2!delete', '4028946a49838bce0149838d86ad0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0e8f0149ac0e8f2e0003', '2014-11-12 15:36:57', '查看', 'ext-icon-page_white_wrench', '查看', '4', '', '2014-11-12 15:36:57', '/2!view', '4028946a49838bce0149838d86ad0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149ac0e8f0149ac0e8f2e0004', '2014-11-12 15:36:57', '列表', 'ext-icon-page_white_wrench', '列表', '5', '', '2014-11-12 15:36:57', '/2!list', '4028946a49838bce0149838d86ad0000', '1');
INSERT INTO `syresource` VALUES ('4028b88149bcedf50149bcf582af0000', '2014-11-17 16:54:06', '数据源表的增删改查', 'ext-icon-database', '数据源管理', '7', '', '2014-11-17 18:50:41', '/system/sysDataSourceList.jsp', 'xtgl', '0');
INSERT INTO `syresource` VALUES ('4028c99d49a74f960149a759829b0000', '2014-11-13 12:11:41', '厂商维保情况', 'ext-icon-group_edit', '厂商维保情况', '10', '', '2014-11-13 12:11:41', '/page/basicinfo/manuInfoList.jsp', '4028b881499898c4014998ce73780001', '0');
INSERT INTO `syresource` VALUES ('53b07fd5-27a7-406f-9807-7d12a04628a7', '2014-11-03 17:09:42', '激活用户', 'ext-icon-bullet_wrench', '激活用户', '99', '', '2014-11-03 17:11:40', '/base/syuser!active', 'yhgl', '1');
INSERT INTO `syresource` VALUES ('6da250a1-a222-45ad-a4b9-98e6d8a8190b', '2014-11-03 17:21:17', '角色列表', 'ext-icon-bullet_wrench', '角色列表', '6', '', '2014-11-03 17:40:10', '/base/syrole!list', 'jsgl', '1');
INSERT INTO `syresource` VALUES ('9dee9af6-6a4f-492b-8ac1-cd029f4002ca', '2014-11-03 17:15:45', '禁用用户', 'ext-icon-bullet_wrench', '禁用用户', '100', '', '2014-11-03 17:16:02', '/base/syuser!forbidden', 'yhgl', '1');
INSERT INTO `syresource` VALUES ('acc2ed1c-46d8-4059-9978-b841afc279b3', '2014-11-03 17:20:40', '资源列表', 'ext-icon-bullet_wrench', '资源列表', '100', '', '2014-11-03 17:20:40', '/base/syresource!list', 'zygl', '1');
INSERT INTO `syresource` VALUES ('f9929bcc-21bc-4b1d-a602-db6cc82df4d6', '2014-11-03 17:22:43', '用户列表', 'ext-icon-bullet_wrench', '用户列表', '100', '', '2014-11-03 17:22:43', '/base/syuser!list', 'yhgl', '1');
INSERT INTO `syresource` VALUES ('jsbj', '2014-10-16 15:21:51', '编辑角色', 'ext-icon-bullet_wrench', '编辑角色', '2', '', '2014-10-16 15:21:51', '/base/syrole!update', 'jsgl', '1');
INSERT INTO `syresource` VALUES ('jsgl', '2014-10-16 15:21:51', '管理系统中用户的角色', 'ext-icon-tux', '角色管理', '2', '', '2014-11-01 22:59:35', '/system/syRoleList.jsp', 'xtgl', '0');
INSERT INTO `syresource` VALUES ('jssc', '2014-10-16 15:21:51', '删除角色', 'ext-icon-bullet_wrench', '删除角色', '3', '', '2014-10-16 15:21:51', '/base/syrole!delete', 'jsgl', '1');
INSERT INTO `syresource` VALUES ('jssq', '2014-10-16 15:21:51', '角色授权', 'ext-icon-bullet_wrench', '角色授权', '5', '', '2014-10-16 15:21:51', '/base/syrole!grant', 'jsgl', '1');
INSERT INTO `syresource` VALUES ('jstj', '2014-10-16 15:21:51', '添加角色', 'ext-icon-bullet_wrench', '添加角色', '1', '', '2014-10-16 15:21:51', '/base/syrole!save', 'jsgl', '1');
INSERT INTO `syresource` VALUES ('userRoleChart', '2014-10-16 15:21:52', '单表配置', 'ext-icon-chart_pie', '单表配置', '1', '', '2014-11-06 13:36:13', '/system/onlineTableConfigList.jsp', 'xtbb', '0');
INSERT INTO `syresource` VALUES ('xtbb', '2014-10-16 15:21:52', '在线开发', 'ext-icon-chart_curve', 'Online开发', '30', '', '2014-11-10 18:47:33', '', '', '0');
INSERT INTO `syresource` VALUES ('xtgl', '2014-10-16 15:21:51', '管理系统的资源、角色、机构、用户等信息', 'ext-icon-application_view_tile', '系统管理', '0', '', '2014-10-16 15:21:51', '', '', '0');
INSERT INTO `syresource` VALUES ('yhbj', '2014-10-16 15:21:52', '编辑用户', 'ext-icon-bullet_wrench', '编辑用户', '2', '', '2014-10-16 15:21:52', '/base/syuser!update', 'yhgl', '1');
INSERT INTO `syresource` VALUES ('yhgl', '2014-10-16 15:21:52', '管理系统中用户的用户', 'ext-icon-user_suit', '用户管理', '3', '', '2014-11-06 13:34:42', '/system/syUserList.jsp', 'xtgl', '0');
INSERT INTO `syresource` VALUES ('yhsc', '2014-10-16 15:21:52', '删除用户', 'ext-icon-bullet_wrench', '删除用户', '3', '', '2014-10-16 15:21:52', '/base/syuser!delete', 'yhgl', '1');
INSERT INTO `syresource` VALUES ('yhtj', '2014-10-16 15:21:52', '添加用户', 'ext-icon-bullet_wrench', '添加用户', '1', '', '2014-10-16 15:21:52', '/base/syuser!save', 'yhgl', '1');
INSERT INTO `syresource` VALUES ('zybj', '2014-10-16 15:21:51', '编辑资源', 'ext-icon-bullet_wrench', '编辑资源', '2', '', '2014-10-16 15:21:51', '/base/syresource!update', 'zygl', '1');
INSERT INTO `syresource` VALUES ('zygl', '2014-10-16 15:21:51', '管理系统的资源', 'ext-icon-newspaper_link', '资源管理', '1', '', '2014-11-06 13:24:26', '/system/syResourceList.jsp', 'xtgl', '0');
INSERT INTO `syresource` VALUES ('zysc', '2014-10-16 15:21:51', '删除资源', 'ext-icon-bullet_wrench', '删除资源', '3', '', '2014-10-16 15:21:51', '/base/syresource!delete', 'zygl', '1');
INSERT INTO `syresource` VALUES ('zytj', '2014-10-16 15:21:51', '添加资源', 'ext-icon-bullet_wrench', '添加资源', '1', '', '2014-10-16 15:21:51', '/base/syresource!save', 'zygl', '1');

-- ----------------------------
-- Table structure for `syrole`
-- ----------------------------
DROP TABLE IF EXISTS `syrole`;
CREATE TABLE `syrole` (
  `ID` varchar(36) NOT NULL,
  `CREATEDATETIME` datetime default NULL,
  `DESCRIPTION` varchar(200) default NULL,
  `ICONCLS` varchar(100) default NULL,
  `NAME` varchar(100) NOT NULL,
  `SEQ` int(11) default NULL,
  `UPDATEDATETIME` datetime default NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of syrole
-- ----------------------------
INSERT INTO `syrole` VALUES ('0', '2014-10-16 15:21:52', '拥有系统所有权限', null, '超级管理员', '1', '2014-11-03 17:53:34');
INSERT INTO `syrole` VALUES ('1', '2014-10-16 15:21:52', '只有部分权限', null, '普通用户', '2', '2014-11-02 19:12:21');

-- ----------------------------
-- Table structure for `syrole_syresource`
-- ----------------------------
DROP TABLE IF EXISTS `syrole_syresource`;
CREATE TABLE `syrole_syresource` (
  `SYROLE_ID` varchar(36) NOT NULL,
  `SYRESOURCE_ID` varchar(36) NOT NULL,
  PRIMARY KEY  (`SYRESOURCE_ID`,`SYROLE_ID`),
  KEY `FK_kkrartsovl2frhfvriqdi7jwl` (`SYRESOURCE_ID`),
  KEY `FK_r139h669pg4ts6mbvn3ip5472` (`SYROLE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of syrole_syresource
-- ----------------------------
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a1a82d0149a1adc6ef0000');
INSERT INTO `syrole_syresource` VALUES ('1', '297e22cc49a1a82d0149a1adc6ef0000');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a342770149a3464ec20000');
INSERT INTO `syrole_syresource` VALUES ('1', '297e22cc49a342770149a3464ec20000');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a6fd960149a6fd96ff0000');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a6fd960149a6fd96ff0001');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a6fd960149a6fd96ff0002');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a6fd960149a6fd96ff0003');
INSERT INTO `syrole_syresource` VALUES ('1', '297e22cc49a6fd960149a6fd96ff0003');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a6fd960149a6fd96ff0004');
INSERT INTO `syrole_syresource` VALUES ('1', '297e22cc49a6fd960149a6fd96ff0004');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a704950149a70495fe0000');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a704950149a70495fe0001');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a704950149a70495fe0002');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a704950149a70495fe0003');
INSERT INTO `syrole_syresource` VALUES ('1', '297e22cc49a704950149a70495fe0003');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a704950149a70495fe0004');
INSERT INTO `syrole_syresource` VALUES ('1', '297e22cc49a704950149a70495fe0004');
INSERT INTO `syrole_syresource` VALUES ('0', '297e22cc49a7dab90149a7de9e250000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a497865da0149786a89bd0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a497931a401497936e6fb0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49838bce0149838d86ad0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a498453e901498458fd220000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a4998025a01499952273a0001');
INSERT INTO `syrole_syresource` VALUES ('1', '4028946a4998025a01499952273a0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a4998025a0149995342270002');
INSERT INTO `syrole_syresource` VALUES ('1', '4028946a4998025a0149995342270002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a4998025a01499958058f0003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028946a4998025a01499958058f0003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a2bdad0149a2e9bbe20000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a2bdad0149a2eae4df0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a2bdad0149a2ebdeec0002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a2bdad0149a2ee3d8a0003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028946a49a2bdad0149a2ee3d8a0003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a2bdad0149a2ef12c70004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028946a49a2bdad0149a2ef12c70004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a330910149a33091b10000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a330910149a33091b10001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a330910149a33091b10002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a330910149a33091b10003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028946a49a330910149a33091b10003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028946a49a330910149a33091b10004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028946a49a330910149a33091b10004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499898c4014998ce73780001');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499898c4014998ce73780001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b8814998e013014998edf14c0000');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b8814998e013014998edf14c0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b8814998e013014998f20cef0001');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b8814998e013014998f20cef0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b8814998e013014998f67a2d0002');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b8814998e013014998f67a2d0002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499c7d6901499c828d5d0000');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499c7d6901499c828d5d0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499c7d6901499c9d44ec0001');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499c7d6901499c9d44ec0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499cb07e01499cbb926a0000');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499cb07e01499cbb926a0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499cb07e01499cbef3d30001');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499cb07e01499cbef3d30001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499cb07e01499cc6d9bf0003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499cb07e01499cc6d9bf0003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499cb07e01499ccafa0c0004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499cb07e01499ccafa0c0004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499cb07e01499cd127c10005');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499cb07e01499cd127c10005');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b881499cb07e01499cd8e8b50006');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b881499cb07e01499cd8e8b50006');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a46a180149a46a18740000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a46a180149a46a18740001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a46a180149a46a18740002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a46a180149a46a18740003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a46a180149a46a18740003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a46a180149a46a18740004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a46a180149a46a18740004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a48f5e0149a48f5ee60000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a48f5e0149a48f5ee60001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a48f5e0149a48f5ee60002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a48f5e0149a48f5ee60003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a48f5e0149a48f5ee60003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a48f5e0149a48f5ee60004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a48f5e0149a48f5ee60004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a493640149a49364780000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a493640149a49364780001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a493640149a49364780002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a493640149a49364780003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a493640149a49364780003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a493640149a49364780004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a493640149a49364780004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e5f90149a6e5f9d30000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e5f90149a6e5f9d30001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e5f90149a6e5f9d30002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e5f90149a6e5f9d30003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e5f90149a6e5f9d30003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e5f90149a6e5f9d30004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e5f90149a6e5f9d30004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e7cf0149a6e7cf3b0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e7cf0149a6e7cf3b0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e7cf0149a6e7cf3b0002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e7cf0149a6e7cf3b0003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e7cf0149a6e7cf3b0003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e7cf0149a6e7cf3b0004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e7cf0149a6e7cf3b0004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e9730149a6e973820000');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e9730149a6e973820000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e9730149a6e973820001');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e9730149a6e973820001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e9730149a6e973820002');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e9730149a6e973820002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e9730149a6e973820003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e9730149a6e973820003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6e9730149a6e973820004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6e9730149a6e973820004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6eb8b0149a6eb8bc90000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6eb8b0149a6eb8bc90001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6eb8b0149a6eb8bc90002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6eb8b0149a6eb8bc90003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6eb8b0149a6eb8bc90003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6eb8b0149a6eb8bc90004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6eb8b0149a6eb8bc90004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ecc70149a6ecc7300000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ecc70149a6ecc7300001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ecc70149a6ecc7300002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ecc70149a6ecc7300003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6ecc70149a6ecc7300003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ecc70149a6ecc7300004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6ecc70149a6ecc7300004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ee0a0149a6ee0a500000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ee0a0149a6ee0a500001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ee0a0149a6ee0a500002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ee0a0149a6ee0a500003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6ee0a0149a6ee0a500003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ee0a0149a6ee0a500004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6ee0a0149a6ee0a500004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ef220149a6ef22ba0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ef220149a6ef22ba0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ef220149a6ef22ba0002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ef220149a6ef22ba0003');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6ef220149a6ef22ba0003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149a6ef220149a6ef22ba0004');
INSERT INTO `syrole_syresource` VALUES ('1', '4028b88149a6ef220149a6ef22ba0004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0aa90149ac0aa94c0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0aa90149ac0aa94c0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0aa90149ac0aa94c0002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0aa90149ac0aa94c0003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0aa90149ac0aa94c0004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0e8f0149ac0e8f2e0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0e8f0149ac0e8f2e0001');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0e8f0149ac0e8f2e0002');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0e8f0149ac0e8f2e0003');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149ac0e8f0149ac0e8f2e0004');
INSERT INTO `syrole_syresource` VALUES ('0', '4028b88149bcedf50149bcf582af0000');
INSERT INTO `syrole_syresource` VALUES ('0', '4028c99d49a74f960149a759829b0000');
INSERT INTO `syrole_syresource` VALUES ('0', '53b07fd5-27a7-406f-9807-7d12a04628a7');
INSERT INTO `syrole_syresource` VALUES ('0', '6da250a1-a222-45ad-a4b9-98e6d8a8190b');
INSERT INTO `syrole_syresource` VALUES ('0', '9dee9af6-6a4f-492b-8ac1-cd029f4002ca');
INSERT INTO `syrole_syresource` VALUES ('0', 'acc2ed1c-46d8-4059-9978-b841afc279b3');
INSERT INTO `syrole_syresource` VALUES ('0', 'f9929bcc-21bc-4b1d-a602-db6cc82df4d6');
INSERT INTO `syrole_syresource` VALUES ('0', 'jsbj');
INSERT INTO `syrole_syresource` VALUES ('0', 'jsgl');
INSERT INTO `syrole_syresource` VALUES ('0', 'jssc');
INSERT INTO `syrole_syresource` VALUES ('0', 'jssq');
INSERT INTO `syrole_syresource` VALUES ('0', 'jstj');
INSERT INTO `syrole_syresource` VALUES ('0', 'userRoleChart');
INSERT INTO `syrole_syresource` VALUES ('0', 'xtbb');
INSERT INTO `syrole_syresource` VALUES ('0', 'xtgl');
INSERT INTO `syrole_syresource` VALUES ('0', 'yhbj');
INSERT INTO `syrole_syresource` VALUES ('5', 'yhbj');
INSERT INTO `syrole_syresource` VALUES ('0', 'yhgl');
INSERT INTO `syrole_syresource` VALUES ('5', 'yhgl');
INSERT INTO `syrole_syresource` VALUES ('0', 'yhsc');
INSERT INTO `syrole_syresource` VALUES ('5', 'yhsc');
INSERT INTO `syrole_syresource` VALUES ('0', 'yhtj');
INSERT INTO `syrole_syresource` VALUES ('5', 'yhtj');
INSERT INTO `syrole_syresource` VALUES ('0', 'zybj');
INSERT INTO `syrole_syresource` VALUES ('0', 'zygl');
INSERT INTO `syrole_syresource` VALUES ('0', 'zysc');
INSERT INTO `syrole_syresource` VALUES ('0', 'zytj');

-- ----------------------------
-- Table structure for `syslogs`
-- ----------------------------
DROP TABLE IF EXISTS `syslogs`;
CREATE TABLE `syslogs` (
  `id` varchar(36) NOT NULL,
  `logname` varchar(20) default NULL COMMENT '操作名称,login,logout,opera\0\0\0\0',
  `loguser` varchar(30) default NULL COMMENT '操作对象\0\0R\0',
  `logterminal` varchar(20) default NULL COMMENT '操作终端,ip,OR HOSTname\0\0\0\0',
  `logresult` varchar(20) default NULL COMMENT '操作结果,success,fail\0\0\0\0',
  `logcontent` varchar(200) default NULL COMMENT '操作内容\0\0R\0',
  `logtime` varchar(60) default NULL COMMENT '操作时间\0\0R\0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统操作日志';

-- ----------------------------
-- Records of syslogs
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_config_para`
-- ----------------------------
DROP TABLE IF EXISTS `sys_config_para`;
CREATE TABLE `sys_config_para` (
  `id` varchar(36) NOT NULL,
  `para_name` varchar(200) NOT NULL default ' ' COMMENT '参数名称',
  `para_value` varchar(200) NOT NULL COMMENT '参数值',
  `para_desc` varchar(200) default ' ' COMMENT '参数解析',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统配置参数,每一个应用系统可能都不一样';

-- ----------------------------
-- Records of sys_config_para
-- ----------------------------
INSERT INTO `sys_config_para` VALUES ('1', 'sendi_system_title', '统一资料库', '系统标题');
INSERT INTO `sys_config_para` VALUES ('2', 'sendi_system_socketport', '9911', '客户端与服务器端socket通信端口');
INSERT INTO `sys_config_para` VALUES ('3', 'sendi_system_overviewname', 'overview', '总览名称');
INSERT INTO `sys_config_para` VALUES ('4', 'sendi_system_overviewurl', '/page/overview/portal.jsp', '总览路径');
INSERT INTO `sys_config_para` VALUES ('5', 'sendi_system_isusesocket', 'yes', '服务器端socket服务开关');
INSERT INTO `sys_config_para` VALUES ('6', 'sendi_system_conectlost_notice_module', 'overview', 'socket中断事件通知模块ID');
INSERT INTO `sys_config_para` VALUES ('7', 'sendi_system_scheduler_host', '192.168.56.1', '定时任务执行机器地址');
INSERT INTO `sys_config_para` VALUES ('8', 'sendi_system-test', 'testevacuation', '测试参数');

-- ----------------------------
-- Table structure for `sys_datasource`
-- ----------------------------
DROP TABLE IF EXISTS `sys_datasource`;
CREATE TABLE `sys_datasource` (
  `id` varchar(36) NOT NULL default '',
  `ds_key` varchar(50) default NULL COMMENT 'KEY值',
  `ds_name` varchar(50) default NULL COMMENT '数据源名称',
  `driverClassName` varchar(50) default NULL COMMENT '驱动类',
  `url` varchar(200) default NULL COMMENT 'URL',
  `username` varchar(50) default NULL COMMENT '账号',
  `password` varchar(50) default NULL COMMENT '密码',
  `validationQuery` varchar(50) default NULL COMMENT '连接测试语句',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_datasource
-- ----------------------------
INSERT INTO `sys_datasource` VALUES ('a', 'test', '测试', 'com.mysql.jdbc.Driver', 'jdbc:mysql://127.0.0.1:3306/test?useUnicode=true&characterEncoding=UTF-8', 'root', '1234', 'select 1');

-- ----------------------------
-- Table structure for `sys_job_interface`
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_interface`;
CREATE TABLE `sys_job_interface` (
  `id` varchar(36) NOT NULL,
  `interfaceid` varchar(100) NOT NULL,
  `description` varchar(200) NOT NULL,
  `interfacecalss` varchar(200) NOT NULL COMMENT '接口功能类，该类必须实现接口org.quartz.Job 中的方法execute\0ketI 中的方法\0\0过于频繁时\0',
  `jobtype` varchar(20) default 's' COMMENT '任务类型，简单任务为s,复杂任务为c,复杂任务采用CronExpression\0 t.event_manipulati\0',
  `cronexpression` varchar(20) default NULL,
  `jobstart_time` varchar(20) default NULL COMMENT 'yyyyMMDDHHmmss',
  `job_repeatInterval` int(11) default NULL,
  `job_repeatcount` int(11) default NULL,
  `isactive` varchar(20) default 'on' COMMENT '任务是否开启,on,off\0ace_\0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sys_job_interface
-- ----------------------------
INSERT INTO `sys_job_interface` VALUES ('2', 'TestQuartzJob', 'TestQuartzJob', 'com.sendi.system.quaztz.TestQuartzJob', 'c', '0/5  * * * * ?', '', null, null, 'off');

-- ----------------------------
-- Table structure for `sys_proload_conf`
-- ----------------------------
DROP TABLE IF EXISTS `sys_proload_conf`;
CREATE TABLE `sys_proload_conf` (
  `id` varchar(36) NOT NULL,
  `interfaceid` varchar(200) NOT NULL COMMENT '接口id',
  `description` varchar(200) default ' ' COMMENT '功能描述',
  `interfacecalss` varchar(200) NOT NULL COMMENT '接口类\0e\0',
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='系统全局预加载配置';

-- ----------------------------
-- Records of sys_proload_conf
-- ----------------------------
INSERT INTO `sys_proload_conf` VALUES ('1', 'sysJobInterface', '定时任务启动类', 'com.sendi.system.quaztz.CronTriggerRunner');

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `id` varchar(36) NOT NULL,
  `userId` varchar(20) NOT NULL,
  `userName` varchar(20) default NULL,
  `password` varchar(100) NOT NULL,
  `usertype` varchar(20) default NULL,
  `pwdvalicity` int(11) default NULL COMMENT '瀵嗙爜鏈夋晥鏈燂紝鍗曚綅鏄ぉ\0r f\0e\0d\0d',
  `createdate` varchar(20) default NULL COMMENT '鍒涘缓鏃ユ湡,鏃舵湡鏍煎紡涓簓yyy-MM-dd HH:mm\0use\0\0\0\0\0',
  `pwddate` varchar(20) default NULL COMMENT '瀵嗙爜淇敼鏃ユ湡锛岄娆″垱寤哄垯涓哄垱寤虹殑鏃ユ湡锛屽綋鍒版湡鍚庯紝杩涜淇敼鏃讹紝鍒欓渶瑕佸啀璁板綍淇敼鐨勬棩鏈焅0\0''\0\n\0j\0c\0_\0a\0l\0=\0u\0e\0''\0\n\0u\0e\0''\0\n\0=\0u\0e\0\0',
  `istip` varchar(20) default 'on' COMMENT '鏄惁鎻愮ず瀵嗙爜杩囨湡锛宱n,off\0??\0\0\0\0',
  `isactive` varchar(20) default 'on',
  `maxlogincount` int(11) default '10' COMMENT '鏈€澶у厑璁哥櫥褰曟鏁癨0InnerMe',
  `is_share` varchar(10) default 'n',
  `max_connect` int(11) default '0',
  `ip` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 DELAY_KEY_WRITE=1;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('4028b88149713a950149713cc2260000', 'user', 'user', '1', '1', '99999', '2014-11-03 00:00', '2014-11-03 00:00', 'on', 'on', '100000', 'y', null, '');
INSERT INTO `sys_user` VALUES ('4028b88149713a950149713d15c60001', 'user2', 'user2', '1', '1', '999', '2014-11-03 00:01', '2014-11-03 00:01', 'on', 'on', null, 'y', null, '');
INSERT INTO `sys_user` VALUES ('9', 'admin', '管理员', '1', '1', '999999999', '2013-04-01 15:03', '2013-04-14 10:51', 'off', 'on', '1000000000', 'y', '100', '');

-- ----------------------------
-- Table structure for `syuser_syrole`
-- ----------------------------
DROP TABLE IF EXISTS `syuser_syrole`;
CREATE TABLE `syuser_syrole` (
  `SYUSER_ID` varchar(36) NOT NULL,
  `SYROLE_ID` varchar(36) NOT NULL,
  PRIMARY KEY  (`SYROLE_ID`,`SYUSER_ID`),
  KEY `FK_j7iwtgslc2esrjx0ptieleoko` (`SYROLE_ID`),
  KEY `FK_1pi4p5h4y5ghbs5f4gdlgn620` (`SYUSER_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of syuser_syrole
-- ----------------------------
INSERT INTO `syuser_syrole` VALUES ('9', '0');
INSERT INTO `syuser_syrole` VALUES ('4028b88149713a950149713cc2260000', '1');
INSERT INTO `syuser_syrole` VALUES ('4028b88149713a950149713d15c60001', '1');
