package com.company.itsm.identity.service.impl;

import com.company.itsm.common.api.PageResponse;
import com.company.itsm.identity.dto.UserSummary;
import com.company.itsm.identity.service.UserService;
import java.util.List;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {

    @Override
    public PageResponse<UserSummary> listUsers() {
        return new PageResponse<>(List.of(), 0);
    }
}
