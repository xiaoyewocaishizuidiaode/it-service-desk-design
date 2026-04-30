CREATE DATABASE IF NOT EXISTS `itsm`
  DEFAULT CHARACTER SET utf8mb4
  DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE `itsm`;

CREATE TABLE IF NOT EXISTS `department` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(128) NOT NULL COMMENT '部门名称',
  `parent_id` BIGINT DEFAULT NULL COMMENT '上级部门ID',
  `manager_id` BIGINT DEFAULT NULL COMMENT '部门负责人用户ID',
  `external_ref` VARCHAR(128) DEFAULT NULL COMMENT '外部系统引用标识',
  `status` VARCHAR(32) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_department_parent_id` (`parent_id`),
  KEY `idx_department_manager_id` (`manager_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='部门表';

CREATE TABLE IF NOT EXISTS `service_group` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `group_code` VARCHAR(64) NOT NULL COMMENT '处理组编码',
  `group_name` VARCHAR(128) NOT NULL COMMENT '处理组名称',
  `leader_user_id` BIGINT DEFAULT NULL COMMENT '组长用户ID',
  `status` VARCHAR(32) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_service_group_code` (`group_code`),
  KEY `idx_service_group_leader_user_id` (`leader_user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='服务台处理组表';

CREATE TABLE IF NOT EXISTS `sys_user` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `employee_no` VARCHAR(64) NOT NULL COMMENT '员工编号',
  `name` VARCHAR(128) NOT NULL COMMENT '姓名',
  `email` VARCHAR(128) DEFAULT NULL COMMENT '邮箱',
  `mobile` VARCHAR(32) DEFAULT NULL COMMENT '手机号',
  `department_id` BIGINT DEFAULT NULL COMMENT '所属部门ID',
  `manager_id` BIGINT DEFAULT NULL COMMENT '直属主管用户ID',
  `status` VARCHAR(32) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `source_type` VARCHAR(32) NOT NULL DEFAULT 'LOCAL' COMMENT '用户来源类型',
  `external_ref` VARCHAR(128) DEFAULT NULL COMMENT '外部系统引用标识',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sys_user_employee_no` (`employee_no`),
  UNIQUE KEY `uk_sys_user_email` (`email`),
  KEY `idx_sys_user_department_id` (`department_id`),
  KEY `idx_sys_user_manager_id` (`manager_id`),
  CONSTRAINT `fk_sys_user_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `fk_sys_user_manager` FOREIGN KEY (`manager_id`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='系统用户表';

ALTER TABLE `department`
  ADD CONSTRAINT `fk_department_manager`
  FOREIGN KEY (`manager_id`) REFERENCES `sys_user` (`id`);

ALTER TABLE `service_group`
  ADD CONSTRAINT `fk_service_group_leader`
  FOREIGN KEY (`leader_user_id`) REFERENCES `sys_user` (`id`);

CREATE TABLE IF NOT EXISTS `system_resource` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `code` VARCHAR(64) NOT NULL COMMENT '系统编码',
  `name` VARCHAR(128) NOT NULL COMMENT '系统名称',
  `owner_user_id` BIGINT DEFAULT NULL COMMENT '系统负责人用户ID',
  `sensitivity_level` VARCHAR(32) NOT NULL COMMENT '系统敏感级别',
  `service_group_id` BIGINT DEFAULT NULL COMMENT '归属处理组ID',
  `status` VARCHAR(32) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_system_resource_code` (`code`),
  KEY `idx_system_resource_owner_user_id` (`owner_user_id`),
  KEY `idx_system_resource_service_group_id` (`service_group_id`),
  CONSTRAINT `fk_system_resource_owner_user` FOREIGN KEY (`owner_user_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `fk_system_resource_service_group` FOREIGN KEY (`service_group_id`) REFERENCES `service_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='目标系统资源表';

CREATE TABLE IF NOT EXISTS `permission_item` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `system_id` BIGINT NOT NULL COMMENT '所属系统ID',
  `code` VARCHAR(64) NOT NULL COMMENT '权限项编码',
  `name` VARCHAR(128) NOT NULL COMMENT '权限项名称',
  `permission_level` VARCHAR(32) NOT NULL COMMENT '权限级别',
  `risk_level` VARCHAR(32) NOT NULL COMMENT '风险级别',
  `status` VARCHAR(32) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_permission_item_system_code` (`system_id`, `code`),
  KEY `idx_permission_item_risk_level` (`risk_level`),
  CONSTRAINT `fk_permission_item_system` FOREIGN KEY (`system_id`) REFERENCES `system_resource` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='权限项表';

CREATE TABLE IF NOT EXISTS `approval_template` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `name` VARCHAR(128) NOT NULL COMMENT '模板名称',
  `system_sensitivity` VARCHAR(32) NOT NULL COMMENT '匹配的系统敏感级别',
  `permission_risk_level` VARCHAR(32) NOT NULL COMMENT '匹配的权限风险级别',
  `status` VARCHAR(32) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_approval_template_match` (`system_sensitivity`, `permission_risk_level`, `status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='审批模板表';

CREATE TABLE IF NOT EXISTS `approval_template_node` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `template_id` BIGINT NOT NULL COMMENT '审批模板ID',
  `node_order` INT NOT NULL COMMENT '节点顺序',
  `approver_type` VARCHAR(32) NOT NULL COMMENT '审批人类型',
  `approver_ref` VARCHAR(128) DEFAULT NULL COMMENT '审批人引用值',
  `required_flag` TINYINT(1) NOT NULL DEFAULT 1 COMMENT '是否必经节点',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_approval_template_node_order` (`template_id`, `node_order`),
  CONSTRAINT `fk_approval_template_node_template` FOREIGN KEY (`template_id`) REFERENCES `approval_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='审批模板节点表';

CREATE TABLE IF NOT EXISTS `ticket` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ticket_no` VARCHAR(64) NOT NULL COMMENT '工单编号',
  `applicant_id` BIGINT NOT NULL COMMENT '申请人用户ID',
  `department_id` BIGINT NOT NULL COMMENT '申请人部门ID',
  `category` VARCHAR(64) NOT NULL COMMENT '工单分类',
  `request_type` VARCHAR(64) NOT NULL COMMENT '请求类型',
  `target_system_id` BIGINT NOT NULL COMMENT '目标系统ID',
  `permission_item_id` BIGINT NOT NULL COMMENT '目标权限项ID',
  `title` VARCHAR(255) NOT NULL COMMENT '工单标题',
  `priority` VARCHAR(16) NOT NULL COMMENT '优先级',
  `current_status` VARCHAR(32) NOT NULL COMMENT '当前状态',
  `current_handler_id` BIGINT DEFAULT NULL COMMENT '当前处理人用户ID',
  `current_group_id` BIGINT DEFAULT NULL COMMENT '当前处理组ID',
  `approval_flow_id` BIGINT DEFAULT NULL COMMENT '审批流实例ID',
  `submitted_at` DATETIME DEFAULT NULL COMMENT '提交时间',
  `closed_at` DATETIME DEFAULT NULL COMMENT '关闭时间',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_ticket_ticket_no` (`ticket_no`),
  KEY `idx_ticket_applicant_id` (`applicant_id`),
  KEY `idx_ticket_department_id` (`department_id`),
  KEY `idx_ticket_target_system_id` (`target_system_id`),
  KEY `idx_ticket_permission_item_id` (`permission_item_id`),
  KEY `idx_ticket_status_priority` (`current_status`, `priority`),
  KEY `idx_ticket_current_handler_id` (`current_handler_id`),
  KEY `idx_ticket_current_group_id` (`current_group_id`),
  CONSTRAINT `fk_ticket_applicant` FOREIGN KEY (`applicant_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `fk_ticket_department` FOREIGN KEY (`department_id`) REFERENCES `department` (`id`),
  CONSTRAINT `fk_ticket_system` FOREIGN KEY (`target_system_id`) REFERENCES `system_resource` (`id`),
  CONSTRAINT `fk_ticket_permission_item` FOREIGN KEY (`permission_item_id`) REFERENCES `permission_item` (`id`),
  CONSTRAINT `fk_ticket_current_handler` FOREIGN KEY (`current_handler_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `fk_ticket_current_group` FOREIGN KEY (`current_group_id`) REFERENCES `service_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工单主表';

CREATE TABLE IF NOT EXISTS `approval_flow` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ticket_id` BIGINT NOT NULL COMMENT '工单ID',
  `template_id` BIGINT NOT NULL COMMENT '审批模板ID',
  `current_node_order` INT DEFAULT NULL COMMENT '当前审批节点顺序',
  `status` VARCHAR(32) NOT NULL COMMENT '审批流状态',
  `started_at` DATETIME DEFAULT NULL COMMENT '开始时间',
  `finished_at` DATETIME DEFAULT NULL COMMENT '结束时间',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_approval_flow_ticket_id` (`ticket_id`),
  KEY `idx_approval_flow_template_id` (`template_id`),
  CONSTRAINT `fk_approval_flow_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `fk_approval_flow_template` FOREIGN KEY (`template_id`) REFERENCES `approval_template` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工单审批流实例表';

ALTER TABLE `ticket`
  ADD CONSTRAINT `fk_ticket_approval_flow`
  FOREIGN KEY (`approval_flow_id`) REFERENCES `approval_flow` (`id`);

CREATE TABLE IF NOT EXISTS `approval_node` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `flow_id` BIGINT NOT NULL COMMENT '审批流ID',
  `node_order` INT NOT NULL COMMENT '节点顺序',
  `approver_id` BIGINT DEFAULT NULL COMMENT '审批人用户ID',
  `approver_role` VARCHAR(64) DEFAULT NULL COMMENT '审批人角色',
  `action` VARCHAR(32) DEFAULT NULL COMMENT '审批动作',
  `comment` VARCHAR(500) DEFAULT NULL COMMENT '审批意见',
  `action_at` DATETIME DEFAULT NULL COMMENT '审批时间',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_approval_node_flow_order` (`flow_id`, `node_order`),
  KEY `idx_approval_node_approver_id` (`approver_id`),
  CONSTRAINT `fk_approval_node_flow` FOREIGN KEY (`flow_id`) REFERENCES `approval_flow` (`id`),
  CONSTRAINT `fk_approval_node_approver` FOREIGN KEY (`approver_id`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工单审批节点表';

CREATE TABLE IF NOT EXISTS `assignment_record` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ticket_id` BIGINT NOT NULL COMMENT '工单ID',
  `action_type` VARCHAR(32) NOT NULL COMMENT '分派动作类型',
  `from_user_id` BIGINT DEFAULT NULL COMMENT '原处理人用户ID',
  `to_user_id` BIGINT DEFAULT NULL COMMENT '目标处理人用户ID',
  `from_group_id` BIGINT DEFAULT NULL COMMENT '原处理组ID',
  `to_group_id` BIGINT DEFAULT NULL COMMENT '目标处理组ID',
  `reason` VARCHAR(500) DEFAULT NULL COMMENT '操作原因',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_assignment_record_ticket_id` (`ticket_id`),
  KEY `idx_assignment_record_to_user_id` (`to_user_id`),
  CONSTRAINT `fk_assignment_record_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `fk_assignment_record_from_user` FOREIGN KEY (`from_user_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `fk_assignment_record_to_user` FOREIGN KEY (`to_user_id`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `fk_assignment_record_from_group` FOREIGN KEY (`from_group_id`) REFERENCES `service_group` (`id`),
  CONSTRAINT `fk_assignment_record_to_group` FOREIGN KEY (`to_group_id`) REFERENCES `service_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='工单分派记录表';

CREATE TABLE IF NOT EXISTS `sla_policy` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `priority` VARCHAR(16) NOT NULL COMMENT '优先级',
  `response_minutes` INT NOT NULL COMMENT '响应时限分钟数',
  `resolve_minutes` INT NOT NULL COMMENT '解决时限分钟数',
  `confirm_minutes` INT NOT NULL COMMENT '确认时限分钟数',
  `status` VARCHAR(32) NOT NULL DEFAULT 'ACTIVE' COMMENT '状态',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_sla_policy_priority` (`priority`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='SLA规则表';

CREATE TABLE IF NOT EXISTS `sla_task` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `ticket_id` BIGINT NOT NULL COMMENT '工单ID',
  `task_type` VARCHAR(32) NOT NULL COMMENT 'SLA任务类型',
  `deadline_at` DATETIME NOT NULL COMMENT '截止时间',
  `triggered_at` DATETIME DEFAULT NULL COMMENT '触发时间',
  `status` VARCHAR(32) NOT NULL COMMENT '任务状态',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_sla_task_ticket_id` (`ticket_id`),
  KEY `idx_sla_task_status_deadline` (`status`, `deadline_at`),
  CONSTRAINT `fk_sla_task_ticket` FOREIGN KEY (`ticket_id`) REFERENCES `ticket` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='SLA检查任务表';

CREATE TABLE IF NOT EXISTS `knowledge_article` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `title` VARCHAR(255) NOT NULL COMMENT '文章标题',
  `summary` VARCHAR(500) DEFAULT NULL COMMENT '文章摘要',
  `category` VARCHAR(64) DEFAULT NULL COMMENT '文章分类',
  `system_id` BIGINT DEFAULT NULL COMMENT '关联系统ID',
  `status` VARCHAR(32) NOT NULL DEFAULT 'DRAFT' COMMENT '文章状态',
  `source_ticket_id` BIGINT DEFAULT NULL COMMENT '来源工单ID',
  `created_by` BIGINT DEFAULT NULL COMMENT '创建人用户ID',
  `updated_by` BIGINT DEFAULT NULL COMMENT '更新人用户ID',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `updated_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  KEY `idx_knowledge_article_system_id` (`system_id`),
  KEY `idx_knowledge_article_source_ticket_id` (`source_ticket_id`),
  CONSTRAINT `fk_knowledge_article_system` FOREIGN KEY (`system_id`) REFERENCES `system_resource` (`id`),
  CONSTRAINT `fk_knowledge_article_source_ticket` FOREIGN KEY (`source_ticket_id`) REFERENCES `ticket` (`id`),
  CONSTRAINT `fk_knowledge_article_created_by` FOREIGN KEY (`created_by`) REFERENCES `sys_user` (`id`),
  CONSTRAINT `fk_knowledge_article_updated_by` FOREIGN KEY (`updated_by`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='知识库文章表';

CREATE TABLE IF NOT EXISTS `notification` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `receiver_id` BIGINT NOT NULL COMMENT '接收人用户ID',
  `biz_type` VARCHAR(64) NOT NULL COMMENT '业务类型',
  `biz_id` BIGINT NOT NULL COMMENT '业务ID',
  `title` VARCHAR(255) NOT NULL COMMENT '通知标题',
  `content` VARCHAR(1000) DEFAULT NULL COMMENT '通知内容',
  `read_flag` TINYINT(1) NOT NULL DEFAULT 0 COMMENT '是否已读',
  `sent_at` DATETIME DEFAULT NULL COMMENT '发送时间',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_notification_receiver_id` (`receiver_id`),
  KEY `idx_notification_biz` (`biz_type`, `biz_id`),
  CONSTRAINT `fk_notification_receiver` FOREIGN KEY (`receiver_id`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='通知消息表';

CREATE TABLE IF NOT EXISTS `audit_log` (
  `id` BIGINT NOT NULL AUTO_INCREMENT COMMENT '主键ID',
  `biz_type` VARCHAR(64) NOT NULL COMMENT '业务类型',
  `biz_id` BIGINT NOT NULL COMMENT '业务ID',
  `operator_id` BIGINT DEFAULT NULL COMMENT '操作人用户ID',
  `operator_role` VARCHAR(64) DEFAULT NULL COMMENT '操作人角色',
  `action_type` VARCHAR(64) NOT NULL COMMENT '动作类型',
  `action_desc` VARCHAR(1000) DEFAULT NULL COMMENT '动作描述',
  `before_snapshot` JSON DEFAULT NULL COMMENT '操作前快照',
  `after_snapshot` JSON DEFAULT NULL COMMENT '操作后快照',
  `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `idx_audit_log_biz` (`biz_type`, `biz_id`),
  KEY `idx_audit_log_operator_id` (`operator_id`),
  CONSTRAINT `fk_audit_log_operator` FOREIGN KEY (`operator_id`) REFERENCES `sys_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT='审计日志表';
