-- 商品信息表sql
CREATE TABLE item_info(
	'id' int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
	'code' varchar(255) DEFAULT NULL COMMENT '商品编码',
	'name' varchar(255) DEFAULT NULL COMMENT '商品名称',
	'price' DECIMAL(15,2) DEFAULT NULL COMMENT '销售价',
	'is_active' int(11) DEFAULT '1' COMMENT '是否有效（1=是；0=否）',
	'create_time' datetime DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
	'update_time' TIMESTAMP NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP DEFAULT NULL COMMENT '更新时间',
	PRIMARY KEY ('id'),
	UNIQUE KEY 'idx_code' ('code') USING BTREE COMMIT '商品编码唯一'
) COMMENT = '商品信息表';