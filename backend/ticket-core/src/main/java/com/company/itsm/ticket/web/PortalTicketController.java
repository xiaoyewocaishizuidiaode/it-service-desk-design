package com.company.itsm.ticket.web;

import com.company.itsm.common.api.ApiResponse;
import com.company.itsm.common.api.PageResponse;
import com.company.itsm.ticket.dto.TicketSummary;
import com.company.itsm.ticket.service.TicketService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/portal/tickets")
public class PortalTicketController {

    private final TicketService ticketService;

    public PortalTicketController(TicketService ticketService) {
        this.ticketService = ticketService;
    }

    @GetMapping
    public ApiResponse<PageResponse<TicketSummary>> listTickets() {
        return ApiResponse.success(ticketService.listTickets());
    }
}
