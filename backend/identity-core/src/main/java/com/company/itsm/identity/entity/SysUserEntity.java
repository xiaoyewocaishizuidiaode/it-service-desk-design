package com.company.itsm.identity.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "sys_user")
public class SysUserEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "employee_no", nullable = false, length = 64)
    private String employeeNo;

    @Column(name = "name", nullable = false, length = 128)
    private String name;

    @Column(name = "email", length = 128)
    private String email;

    @Column(name = "mobile", length = 32)
    private String mobile;

    @Column(name = "department_id")
    private Long departmentId;

    @Column(name = "manager_id")
    private Long managerId;

    @Column(name = "status", nullable = false, length = 32)
    private String status;

    @Column(name = "source_type", nullable = false, length = 32)
    private String sourceType;

    @Column(name = "external_ref", length = 128)
    private String externalRef;
}
