package com.company.itsm.knowledge.entity;

import com.company.itsm.common.entity.BaseAuditEntity;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;

@Entity
@Table(name = "knowledge_article")
public class KnowledgeArticleEntity extends BaseAuditEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title", nullable = false, length = 255)
    private String title;

    @Column(name = "summary", length = 500)
    private String summary;

    @Column(name = "category", length = 64)
    private String category;

    @Column(name = "system_id")
    private Long systemId;

    @Column(name = "status", nullable = false, length = 32)
    private String status;

    @Column(name = "source_ticket_id")
    private Long sourceTicketId;

    @Column(name = "created_by")
    private Long createdBy;

    @Column(name = "updated_by")
    private Long updatedBy;
}
