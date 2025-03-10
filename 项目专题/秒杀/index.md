# 秒杀系统

[TOC]

## 目标

1. 分布式会话
   1. 用户登录
   2. 共享Session
2. 功能开发
   1. 商品列表
   2. 商品详情
   3. 秒杀
   4. 订单信息
3. 系统压测
   1. JMater
   2. 自定义变量
   3. 正式压测
4. 安全优化
   1. 隐藏秒杀地址
   2. 验证码
   3. 接口限流
5. 服务优化
   1. RabbitMQ消息队列
   2. 接口优化
   3. 分布式锁
6. 页面优化
   1. 缓存
   2. 静态化分离

## 秒杀系统设计

秒杀系统的整体架构可以概括为"稳"、"准"、"快"

1. 稳：整个系统满足高可用，保证秒杀系统的顺利完成

2. 准：保证数据的一致性、秒杀商品数量正确
3. 快：系统性能足够高、不光是服务端要做极致的性能优化、确整个请求链路上都要做协同的优化

技术角度上，“稳、准、快”对应了我们架构上的高可用、一致性和该性能的要求：

1. 高可用：现实中总难免出现一些我们考虑不到的情况，所以要保证系统的高可用和正确性，我们还要设计-个 PlanB 来兜底，以便在最坏情况发生时仍然能够从容应对。
2. 一致性：秒杀中商品减库存的实现方式同样关键。可想而知，有限数量的商品在同一时刻被很多倍的请求同时来减库存，减库存又分为“拍下减库存”“付款减库存”以及预扣等几种，在大并发更新的过程中都要保证数据的准确性，其难度可想而知
3. 高性能：秒杀涉及大量的并发读和并发写，因此支持高并发访问这点非常关键。对应的方案比如动静分离方案、热点的发现与隔离、请求的削峰与分层过滤、服务端的极致优化



## 秒杀方案

### 环境搭建

​	

### 分布式Session

​	

### 秒杀功能



### 压力测试



### 页面优化



### 服务优化



## 接口安全

