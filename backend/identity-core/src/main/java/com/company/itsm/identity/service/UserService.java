package com.company.itsm.identity.service;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.identity.dto.UserSummary;

public interface UserService {

    PageResponse<UserSummary> listUsers();
}
