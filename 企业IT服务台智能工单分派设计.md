# 企业 IT 服务台智能工单分派设计

## 1. 背景与目标

本项目定位为接近真实企业可落地的 IT 服务台系统，第一阶段聚焦账号与权限类工单，覆盖员工自助提单、分级审批、服务台处理、员工确认、知识复用、SLA 管控与增强审计。

目标不是做一个演示型 CRUD 系统，而是做一套具备以下特征的企业内网应用：

- 能承载真实的账号与权限申请流程
- 能适配企业组织关系与审批链
- 能满足服务台运营与配置管理双侧诉求
- 能沉淀知识并减少重复工单
- 能在后续扩展到 AD、企业通讯录和更多工单场景

## 2. 范围定义

### 2.1 第一阶段纳入范围

- 场景限定为企业 IT 服务台
- 工单类型限定为账号与权限类申请
- 提单入口限定为 Web 门户
- 申请对象限定为员工为自己申请
- 审批模式为多级审批
- 审批依据为系统敏感级别与权限类型共同决定
- 所有工单统一进入服务台队列
- 普通工单允许抢单，高敏工单要求组长分派
- 处理完成后由员工确认，再正式关闭
- 知识库在提单前执行强引导自助
- 审计级别为增强审计
- 用户组织数据先在系统内维护，同时预留对接企业目录的扩展能力
- 管理端同时覆盖配置后台与服务台作业台

### 2.2 第一阶段暂不纳入范围

- 为他人代提申请
- 邮件、企业微信、钉钉等多入口接单
- 自动调用外部 IAM、AD、LDAP 完成真正开通
- 计费、成本核算、供应商协同
- 多租户
- 自定义表单设计器
- 通用 BPM 平台化能力

## 3. 用户角色

### 3.1 员工

- 登录门户提交账号或权限申请
- 查看工单状态、审批进度和处理结果
- 接收知识推荐与自助引导
- 在处理完成后确认结果或退回
- 对已关闭工单进行评价

### 3.2 直属主管

- 审批下属发起的申请
- 查看申请原因、目标系统、权限类型与风险说明
- 给出通过、驳回或补充说明意见

### 3.3 系统负责人

- 审批敏感系统或高风险权限申请
- 关注目标系统的访问控制风险
- 留存审批意见与责任归属

### 3.4 服务台成员

- 查看待处理工单
- 抢单普通工单
- 处理已分派工单
- 填写执行记录、处理说明与结果

### 3.5 服务台组长

- 分派高敏工单
- 调整优先级
- 催办、升级和协调处理
- 监督队列积压与 SLA 风险

### 3.6 平台管理员

- 配置系统目录、权限项、审批模板、SLA 规则
- 维护用户、部门、主管关系
- 查看审计日志、统计报表与异常事件

## 4. 业务流程

### 4.1 提单前自助引导

1. 员工进入提单页并选择目标系统、权限类型和问题描述。
2. 系统基于目标系统、关键词和知识标签检索知识库与历史工单。
3. 如果命中高置信知识条目，优先展示自助解决方案。
4. 员工确认知识无法解决后，才允许继续正式提交工单。

### 4.2 提单与审批

1. 员工提交申请。
2. 系统生成工单编号，写入主表与详情表，并计算默认优先级。
3. 系统依据目标系统敏感级别与权限类型匹配审批模板。
4. 审批节点按顺序流转给直属主管、系统负责人或其他审批角色。
5. 任一节点驳回则工单进入驳回态。
6. 全部审批通过后，工单进入服务台待分派队列。

### 4.3 服务台处理

1. 服务台成员在统一队列查看待处理工单。
2. 普通工单可由成员直接抢单。
3. 高敏系统或高危权限工单必须由组长分派给具体处理人。
4. 处理人接单后进入处理中状态。
5. 处理过程中记录执行动作、说明、附件和处理结果快照。
6. 处理完成后工单进入待确认状态。

### 4.4 员工确认与关闭

1. 员工收到处理完成通知。
2. 员工确认结果正确后，工单关闭。
3. 若员工认为未完成或结果不符合预期，可退回处理中并附带说明。
4. 工单关闭后可评价，并可由服务台沉淀为知识条目。

### 4.5 SLA 与升级

1. 工单创建时按优先级匹配 SLA 规则。
2. 系统生成响应时限和解决时限检查任务。
3. 超时前发送提醒，超时后记录告警并通知责任人或组长。
4. 高风险积压工单支持升级处理。

## 5. 功能清单

### 5.1 员工门户

- 登录与个人工作台
- 我要申请
- 目标系统选择
- 权限类型选择
- 提单前知识推荐与相似问题推荐
- 申请原因填写
- 附件上传
- 我的申请列表
- 工单详情与审批进度
- 待确认工单处理
- 工单评价

### 5.2 审批中心

- 待审批列表
- 审批详情
- 通过、驳回、补充说明
- 审批意见记录
- 审批历史查看
- 审批通知

### 5.3 服务台作业台

- 待分派队列
- 待抢单队列
- 我的待办
- 高敏工单分派
- 接单与开始处理
- 处理记录填写
- 处理完成提交
- 退回补充说明
- SLA 风险视图
- 催办与升级

### 5.4 管理后台

- 用户管理
- 部门管理
- 主管关系维护
- 系统目录管理
- 权限项管理
- 系统敏感级别管理
- 审批模板管理
- SLA 规则管理
- 优先级默认规则管理
- 知识库管理
- 审计日志查看
- 统计报表

### 5.5 搜索与知识

- 知识全文检索
- 历史工单搜索
- 相似工单推荐
- 热门知识推荐
- 工单关闭后一键转知识

## 6. 状态机设计

### 6.1 工单主状态

- `DRAFT`
  申请人填写中，未正式提交
- `PENDING_APPROVAL`
  已提交，处于审批流中
- `APPROVAL_REJECTED`
  审批未通过
- `PENDING_ASSIGN`
  审批通过，等待服务台处理
- `PENDING_ACCEPT`
  已指派给具体处理人，等待接单
- `IN_PROGRESS`
  已接单并处理中
- `PENDING_CONFIRM`
  IT 处理完成，等待员工确认
- `CLOSED`
  员工确认完成
- `CANCELLED`
  申请人主动撤销

### 6.2 关键流转规则

- 提交后只能进入 `PENDING_APPROVAL`
- 审批全部通过后进入 `PENDING_ASSIGN`
- 普通工单可从 `PENDING_ASSIGN` 被抢单进入 `IN_PROGRESS`
- 高敏工单必须先分派进入 `PENDING_ACCEPT`，再由处理人接单进入 `IN_PROGRESS`
- `PENDING_CONFIRM` 可被员工确认进入 `CLOSED`
- `PENDING_CONFIRM` 可被员工退回到 `IN_PROGRESS`
- `CLOSED` 后不得直接改状态，只允许评价或发起新申请

## 7. 数据模型

### 7.1 MySQL 主数据

#### `user`

- id
- employee_no
- name
- email
- mobile
- department_id
- manager_id
- status
- source_type
- external_ref
- created_at
- updated_at

#### `department`

- id
- name
- parent_id
- manager_id
- external_ref
- status
- created_at
- updated_at

#### `system_resource`

- id
- code
- name
- owner_user_id
- sensitivity_level
- service_group_id
- status
- created_at
- updated_at

#### `permission_item`

- id
- system_id
- code
- name
- permission_level
- risk_level
- status
- created_at
- updated_at

#### `ticket`

- id
- ticket_no
- applicant_id
- department_id
- category
- request_type
- target_system_id
- permission_item_id
- priority
- current_status
- current_handler_id
- current_group_id
- approval_flow_id
- submitted_at
- closed_at
- created_at
- updated_at

#### `approval_template`

- id
- name
- system_sensitivity
- permission_risk_level
- status
- created_at
- updated_at

#### `approval_template_node`

- id
- template_id
- node_order
- approver_type
- approver_ref
- required_flag
- created_at
- updated_at

#### `approval_flow`

- id
- ticket_id
- template_id
- current_node_order
- status
- started_at
- finished_at
- created_at
- updated_at

#### `approval_node`

- id
- flow_id
- node_order
- approver_id
- approver_role
- action
- comment
- action_at
- created_at
- updated_at

#### `assignment_record`

- id
- ticket_id
- action_type
- from_user_id
- to_user_id
- from_group_id
- to_group_id
- reason
- created_at

#### `sla_policy`

- id
- priority
- response_minutes
- resolve_minutes
- confirm_minutes
- status
- created_at
- updated_at

#### `sla_task`

- id
- ticket_id
- task_type
- deadline_at
- triggered_at
- status
- created_at
- updated_at

#### `knowledge_article`

- id
- title
- summary
- category
- system_id
- status
- source_ticket_id
- created_by
- updated_by
- created_at
- updated_at

#### `notification`

- id
- receiver_id
- biz_type
- biz_id
- title
- content
- read_flag
- sent_at
- created_at

### 7.2 MongoDB 文档数据

#### `ticket_detail`

- ticketId
- applicationReason
- businessContext
- attachments
- extraFields
- snapshots

#### `operation_log`

- ticketId
- operatorId
- operatorRole
- actionType
- actionDesc
- beforeSnapshot
- afterSnapshot
- createdAt

#### `knowledge_content`

- articleId
- content
- tags
- keywords
- relatedTicketIds
- createdAt
- updatedAt

### 7.3 Elasticsearch 索引

- ticket_search_index
- knowledge_search_index

索引字段建议包括：

- 工单编号
- 标题摘要
- 系统名称
- 权限名称
- 分类
- 状态
- 申请部门
- 关键标签
- 知识标题
- 知识关键词

### 7.4 Redis 缓存

- 用户待办计数
- 服务台队列统计
- 热门知识列表
- 搜索建议
- 幂等 token
- SLA 预警缓存

## 8. 页面结构

### 8.1 员工门户

- `首页`
  展示我的待办、最近申请、推荐知识
- `发起申请`
  选择系统、权限项、原因说明、附件上传、知识拦截
- `我的申请`
  列表、筛选、详情、审批进度
- `待确认`
  对处理完成工单进行确认或退回

### 8.2 审批中心

- `待我审批`
- `我已审批`
- `审批详情`

### 8.3 服务台作业台

- `待分派`
- `待抢单`
- `我的处理中`
- `待确认回流`
- `超时预警`
- `工单详情`

### 8.4 管理后台

- `组织与用户`
- `系统与权限`
- `审批模板`
- `SLA 规则`
- `知识库`
- `审计日志`
- `统计报表`

## 9. 接口边界

### 9.1 门户接口

- `POST /api/portal/tickets`
  创建工单
- `GET /api/portal/tickets`
  查询我的工单
- `GET /api/portal/tickets/{id}`
  查询工单详情
- `POST /api/portal/tickets/{id}/confirm`
  员工确认
- `POST /api/portal/tickets/{id}/reject-result`
  员工退回处理
- `GET /api/portal/knowledge/recommendations`
  提单前知识推荐

### 9.2 审批接口

- `GET /api/approvals/pending`
- `GET /api/approvals/{ticketId}`
- `POST /api/approvals/{ticketId}/approve`
- `POST /api/approvals/{ticketId}/reject`
- `POST /api/approvals/{ticketId}/request-info`

### 9.3 服务台接口

- `GET /api/service-desk/queue`
- `POST /api/service-desk/tickets/{id}/claim`
- `POST /api/service-desk/tickets/{id}/assign`
- `POST /api/service-desk/tickets/{id}/accept`
- `POST /api/service-desk/tickets/{id}/process`
- `POST /api/service-desk/tickets/{id}/complete`

### 9.4 管理接口

- `CRUD /api/admin/users`
- `CRUD /api/admin/departments`
- `CRUD /api/admin/systems`
- `CRUD /api/admin/permissions`
- `CRUD /api/admin/approval-templates`
- `CRUD /api/admin/sla-policies`
- `CRUD /api/admin/knowledge`
- `GET /api/admin/audit-logs`
- `GET /api/admin/reports/overview`

## 10. 模块划分

### 10.1 `ticket-core`

负责工单主实体、状态机、工单创建、流转、确认与关闭。

### 10.2 `approval-core`

负责审批模板匹配、审批流实例、审批节点推进与审批结果写回。

### 10.3 `service-desk-core`

负责服务台队列、抢单、分派、接单、处理记录与完成闭环。

### 10.4 `knowledge-core`

负责知识文章、标签、知识沉淀与推荐规则。

### 10.5 `search-core`

负责工单索引、知识索引、相似问题推荐与搜索建议。

### 10.6 `rule-engine`

负责审批模板命中规则、优先级默认规则、高敏识别规则与 SLA 规则。

### 10.7 `message-center`

负责事件发布与消费，包括工单创建、审批完成、待确认提醒、SLA 检查、索引更新。

### 10.8 `cache-center`

负责待办缓存、热点知识缓存、幂等控制和分布式状态缓存。

### 10.9 `admin-report`

负责统计分析、报表查询与运营指标聚合。

### 10.10 `common-infra`

负责鉴权、异常、统一响应、审计封装、工具类、配置与基础设施能力。

## 11. 事件设计

建议至少定义以下领域事件：

- `ticket.created`
- `ticket.approval.completed`
- `ticket.assigned`
- `ticket.claimed`
- `ticket.completed`
- `ticket.confirmed`
- `ticket.reopened`
- `sla.warning.triggered`
- `knowledge.article.created`
- `search.index.refresh`

## 12. 非功能要求

### 12.1 安全

- 所有接口必须登录后访问
- 按角色和数据范围做权限校验
- 敏感操作记录审计日志
- 敏感字段可按需脱敏展示

### 12.2 审计

- 审批意见必须留痕
- 分派变更必须可追溯
- 状态流转必须有操作者和时间
- 关键处理动作应保留前后快照

### 12.3 可靠性

- 核心写操作支持幂等
- 异步消息消费支持防重复
- SLA 触发任务需要容错补偿
- 搜索索引与主数据允许最终一致

### 12.4 可扩展性

- 用户与组织模型预留 external_ref
- 审批模板支持规则扩展
- 目标系统与权限项配置化
- 后续可扩展到更多 IT 工单类型

## 13. 统计指标

- 工单总量
- 按优先级分布
- 按状态分布
- 审批通过率
- 平均响应时长
- 平均解决时长
- 超时率
- 待确认退回率
- 知识命中率
- 热门系统工单排行
- 服务台成员处理量

## 14. 第一阶段交付建议

### 14.1 核心必交付

- 用户登录与基础权限
- 员工提单
- 知识拦截
- 审批流
- 服务台分派与处理
- 员工确认关闭
- SLA 基础监控
- 审计日志
- 管理后台基础配置

### 14.2 可以第二批补齐

- 更强的相似工单推荐
- 热门知识运营
- 更细粒度统计报表
- AD 或企业通讯录同步
- 自动开通外部系统账号

## 15. 风险与边界说明

- 账号权限类工单如果后续需要真正执行开通动作，必须新增与外部系统的集成层，当前设计只覆盖流程与记录闭环
- 多级审批、敏感权限与高敏系统识别强依赖基础数据质量，第一阶段需要重视主数据配置准确性
- 强引导自助会影响用户提单体验，需要在命中策略上避免误拦截
- 统一服务台入口适合第一阶段，但后续如果系统种类快速增加，可能需要演进为按系统归属组自动分流

## 16. 结论

本设计将第一阶段聚焦在真实企业最常见的账号与权限工单场景，通过员工门户、审批中心、服务台作业台和管理后台四个主要交互面，建立从申请到关闭的完整闭环，并以知识推荐、SLA 和审计能力增强可运营性与可落地性。

这份设计既能支撑一个完整可演示、可扩展的企业 IT 服务台项目，也为后续对接企业身份源、自动化账号开通和更复杂的服务目录保留了足够演进空间。
