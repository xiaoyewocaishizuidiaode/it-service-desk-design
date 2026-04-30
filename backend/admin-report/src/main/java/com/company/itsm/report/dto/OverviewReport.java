package com.company.itsm.report.dto;

public record OverviewReport(long openTickets, long pendingApprovals, long overdueTickets) {
}
