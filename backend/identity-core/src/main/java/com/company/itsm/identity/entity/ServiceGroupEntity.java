package com.company.itsm.identity.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "service_group")
public class ServiceGroupEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "group_code", nullable = false, length = 64)
    private String groupCode;

    @Column(name = "group_name", nullable = false, length = 128)
    private String groupName;

    @Column(name = "leader_user_id")
    private Long leaderUserId;

    @Column(name = "status", nullable = false, length = 32)
    private String status;
}
