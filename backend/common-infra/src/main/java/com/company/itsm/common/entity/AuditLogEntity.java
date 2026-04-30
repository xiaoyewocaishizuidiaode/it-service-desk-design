package com.company.itsm.common.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "audit_log")
public class AuditLogEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "biz_type", nullable = false, length = 64)
    private String bizType;

    @Column(name = "biz_id", nullable = false)
    private Long bizId;

    @Column(name = "operator_id")
    private Long operatorId;

    @Column(name = "operator_role", length = 64)
    private String operatorRole;

    @Column(name = "action_type", nullable = false, length = 64)
    private String actionType;

    @Column(name = "action_desc", length = 1000)
    private String actionDesc;

    @Column(name = "before_snapshot", columnDefinition = "json")
    private String beforeSnapshot;

    @Column(name = "after_snapshot", columnDefinition = "json")
    private String afterSnapshot;

    @Column(name = "created_at", nullable = false)
    private java.time.LocalDateTime createdAt;
}
