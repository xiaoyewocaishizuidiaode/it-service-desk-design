package com.company.itsm.ticket.service;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.ticket.dto.TicketSummary;

public interface TicketService {

    PageResponse<TicketSummary> listTickets();
}
