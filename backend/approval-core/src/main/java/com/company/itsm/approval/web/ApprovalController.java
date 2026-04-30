package com.company.itsm.approval.web;

import com.company.itsm.approval.dto.ApprovalSummary;
import com.company.itsm.approval.service.ApprovalService;
import com.company.itsm.common.api.ApiResponse;
import com.company.itsm.common.api.PageResponse;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/approvals")
public class ApprovalController {

    private final ApprovalService approvalService;

    public ApprovalController(ApprovalService approvalService) {
        this.approvalService = approvalService;
    }

    @GetMapping("/pending")
    public ApiResponse<PageResponse<ApprovalSummary>> listPendingApprovals() {
        return ApiResponse.success(approvalService.listPendingApprovals());
    }
}
