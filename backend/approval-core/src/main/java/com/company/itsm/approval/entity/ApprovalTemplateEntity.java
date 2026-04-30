package com.company.itsm.approval.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "approval_template")
public class ApprovalTemplateEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, length = 128)
    private String name;

    @Column(name = "system_sensitivity", nullable = false, length = 32)
    private String systemSensitivity;

    @Column(name = "permission_risk_level", nullable = false, length = 32)
    private String permissionRiskLevel;

    @Column(name = "status", nullable = false, length = 32)
    private String status;
}
