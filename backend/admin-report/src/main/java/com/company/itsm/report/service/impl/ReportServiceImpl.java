package com.company.itsm.report.service.impl;

import com.company.itsm.report.dto.OverviewReport;
import com.company.itsm.report.service.ReportService;
import org.springframework.stereotype.Service;

@Service
public class ReportServiceImpl implements ReportService {

    @Override
    public OverviewReport loadOverview() {
        return new OverviewReport(0, 0, 0);
    }
}
