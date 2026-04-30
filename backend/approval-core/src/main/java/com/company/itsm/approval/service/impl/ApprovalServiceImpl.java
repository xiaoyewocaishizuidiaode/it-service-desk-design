package com.company.itsm.approval.service.impl;

import com.company.itsm.approval.dto.ApprovalSummary;
import com.company.itsm.approval.service.ApprovalService;
import com.company.itsm.common.api.PageResponse;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class ApprovalServiceImpl implements ApprovalService {

    @Override
    public PageResponse<ApprovalSummary> listPendingApprovals() {
        return new PageResponse<>(List.of(), 0);
    }
}
