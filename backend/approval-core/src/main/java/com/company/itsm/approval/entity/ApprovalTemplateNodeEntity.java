package com.company.itsm.approval.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "approval_template_node")
public class ApprovalTemplateNodeEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "template_id", nullable = false)
    private Long templateId;

    @Column(name = "node_order", nullable = false)
    private Integer nodeOrder;

    @Column(name = "approver_type", nullable = false, length = 32)
    private String approverType;

    @Column(name = "approver_ref", length = 128)
    private String approverRef;

    @Column(name = "required_flag", nullable = false)
    private Boolean requiredFlag;
}
