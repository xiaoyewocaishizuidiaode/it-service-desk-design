package com.company.itsm.knowledge.service.impl;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.knowledge.dto.KnowledgeArticleSummary;
import com.company.itsm.knowledge.service.KnowledgeService;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class KnowledgeServiceImpl implements KnowledgeService {

    @Override
    public PageResponse<KnowledgeArticleSummary> listArticles() {
        return new PageResponse<>(List.of(), 0);
    }
}
