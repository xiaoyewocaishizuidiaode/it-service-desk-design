package com.company.itsm.ticket.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "sla_policy")
public class SlaPolicyEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "priority", nullable = false, length = 16)
    private String priority;

    @Column(name = "response_minutes", nullable = false)
    private Integer responseMinutes;

    @Column(name = "resolve_minutes", nullable = false)
    private Integer resolveMinutes;

    @Column(name = "confirm_minutes", nullable = false)
    private Integer confirmMinutes;

    @Column(name = "status", nullable = false, length = 32)
    private String status;
}
