package com.company.itsm.report.web;

import com.company.itsm.common.api.ApiResponse;
import com.company.itsm.report.dto.OverviewReport;
import com.company.itsm.report.service.ReportService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/reports")
public class ReportController {

    private final ReportService reportService;

    public ReportController(ReportService reportService) {
        this.reportService = reportService;
    }

    @GetMapping("/overview")
    public ApiResponse<OverviewReport> overview() {
        return ApiResponse.success(reportService.loadOverview());
    }
}
