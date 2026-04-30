package com.company.itsm.approval.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "approval_node")
public class ApprovalNodeEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "flow_id", nullable = false)
    private Long flowId;

    @Column(name = "node_order", nullable = false)
    private Integer nodeOrder;

    @Column(name = "approver_id")
    private Long approverId;

    @Column(name = "approver_role", length = 64)
    private String approverRole;

    @Column(name = "action", length = 32)
    private String action;

    @Column(name = "comment", length = 500)
    private String comment;

    @Column(name = "action_at")
    private LocalDateTime actionAt;
}
