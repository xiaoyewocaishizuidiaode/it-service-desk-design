# 企业 IT 服务台智能工单分派 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** 构建一套面向企业内部账号与权限申请场景的 IT 服务台系统，完成从员工提单、审批、服务台处理到员工确认关闭的第一阶段可运行版本。

**Architecture:** 后端采用 Spring Boot 3 多模块单体，先把领域边界、状态机、审批流、服务台处理和审计打稳，再通过事件和缓存补齐异步能力。前端采用一个 Web 应用承载员工门户、审批中心、服务台作业台和管理后台，第一阶段优先实现核心作业页面，复杂运营视图放到后续迭代。

**Tech Stack:** Java 21, Spring Boot 3, Spring Web, Spring Security, Spring Data JPA, Spring Data MongoDB, Spring Data Redis, Spring AMQP, Spring Data Elasticsearch, MySQL, MongoDB, Redis, RabbitMQ, Elasticsearch, Maven, JUnit 5, Testcontainers, React, Vite, TypeScript, Ant Design

---

## 0. 执行前提

### 0.1 目录与交付约定

- 仓库根目录保留现有两份需求文档与设计文档
- 后端目录使用 `backend/`
- 前端目录使用 `frontend/`
- 数据库脚本目录使用 `deploy/sql/`
- 联调环境目录使用 `deploy/docker/`
- 接口文档目录使用 `docs/api/`

### 0.2 计划采用的项目结构

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
  src/test/resources/
frontend/
  package.json
  src/
    app/
    pages/
    features/
    components/
    services/
deploy/
  docker/
  sql/
docs/
  api/
```

### 0.3 里程碑

- M1 项目骨架与基础设施连通
- M2 工单主链路可跑通
- M3 审批流与服务台处理闭环
- M4 知识拦截、搜索与通知补齐
- M5 SLA、审计、统计和发布准备完成

## 1. 文件结构映射

### 1.1 后端模块职责

- `backend/ticket-app`
  启动模块，组合各业务模块与基础配置
- `backend/common-infra`
  统一响应、异常、鉴权、审计切面、通用枚举与工具
- `backend/identity-core`
  用户、部门、角色、主管关系、系统资源与权限项
- `backend/ticket-core`
  工单主实体、详情、状态机、员工确认关闭
- `backend/approval-core`
  审批模板、审批流、审批节点推进
- `backend/service-desk-core`
  服务台队列、抢单、分派、接单、处理完成
- `backend/knowledge-core`
  知识文章、提单前推荐、工单转知识
- `backend/search-core`
  Elasticsearch 索引与查询服务
- `backend/rule-engine`
  默认优先级、高敏识别、审批模板命中、SLA 规则
- `backend/message-center`
  RabbitMQ 事件发布消费
- `backend/cache-center`
  Redis 待办、热点知识、幂等控制
- `backend/admin-report`
  统计查询与概览报表

### 1.2 前端页面职责

- `frontend/src/pages/portal`
  员工门户、发起申请、我的申请、待确认
- `frontend/src/pages/approval`
  待我审批、审批详情
- `frontend/src/pages/service-desk`
  待分派、待抢单、我的处理中、超时预警
- `frontend/src/pages/admin`
  用户、部门、系统、权限项、审批模板、SLA、知识管理
- `frontend/src/services`
  REST API 封装
- `frontend/src/features`
  工单、审批、服务台、知识库、报表等领域组件

## 2. 开发顺序总览

1. 先搭基础骨架和运行环境，确保五类中间件接入与测试框架可用
2. 再做身份与主数据，避免审批和工单写到一半发现组织模型不够用
3. 之后实现工单状态机和审批流，把主业务闭环跑通
4. 再做服务台分派、知识拦截、通知与搜索，补齐体验层
5. 最后完善 SLA、审计、统计、联调脚本和发布材料

## 3. 模块任务拆解

### Task 1: 初始化仓库骨架与本地联调环境

**Files:**
- Create: `backend/pom.xml`
- Create: `backend/ticket-app/pom.xml`
- Create: `backend/common-infra/pom.xml`
- Create: `backend/identity-core/pom.xml`
- Create: `backend/ticket-core/pom.xml`
- Create: `backend/approval-core/pom.xml`
- Create: `backend/service-desk-core/pom.xml`
- Create: `backend/knowledge-core/pom.xml`
- Create: `backend/search-core/pom.xml`
- Create: `backend/rule-engine/pom.xml`
- Create: `backend/message-center/pom.xml`
- Create: `backend/cache-center/pom.xml`
- Create: `backend/admin-report/pom.xml`
- Create: `backend/ticket-app/src/main/java/com/company/itsm/TicketApplication.java`
- Create: `backend/ticket-app/src/main/resources/application.yml`
- Create: `deploy/docker/docker-compose.yml`
- Create: `deploy/docker/.env.example`

- [ ] **Step 1: 创建后端 Maven 聚合工程**

```xml
<!-- backend/pom.xml -->
<project xmlns="http://maven.apache.org/POM/4.0.0">
  <modelVersion>4.0.0</modelVersion>
  <groupId>com.company</groupId>
  <artifactId>enterprise-it-service-desk</artifactId>
  <version>0.1.0-SNAPSHOT</version>
  <packaging>pom</packaging>
  <modules>
    <module>ticket-app</module>
    <module>common-infra</module>
    <module>identity-core</module>
    <module>ticket-core</module>
    <module>approval-core</module>
    <module>service-desk-core</module>
    <module>knowledge-core</module>
    <module>search-core</module>
    <module>rule-engine</module>
    <module>message-center</module>
    <module>cache-center</module>
    <module>admin-report</module>
  </modules>
  <properties>
    <java.version>21</java.version>
    <spring-boot.version>3.3.4</spring-boot.version>
  </properties>
</project>
```

- [ ] **Step 2: 编写启动模块与基础配置**

```java
// backend/ticket-app/src/main/java/com/company/itsm/TicketApplication.java
package com.company.itsm;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class TicketApplication {
    public static void main(String[] args) {
        SpringApplication.run(TicketApplication.class, args);
    }
}
```

```yaml
# backend/ticket-app/src/main/resources/application.yml
spring:
  datasource:
    url: jdbc:mysql://localhost:3306/itsm
    username: itsm
    password: itsm
  data:
    mongodb:
      uri: mongodb://localhost:27017/itsm
    redis:
      host: localhost
      port: 6379
  rabbitmq:
    host: localhost
    port: 5672
  elasticsearch:
    uris: http://localhost:9200
server:
  port: 8080
```

- [ ] **Step 3: 编写本地联调 compose**

```yaml
# deploy/docker/docker-compose.yml
services:
  mysql:
    image: mysql:8.4
    environment:
      MYSQL_DATABASE: itsm
      MYSQL_USER: itsm
      MYSQL_PASSWORD: itsm
      MYSQL_ROOT_PASSWORD: root
    ports: ["3306:3306"]
  mongo:
    image: mongo:7
    ports: ["27017:27017"]
  redis:
    image: redis:7
    ports: ["6379:6379"]
  rabbitmq:
    image: rabbitmq:3-management
    ports: ["5672:5672", "15672:15672"]
  elasticsearch:
    image: elasticsearch:8.14.3
    environment:
      discovery.type: single-node
      xpack.security.enabled: "false"
    ports: ["9200:9200"]
```

- [ ] **Step 4: 启动基础环境并验证服务可达**

Run: `docker compose -f deploy/docker/docker-compose.yml up -d`  
Expected: MySQL、MongoDB、Redis、RabbitMQ、Elasticsearch 容器全部为 `Up`

- [ ] **Step 5: 启动后端空应用并验证健康状态**

Run: `mvn -f backend/pom.xml -pl ticket-app spring-boot:run`  
Expected: 控制台出现 `Started TicketApplication`

- [ ] **Step 6: Commit**

```bash
git add backend deploy
git commit -m "chore: bootstrap backend modules and local infrastructure"
```

### Task 2: 建立基础工程约束与测试框架

**Files:**
- Create: `backend/common-infra/src/main/java/com/company/itsm/common/api/ApiResponse.java`
- Create: `backend/common-infra/src/main/java/com/company/itsm/common/exception/BusinessException.java`
- Create: `backend/common-infra/src/main/java/com/company/itsm/common/web/GlobalExceptionHandler.java`
- Create: `backend/common-infra/src/test/java/com/company/itsm/common/web/GlobalExceptionHandlerTest.java`
- Create: `backend/ticket-app/src/test/resources/application-test.yml`

- [ ] **Step 1: 写统一返回结构测试**

```java
@Test
void shouldReturnCodeMessageAndData() {
    ApiResponse<String> response = ApiResponse.success("ok");
    assertEquals("0000", response.code());
    assertEquals("success", response.message());
    assertEquals("ok", response.data());
}
```

- [ ] **Step 2: 运行测试确认当前失败**

Run: `mvn -f backend/pom.xml -pl common-infra test -Dtest=GlobalExceptionHandlerTest`  
Expected: FAIL with `cannot find symbol ApiResponse`

- [ ] **Step 3: 实现统一响应与异常处理**

```java
public record ApiResponse<T>(String code, String message, T data) {
    public static <T> ApiResponse<T> success(T data) {
        return new ApiResponse<>("0000", "success", data);
    }
    public static <T> ApiResponse<T> fail(String code, String message) {
        return new ApiResponse<>(code, message, null);
    }
}
```

```java
@RestControllerAdvice
public class GlobalExceptionHandler {
    @ExceptionHandler(BusinessException.class)
    public ResponseEntity<ApiResponse<Void>> handleBusiness(BusinessException ex) {
        return ResponseEntity.badRequest().body(ApiResponse.fail(ex.getCode(), ex.getMessage()));
    }
}
```

- [ ] **Step 4: 运行公共模块测试**

Run: `mvn -f backend/pom.xml -pl common-infra test`  
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add backend/common-infra backend/ticket-app/src/test
git commit -m "feat: add common response and exception handling"
```

### Task 3: 实现身份与主数据模块

**Files:**
- Create: `backend/identity-core/src/main/java/com/company/itsm/identity/domain/User.java`
- Create: `backend/identity-core/src/main/java/com/company/itsm/identity/domain/Department.java`
- Create: `backend/identity-core/src/main/java/com/company/itsm/identity/domain/SystemResource.java`
- Create: `backend/identity-core/src/main/java/com/company/itsm/identity/domain/PermissionItem.java`
- Create: `backend/identity-core/src/main/java/com/company/itsm/identity/repository/UserRepository.java`
- Create: `backend/identity-core/src/main/java/com/company/itsm/identity/service/IdentitySeedService.java`
- Create: `backend/identity-core/src/test/java/com/company/itsm/identity/service/IdentitySeedServiceTest.java`
- Create: `deploy/sql/V1__identity_schema.sql`

- [ ] **Step 1: 编写主数据建模测试**

```java
@Test
void shouldMarkCoreSystemAsSensitive() {
    SystemResource resource = new SystemResource("ERP", "ERP系统", SensitivityLevel.CORE);
    assertEquals(SensitivityLevel.CORE, resource.getSensitivityLevel());
}
```

- [ ] **Step 2: 运行测试确认实体缺失**

Run: `mvn -f backend/pom.xml -pl identity-core test -Dtest=IdentitySeedServiceTest`  
Expected: FAIL with `cannot find symbol SystemResource`

- [ ] **Step 3: 实现身份与系统资源实体**

```java
@Entity
@Table(name = "system_resource")
public class SystemResource {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    private String code;
    private String name;
    @Enumerated(EnumType.STRING)
    private SensitivityLevel sensitivityLevel;
}
```

```sql
CREATE TABLE user (
  id BIGINT PRIMARY KEY AUTO_INCREMENT,
  employee_no VARCHAR(64) NOT NULL UNIQUE,
  name VARCHAR(128) NOT NULL,
  email VARCHAR(128),
  mobile VARCHAR(32),
  department_id BIGINT,
  manager_id BIGINT,
  status VARCHAR(32) NOT NULL,
  source_type VARCHAR(32) NOT NULL,
  external_ref VARCHAR(128),
  created_at DATETIME NOT NULL,
  updated_at DATETIME NOT NULL
);
```

- [ ] **Step 4: 实现初始化种子服务**

```java
@Service
public class IdentitySeedService {
    public void seedDefaultData() {
        // 默认创建 IT 服务台部门、平台管理员、ERP 系统与常见权限项
    }
}
```

- [ ] **Step 5: 运行身份模块测试**

Run: `mvn -f backend/pom.xml -pl identity-core test`  
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add backend/identity-core deploy/sql/V1__identity_schema.sql
git commit -m "feat: add identity and system resource models"
```

### Task 4: 实现工单核心模型与状态机

**Files:**
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/domain/Ticket.java`
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/domain/TicketStatus.java`
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/domain/TicketDetailDocument.java`
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/service/TicketStateMachine.java`
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/service/TicketCommandService.java`
- Create: `backend/ticket-core/src/test/java/com/company/itsm/ticket/service/TicketStateMachineTest.java`
- Create: `deploy/sql/V2__ticket_schema.sql`

- [ ] **Step 1: 写状态流转失败测试**

```java
@Test
void shouldRejectDirectCloseFromPendingApproval() {
    Ticket ticket = Ticket.createDraft(1L, 1L, 1L, 1L);
    ticket.submit();
    assertThrows(BusinessException.class, ticket::closeDirectly);
}
```

- [ ] **Step 2: 运行测试确认状态机未实现**

Run: `mvn -f backend/pom.xml -pl ticket-core test -Dtest=TicketStateMachineTest`  
Expected: FAIL with `cannot find symbol Ticket`

- [ ] **Step 3: 实现工单实体与状态机**

```java
public enum TicketStatus {
    DRAFT, PENDING_APPROVAL, APPROVAL_REJECTED, PENDING_ASSIGN,
    PENDING_ACCEPT, IN_PROGRESS, PENDING_CONFIRM, CLOSED, CANCELLED
}
```

```java
public class TicketStateMachine {
    public void moveToPendingConfirm(Ticket ticket) {
        if (ticket.getCurrentStatus() != TicketStatus.IN_PROGRESS) {
            throw new BusinessException("TICKET_STATE_INVALID", "only in progress ticket can complete");
        }
        ticket.setCurrentStatus(TicketStatus.PENDING_CONFIRM);
    }
}
```

- [ ] **Step 4: 实现 MySQL 与 Mongo 双写入口**

```java
@Service
public class TicketCommandService {
    public Long createTicket(CreateTicketCommand command) {
        // 保存 ticket 主表
        // 保存 TicketDetailDocument
        // 发布 ticket.created 事件
        return 1L;
    }
}
```

- [ ] **Step 5: 运行工单模块测试**

Run: `mvn -f backend/pom.xml -pl ticket-core test`  
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add backend/ticket-core deploy/sql/V2__ticket_schema.sql
git commit -m "feat: add ticket aggregate and state machine"
```

### Task 5: 实现规则引擎与默认优先级

**Files:**
- Create: `backend/rule-engine/src/main/java/com/company/itsm/rule/PriorityRuleService.java`
- Create: `backend/rule-engine/src/main/java/com/company/itsm/rule/SensitivityRuleService.java`
- Create: `backend/rule-engine/src/main/java/com/company/itsm/rule/ApprovalTemplateMatchService.java`
- Create: `backend/rule-engine/src/test/java/com/company/itsm/rule/ApprovalTemplateMatchServiceTest.java`

- [ ] **Step 1: 写审批模板命中测试**

```java
@Test
void shouldMatchCoreTemplateForCoreSystemAndAdminPermission() {
    ApprovalTemplate template = service.match(SensitivityLevel.CORE, RiskLevel.HIGH);
    assertEquals("core-admin-template", template.getName());
}
```

- [ ] **Step 2: 运行规则模块测试确认失败**

Run: `mvn -f backend/pom.xml -pl rule-engine test -Dtest=ApprovalTemplateMatchServiceTest`  
Expected: FAIL with `cannot find symbol ApprovalTemplateMatchService`

- [ ] **Step 3: 实现默认优先级与高敏判定**

```java
public class SensitivityRuleService {
    public boolean requiresLeaderAssignment(SensitivityLevel level, RiskLevel riskLevel) {
        return level == SensitivityLevel.CORE || riskLevel == RiskLevel.HIGH;
    }
}
```

```java
public class PriorityRuleService {
    public TicketPriority resolveDefaultPriority(RequestType requestType) {
        return switch (requestType) {
            case RESET_PASSWORD -> TicketPriority.P3;
            case ACCOUNT_OPEN -> TicketPriority.P2;
            case ADMIN_PERMISSION -> TicketPriority.P1;
        };
    }
}
```

- [ ] **Step 4: 运行规则模块测试**

Run: `mvn -f backend/pom.xml -pl rule-engine test`  
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add backend/rule-engine
git commit -m "feat: add ticket priority and approval matching rules"
```

### Task 6: 实现审批流核心

**Files:**
- Create: `backend/approval-core/src/main/java/com/company/itsm/approval/domain/ApprovalFlow.java`
- Create: `backend/approval-core/src/main/java/com/company/itsm/approval/domain/ApprovalNode.java`
- Create: `backend/approval-core/src/main/java/com/company/itsm/approval/service/ApprovalCommandService.java`
- Create: `backend/approval-core/src/main/java/com/company/itsm/approval/web/ApprovalController.java`
- Create: `backend/approval-core/src/test/java/com/company/itsm/approval/service/ApprovalCommandServiceTest.java`
- Create: `deploy/sql/V3__approval_schema.sql`

- [ ] **Step 1: 写审批通过推进测试**

```java
@Test
void shouldMoveTicketToPendingAssignWhenAllNodesApproved() {
    ApprovalFlow flow = fixture.withManagerNode().withOwnerNode();
    flow.approveCurrentNode(1001L, "ok");
    flow.approveCurrentNode(1002L, "ok");
    assertEquals(ApprovalFlowStatus.APPROVED, flow.getStatus());
}
```

- [ ] **Step 2: 运行审批模块测试确认失败**

Run: `mvn -f backend/pom.xml -pl approval-core test -Dtest=ApprovalCommandServiceTest`  
Expected: FAIL with `cannot find symbol ApprovalFlow`

- [ ] **Step 3: 实现审批流推进逻辑**

```java
public void approve(Long ticketId, Long approverId, String comment) {
    ApprovalFlow flow = flowRepository.findByTicketId(ticketId).orElseThrow();
    flow.approveCurrentNode(approverId, comment);
    if (flow.isApproved()) {
        ticketGateway.moveToPendingAssign(ticketId);
    }
}
```

- [ ] **Step 4: 增加驳回与补充说明接口**

```java
@PostMapping("/{ticketId}/reject")
public ApiResponse<Void> reject(@PathVariable Long ticketId, @RequestBody RejectApprovalRequest request) {
    commandService.reject(ticketId, request.approverId(), request.comment());
    return ApiResponse.success(null);
}
```

- [ ] **Step 5: 运行审批模块测试**

Run: `mvn -f backend/pom.xml -pl approval-core test`  
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add backend/approval-core deploy/sql/V3__approval_schema.sql
git commit -m "feat: add approval flow and approval endpoints"
```

### Task 7: 实现服务台分派、抢单与处理闭环

**Files:**
- Create: `backend/service-desk-core/src/main/java/com/company/itsm/servicedesk/service/AssignmentService.java`
- Create: `backend/service-desk-core/src/main/java/com/company/itsm/servicedesk/service/ProcessingService.java`
- Create: `backend/service-desk-core/src/main/java/com/company/itsm/servicedesk/web/ServiceDeskController.java`
- Create: `backend/service-desk-core/src/test/java/com/company/itsm/servicedesk/service/AssignmentServiceTest.java`
- Create: `deploy/sql/V4__service_desk_schema.sql`

- [ ] **Step 1: 写高敏工单禁止抢单测试**

```java
@Test
void shouldRejectClaimForSensitiveTicket() {
    Ticket ticket = fixture.pendingAssignCoreTicket();
    assertThrows(BusinessException.class, () -> assignmentService.claim(ticket.getId(), 2001L));
}
```

- [ ] **Step 2: 运行服务台模块测试确认失败**

Run: `mvn -f backend/pom.xml -pl service-desk-core test -Dtest=AssignmentServiceTest`  
Expected: FAIL with `cannot find symbol AssignmentService`

- [ ] **Step 3: 实现分派与抢单逻辑**

```java
public void claim(Long ticketId, Long userId) {
    Ticket ticket = ticketGateway.getById(ticketId);
    if (ticket.requiresLeaderAssignment()) {
        throw new BusinessException("LEADER_ASSIGN_REQUIRED", "sensitive ticket must be assigned by leader");
    }
    ticketGateway.moveToInProgress(ticketId, userId);
}
```

```java
public void assign(Long ticketId, Long leaderId, Long assigneeId) {
    ticketGateway.moveToPendingAccept(ticketId, assigneeId);
    assignmentRecordRepository.save(new AssignmentRecord(ticketId, "ASSIGN", leaderId, assigneeId));
}
```

- [ ] **Step 4: 实现处理完成与员工待确认**

```java
public void complete(Long ticketId, Long handlerId, String resultSummary) {
    operationLogGateway.saveResultSnapshot(ticketId, handlerId, resultSummary);
    ticketGateway.moveToPendingConfirm(ticketId);
}
```

- [ ] **Step 5: 运行服务台模块测试**

Run: `mvn -f backend/pom.xml -pl service-desk-core test`  
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add backend/service-desk-core deploy/sql/V4__service_desk_schema.sql
git commit -m "feat: add service desk assignment and processing flow"
```

### Task 8: 实现员工门户接口与确认关闭

**Files:**
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/web/PortalTicketController.java`
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/service/TicketQueryService.java`
- Create: `backend/ticket-core/src/test/java/com/company/itsm/ticket/web/PortalTicketControllerTest.java`

- [ ] **Step 1: 写员工确认关闭接口测试**

```java
@Test
void shouldCloseTicketWhenApplicantConfirms() throws Exception {
    mockMvc.perform(post("/api/portal/tickets/1/confirm"))
        .andExpect(status().isOk())
        .andExpect(jsonPath("$.code").value("0000"));
}
```

- [ ] **Step 2: 运行门户接口测试确认失败**

Run: `mvn -f backend/pom.xml -pl ticket-core test -Dtest=PortalTicketControllerTest`  
Expected: FAIL with `No mapping for POST /api/portal/tickets/1/confirm`

- [ ] **Step 3: 实现提单、查询、确认、退回接口**

```java
@RestController
@RequestMapping("/api/portal/tickets")
public class PortalTicketController {
    @PostMapping
    public ApiResponse<Long> create(@RequestBody CreateTicketRequest request) {
        return ApiResponse.success(ticketCommandService.createTicket(request.toCommand()));
    }
    @PostMapping("/{id}/confirm")
    public ApiResponse<Void> confirm(@PathVariable Long id) {
        ticketCommandService.confirm(id);
        return ApiResponse.success(null);
    }
}
```

- [ ] **Step 4: 运行工单核心测试**

Run: `mvn -f backend/pom.xml -pl ticket-core test`  
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add backend/ticket-core
git commit -m "feat: add portal ticket APIs and employee confirmation flow"
```

### Task 9: 实现知识库与提单前强引导

**Files:**
- Create: `backend/knowledge-core/src/main/java/com/company/itsm/knowledge/domain/KnowledgeArticle.java`
- Create: `backend/knowledge-core/src/main/java/com/company/itsm/knowledge/service/KnowledgeRecommendationService.java`
- Create: `backend/knowledge-core/src/main/java/com/company/itsm/knowledge/web/KnowledgeController.java`
- Create: `backend/knowledge-core/src/test/java/com/company/itsm/knowledge/service/KnowledgeRecommendationServiceTest.java`
- Create: `backend/search-core/src/main/java/com/company/itsm/search/service/KnowledgeSearchService.java`

- [ ] **Step 1: 写高置信知识命中测试**

```java
@Test
void shouldReturnBlockingRecommendationWhenConfidenceHigh() {
    Recommendation result = service.recommend("ERP", "重置密码");
    assertTrue(result.blockSubmit());
}
```

- [ ] **Step 2: 运行知识模块测试确认失败**

Run: `mvn -f backend/pom.xml -pl knowledge-core test -Dtest=KnowledgeRecommendationServiceTest`  
Expected: FAIL with `cannot find symbol KnowledgeRecommendationService`

- [ ] **Step 3: 实现知识推荐与阻断策略**

```java
public Recommendation recommend(String systemCode, String keyword) {
    List<KnowledgeArticle> articles = searchGateway.search(systemCode, keyword);
    boolean blockSubmit = articles.stream().anyMatch(article -> article.getScore() >= 0.85);
    return new Recommendation(articles, blockSubmit);
}
```

- [ ] **Step 4: 实现工单关闭后一键转知识**

```java
public Long createFromTicket(Long ticketId) {
    TicketSnapshot snapshot = ticketGateway.loadClosedTicket(ticketId);
    return articleRepository.save(KnowledgeArticle.fromSnapshot(snapshot)).getId();
}
```

- [ ] **Step 5: 运行知识与搜索模块测试**

Run: `mvn -f backend/pom.xml -pl knowledge-core,search-core test`  
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add backend/knowledge-core backend/search-core
git commit -m "feat: add knowledge recommendation and ticket to article conversion"
```

### Task 10: 实现消息中心、通知与缓存

**Files:**
- Create: `backend/message-center/src/main/java/com/company/itsm/message/TicketEventPublisher.java`
- Create: `backend/message-center/src/main/java/com/company/itsm/message/TicketCreatedListener.java`
- Create: `backend/cache-center/src/main/java/com/company/itsm/cache/TodoCounterCacheService.java`
- Create: `backend/cache-center/src/main/java/com/company/itsm/cache/IdempotencyService.java`
- Create: `backend/message-center/src/test/java/com/company/itsm/message/TicketCreatedListenerTest.java`

- [ ] **Step 1: 写 ticket.created 事件消费测试**

```java
@Test
void shouldIncreaseQueueCounterWhenTicketCreated() {
    listener.onMessage(new TicketCreatedEvent(1L, 1L, "P2"));
    verify(todoCounterCacheService).increasePendingAssignCount(1L);
}
```

- [ ] **Step 2: 运行消息模块测试确认失败**

Run: `mvn -f backend/pom.xml -pl message-center,cache-center test -Dtest=TicketCreatedListenerTest`  
Expected: FAIL with `cannot find symbol TicketCreatedListener`

- [ ] **Step 3: 实现事件发布消费与待办缓存**

```java
public void publishTicketCreated(TicketCreatedEvent event) {
    rabbitTemplate.convertAndSend("ticket.exchange", "ticket.created", event);
}
```

```java
@RabbitListener(queues = "ticket.created.queue")
public void onMessage(TicketCreatedEvent event) {
    todoCounterCacheService.increasePendingAssignCount(event.departmentId());
}
```

- [ ] **Step 4: 实现幂等 token 检查**

```java
public boolean acquire(String token) {
    return Boolean.TRUE.equals(redisTemplate.opsForValue().setIfAbsent("idem:" + token, "1", Duration.ofMinutes(5)));
}
```

- [ ] **Step 5: 运行消息与缓存模块测试**

Run: `mvn -f backend/pom.xml -pl message-center,cache-center test`  
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add backend/message-center backend/cache-center
git commit -m "feat: add ticket events notification cache and idempotency"
```

### Task 11: 实现 SLA、审计与报表

**Files:**
- Create: `backend/admin-report/src/main/java/com/company/itsm/report/service/OverviewReportService.java`
- Create: `backend/admin-report/src/main/java/com/company/itsm/report/web/ReportController.java`
- Create: `backend/common-infra/src/main/java/com/company/itsm/common/audit/AuditLogAspect.java`
- Create: `backend/ticket-core/src/main/java/com/company/itsm/ticket/service/SlaSchedulerService.java`
- Create: `backend/admin-report/src/test/java/com/company/itsm/report/service/OverviewReportServiceTest.java`
- Create: `deploy/sql/V5__audit_and_sla_schema.sql`

- [ ] **Step 1: 写 SLA 逾期识别测试**

```java
@Test
void shouldFlagTicketWhenResolveDeadlineExceeded() {
    TicketSlaView view = service.evaluate(LocalDateTime.now().minusHours(5), TicketPriority.P2);
    assertTrue(view.resolveOverdue());
}
```

- [ ] **Step 2: 运行报表测试确认失败**

Run: `mvn -f backend/pom.xml -pl admin-report,ticket-core test -Dtest=OverviewReportServiceTest`  
Expected: FAIL with `cannot find symbol OverviewReportService`

- [ ] **Step 3: 实现审计切面和 SLA 检查服务**

```java
@Around("@annotation(Auditable)")
public Object recordAudit(ProceedingJoinPoint point) throws Throwable {
    Object result = point.proceed();
    auditLogRepository.save(AuditLogEntry.from(point, result));
    return result;
}
```

```java
public void scanExpiredTickets() {
    List<Ticket> tickets = ticketRepository.findOpenTickets();
    tickets.stream().filter(this::isResolveOverdue).forEach(this::triggerWarning);
}
```

- [ ] **Step 4: 实现统计概览接口**

```java
@GetMapping("/api/admin/reports/overview")
public ApiResponse<OverviewReport> overview() {
    return ApiResponse.success(reportService.loadOverview());
}
```

- [ ] **Step 5: 运行审计、SLA 与报表测试**

Run: `mvn -f backend/pom.xml -pl admin-report,ticket-core,common-infra test`  
Expected: PASS

- [ ] **Step 6: Commit**

```bash
git add backend/admin-report backend/common-infra backend/ticket-core deploy/sql/V5__audit_and_sla_schema.sql
git commit -m "feat: add sla audit and overview reporting"
```

### Task 12: 实现前端基础框架与员工门户

**Files:**
- Create: `frontend/package.json`
- Create: `frontend/src/app/router.tsx`
- Create: `frontend/src/app/layout/AppShell.tsx`
- Create: `frontend/src/pages/portal/CreateTicketPage.tsx`
- Create: `frontend/src/pages/portal/MyTicketsPage.tsx`
- Create: `frontend/src/pages/portal/PendingConfirmPage.tsx`
- Create: `frontend/src/services/ticketService.ts`
- Create: `frontend/src/features/ticket/CreateTicketForm.tsx`
- Create: `frontend/src/features/knowledge/KnowledgeInterceptPanel.tsx`
- Create: `frontend/src/__tests__/CreateTicketPage.test.tsx`

- [ ] **Step 1: 写员工提单页渲染测试**

```tsx
it("renders ticket creation form", () => {
  render(<CreateTicketPage />);
  expect(screen.getByText("发起申请")).toBeInTheDocument();
  expect(screen.getByLabelText("目标系统")).toBeInTheDocument();
});
```

- [ ] **Step 2: 运行前端测试确认失败**

Run: `cd frontend && npm test -- CreateTicketPage.test.tsx`  
Expected: FAIL with `Cannot find module './CreateTicketPage'`

- [ ] **Step 3: 实现前端应用骨架与提单页**

```tsx
export function CreateTicketPage() {
  return (
    <AppShell>
      <h1>发起申请</h1>
      <CreateTicketForm />
      <KnowledgeInterceptPanel />
    </AppShell>
  );
}
```

```tsx
export async function createTicket(payload: CreateTicketPayload) {
  return request.post("/api/portal/tickets", payload);
}
```

- [ ] **Step 4: 运行前端测试**

Run: `cd frontend && npm test -- --runInBand`  
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add frontend
git commit -m "feat: add frontend app shell and portal ticket pages"
```

### Task 13: 实现审批中心与服务台作业台前端

**Files:**
- Create: `frontend/src/pages/approval/PendingApprovalPage.tsx`
- Create: `frontend/src/pages/approval/ApprovalDetailPage.tsx`
- Create: `frontend/src/pages/service-desk/PendingAssignPage.tsx`
- Create: `frontend/src/pages/service-desk/QueuePage.tsx`
- Create: `frontend/src/pages/service-desk/MyInProgressPage.tsx`
- Create: `frontend/src/services/approvalService.ts`
- Create: `frontend/src/services/serviceDeskService.ts`
- Create: `frontend/src/__tests__/PendingAssignPage.test.tsx`

- [ ] **Step 1: 写服务台待分派页面测试**

```tsx
it("renders pending assign queue", () => {
  render(<PendingAssignPage />);
  expect(screen.getByText("待分派")).toBeInTheDocument();
});
```

- [ ] **Step 2: 运行前端页面测试确认失败**

Run: `cd frontend && npm test -- PendingAssignPage.test.tsx`  
Expected: FAIL with `Cannot find module '../pages/service-desk/PendingAssignPage'`

- [ ] **Step 3: 实现审批与服务台作业页**

```tsx
export function PendingAssignPage() {
  return (
    <AppShell>
      <h1>待分派</h1>
      <TicketQueueTable mode="assign" />
    </AppShell>
  );
}
```

```tsx
export async function assignTicket(id: number, assigneeId: number) {
  return request.post(`/api/service-desk/tickets/${id}/assign`, { assigneeId });
}
```

- [ ] **Step 4: 运行前端测试**

Run: `cd frontend && npm test -- --runInBand`  
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add frontend
git commit -m "feat: add approval center and service desk pages"
```

### Task 14: 实现管理后台前端与系统配置页

**Files:**
- Create: `frontend/src/pages/admin/SystemResourcePage.tsx`
- Create: `frontend/src/pages/admin/ApprovalTemplatePage.tsx`
- Create: `frontend/src/pages/admin/SlaPolicyPage.tsx`
- Create: `frontend/src/pages/admin/KnowledgeAdminPage.tsx`
- Create: `frontend/src/services/adminService.ts`
- Create: `frontend/src/__tests__/SystemResourcePage.test.tsx`

- [ ] **Step 1: 写系统资源配置页测试**

```tsx
it("renders system resource management", () => {
  render(<SystemResourcePage />);
  expect(screen.getByText("系统与权限")).toBeInTheDocument();
});
```

- [ ] **Step 2: 运行管理端测试确认失败**

Run: `cd frontend && npm test -- SystemResourcePage.test.tsx`  
Expected: FAIL with `Cannot find module '../pages/admin/SystemResourcePage'`

- [ ] **Step 3: 实现管理页和接口封装**

```tsx
export function SystemResourcePage() {
  return (
    <AppShell>
      <h1>系统与权限</h1>
      <SystemResourceTable />
    </AppShell>
  );
}
```

```tsx
export async function listSystems() {
  return request.get("/api/admin/systems");
}
```

- [ ] **Step 4: 运行前端测试**

Run: `cd frontend && npm test -- --runInBand`  
Expected: PASS

- [ ] **Step 5: Commit**

```bash
git add frontend
git commit -m "feat: add admin console pages for master data and sla"
```

### Task 15: 端到端联调、文档与交付清单

**Files:**
- Create: `docs/api/openapi.yaml`
- Create: `README.md`
- Create: `deploy/sql/V6__seed_demo_data.sql`
- Create: `frontend/.env.example`
- Modify: `企业IT服务台智能工单分派设计.md`

- [ ] **Step 1: 编写最小接口文档**

```yaml
paths:
  /api/portal/tickets:
    post:
      summary: 创建工单
  /api/approvals/{ticketId}/approve:
    post:
      summary: 审批通过
```

- [ ] **Step 2: 准备演示种子数据**

```sql
INSERT INTO department(name, status, created_at, updated_at) VALUES ('IT服务台', 'ACTIVE', NOW(), NOW());
INSERT INTO user(employee_no, name, status, source_type, created_at, updated_at) VALUES ('E1001', '张三', 'ACTIVE', 'LOCAL', NOW(), NOW());
```

- [ ] **Step 3: 运行全量后端测试与前端测试**

Run: `mvn -f backend/pom.xml test`  
Expected: PASS

Run: `cd frontend && npm test -- --runInBand`  
Expected: PASS

- [ ] **Step 4: 启动联调环境并人工走通主链路**

Run: `docker compose -f deploy/docker/docker-compose.yml up -d && mvn -f backend/pom.xml -pl ticket-app spring-boot:run && cd frontend && npm run dev`  
Expected: 能演示“提单 -> 审批 -> 分派 -> 处理 -> 确认关闭 -> 转知识”

- [ ] **Step 5: 补充 README 中的启动步骤与系统说明**

```md
## Quick Start
1. 启动 docker compose
2. 启动 backend/ticket-app
3. 启动 frontend
4. 导入 deploy/sql 下脚本
```

- [ ] **Step 6: Commit**

```bash
git add README.md docs/api deploy/sql frontend/.env.example 企业IT服务台智能工单分派设计.md
git commit -m "docs: add delivery docs demo data and integration guide"
```

## 4. 里程碑验收标准

### M1 项目骨架与基础设施连通

- 后端多模块工程可编译
- Docker 本地依赖可启动
- 应用可连接 MySQL、MongoDB、Redis、RabbitMQ、Elasticsearch
- 公共异常与返回结构测试通过

### M2 工单主链路可跑通

- 已有用户、部门、系统资源、权限项主数据
- 员工可创建工单
- 工单状态机可约束非法流转
- 工单主表与详情文档可成功持久化

### M3 审批流与服务台闭环

- 审批模板可按系统敏感级别与权限风险匹配
- 审批通过后进入服务台待分派
- 普通工单可抢单，高敏工单只能组长分派
- 处理完成后进入待确认，员工可确认关闭或退回

### M4 知识、搜索与通知补齐

- 提单前可返回知识推荐
- 高置信知识命中时可阻断提交
- 工单关闭后可转知识
- 关键节点事件可驱动待办与通知更新

### M5 SLA、审计、报表与发布准备

- 核心操作具备审计日志
- SLA 超时可识别并告警
- 管理端可查看概览指标
- README、接口文档、演示数据和联调脚本齐备

## 5. 风险控制

- 前后端同时开工时，优先以 OpenAPI 草案锁定字段，避免并行开发时接口频繁漂移
- 审批流、高敏判定、状态机属于强约束域，必须优先写单元测试再实现
- 搜索、消息、缓存一律按“主链路可降级”设计，不能阻断提单和处理主流程
- AD、自动开通、复杂统计属于后续扩展，不要在第一阶段提前平台化

## 6. 自检结果

### 6.1 规格覆盖

- 员工门户：Task 8、Task 12
- 审批中心：Task 6、Task 13
- 服务台作业台：Task 7、Task 13
- 管理后台：Task 3、Task 11、Task 14
- 知识与搜索：Task 9
- SLA 与审计：Task 10、Task 11
- 部署与交付：Task 1、Task 15

### 6.2 占位检查

- 本计划未使用 TBD、TODO、后续补充等占位描述
- 每个任务都给出了明确文件路径、执行顺序与验证命令

### 6.3 一致性检查

- 工单状态命名统一使用 `DRAFT`、`PENDING_APPROVAL`、`PENDING_ASSIGN`、`PENDING_ACCEPT`、`IN_PROGRESS`、`PENDING_CONFIRM`、`CLOSED`、`CANCELLED`
- 高敏识别规则统一为“核心系统或高风险权限”
- 前后端接口路径与设计文档一致，均基于 `/api/portal`、`/api/approvals`、`/api/service-desk`、`/api/admin`
