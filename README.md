# 企业 IT 服务台智能工单分派

当前仓库已经搭好一套可扩展的项目骨架，重点是模块边界、目录结构和本地联调基础设施，具体业务功能留空，方便后续按你的节奏实现。

## 当前结构

```text
backend/
  pom.xml
  ticket-app/
  common-infra/
  identity-core/
  ticket-core/
  approval-core/
  service-desk-core/
  knowledge-core/
  search-core/
  rule-engine/
  message-center/
  cache-center/
  admin-report/
frontend/
  package.json
  src/
deploy/
  docker/
```

## 后端骨架

- `ticket-app`: Spring Boot 启动入口
- `common-infra`: 公共基础能力
- `identity-core`: 用户、部门、系统、权限项
- `ticket-core`: 工单主领域
- `approval-core`: 审批流
- `service-desk-core`: 服务台作业流
- `knowledge-core`: 知识库
- `search-core`: 搜索
- `rule-engine`: 规则与策略
- `message-center`: 异步消息
- `cache-center`: 缓存
- `admin-report`: 管理与报表

## 前端骨架

- `portal`: 员工门户
- `approval`: 审批中心
- `service-desk`: 服务台作业台
- `admin`: 管理后台

## 本地环境

`deploy/docker/docker-compose.yml` 里已经预留：

- MySQL
- MongoDB
- Redis
- RabbitMQ
- Elasticsearch

## 已知环境说明

- Maven 当前运行时是 JDK 17，而后端父 `pom` 按 Java 21 预留
- Docker Compose 配置可解析，但当前机器上的 Docker daemon 需要先可用
- 目前重点是框架骨架，不包含具体业务接口和页面逻辑
