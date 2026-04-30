package com.company.itsm.ticket.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import java.time.LocalDateTime;

@Entity
@Table(name = "ticket")
public class TicketEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "ticket_no", nullable = false, length = 64)
    private String ticketNo;

    @Column(name = "applicant_id", nullable = false)
    private Long applicantId;

    @Column(name = "department_id", nullable = false)
    private Long departmentId;

    @Column(name = "category", nullable = false, length = 64)
    private String category;

    @Column(name = "request_type", nullable = false, length = 64)
    private String requestType;

    @Column(name = "target_system_id", nullable = false)
    private Long targetSystemId;

    @Column(name = "permission_item_id", nullable = false)
    private Long permissionItemId;

    @Column(name = "title", nullable = false, length = 255)
    private String title;

    @Column(name = "priority", nullable = false, length = 16)
    private String priority;

    @Column(name = "current_status", nullable = false, length = 32)
    private String currentStatus;

    @Column(name = "current_handler_id")
    private Long currentHandlerId;

    @Column(name = "current_group_id")
    private Long currentGroupId;

    @Column(name = "approval_flow_id")
    private Long approvalFlowId;

    @Column(name = "submitted_at")
    private LocalDateTime submittedAt;

    @Column(name = "closed_at")
    private LocalDateTime closedAt;
}
