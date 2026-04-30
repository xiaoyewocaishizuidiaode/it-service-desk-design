package com.company.itsm.servicedesk.web;

import com.company.itsm.common.api.ApiResponse;
import com.company.itsm.common.api.PageResponse;
import com.company.itsm.servicedesk.dto.QueueTicketSummary;
import com.company.itsm.servicedesk.service.ServiceDeskService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/service-desk")
public class ServiceDeskController {

    private final ServiceDeskService serviceDeskService;

    public ServiceDeskController(ServiceDeskService serviceDeskService) {
        this.serviceDeskService = serviceDeskService;
    }

    @GetMapping("/queue")
    public ApiResponse<PageResponse<QueueTicketSummary>> listQueueTickets() {
        return ApiResponse.success(serviceDeskService.listQueueTickets());
    }
}
