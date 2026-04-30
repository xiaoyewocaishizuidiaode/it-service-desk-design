package com.company.itsm.approval.service;

import com.company.itsm.approval.dto.ApprovalSummary;
import com.company.itsm.common.api.PageResponse;

public interface ApprovalService {

    PageResponse<ApprovalSummary> listPendingApprovals();
}
