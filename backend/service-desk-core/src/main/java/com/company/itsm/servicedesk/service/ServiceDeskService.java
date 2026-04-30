package com.company.itsm.servicedesk.service;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.servicedesk.dto.QueueTicketSummary;

public interface ServiceDeskService {

    PageResponse<QueueTicketSummary> listQueueTickets();
}
