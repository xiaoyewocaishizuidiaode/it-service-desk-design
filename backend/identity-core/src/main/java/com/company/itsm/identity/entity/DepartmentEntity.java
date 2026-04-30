package com.company.itsm.identity.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "department")
public class DepartmentEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "name", nullable = false, length = 128)
    private String name;

    @Column(name = "parent_id")
    private Long parentId;

    @Column(name = "manager_id")
    private Long managerId;

    @Column(name = "external_ref", length = 128)
    private String externalRef;

    @Column(name = "status", nullable = false, length = 32)
    private String status;
}
