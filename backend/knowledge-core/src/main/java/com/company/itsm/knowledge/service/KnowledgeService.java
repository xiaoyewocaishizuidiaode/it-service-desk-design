package com.company.itsm.knowledge.service;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.knowledge.dto.KnowledgeArticleSummary;

public interface KnowledgeService {

    PageResponse<KnowledgeArticleSummary> listArticles();
}
