package com.company.itsm.identity.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "system_resource")
public class SystemResourceEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "code", nullable = false, length = 64)
    private String code;

    @Column(name = "name", nullable = false, length = 128)
    private String name;

    @Column(name = "owner_user_id")
    private Long ownerUserId;

    @Column(name = "sensitivity_level", nullable = false, length = 32)
    private String sensitivityLevel;

    @Column(name = "service_group_id")
    private Long serviceGroupId;

    @Column(name = "status", nullable = false, length = 32)
    private String status;
}
