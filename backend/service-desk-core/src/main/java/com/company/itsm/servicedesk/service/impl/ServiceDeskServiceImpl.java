package com.company.itsm.servicedesk.service.impl;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.servicedesk.dto.QueueTicketSummary;
import com.company.itsm.servicedesk.service.ServiceDeskService;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class ServiceDeskServiceImpl implements ServiceDeskService {

    @Override
    public PageResponse<QueueTicketSummary> listQueueTickets() {
        return new PageResponse<>(List.of(), 0);
    }
}
