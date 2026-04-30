package com.company.itsm.knowledge.web;

import com.company.itsm.common.api.ApiResponse;
import com.company.itsm.common.api.PageResponse;
import com.company.itsm.knowledge.dto.KnowledgeArticleSummary;
import com.company.itsm.knowledge.service.KnowledgeService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/knowledge")
public class KnowledgeController {

    private final KnowledgeService knowledgeService;

    public KnowledgeController(KnowledgeService knowledgeService) {
        this.knowledgeService = knowledgeService;
    }

    @GetMapping
    public ApiResponse<PageResponse<KnowledgeArticleSummary>> listArticles() {
        return ApiResponse.success(knowledgeService.listArticles());
    }
}
