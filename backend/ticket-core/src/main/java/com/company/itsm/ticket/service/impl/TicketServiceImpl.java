package com.company.itsm.ticket.service.impl;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.ticket.dto.TicketSummary;
import com.company.itsm.ticket.service.TicketService;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class TicketServiceImpl implements TicketService {

    @Override
    public PageResponse<TicketSummary> listTickets() {
        return new PageResponse<>(List.of(), 0);
    }
}
