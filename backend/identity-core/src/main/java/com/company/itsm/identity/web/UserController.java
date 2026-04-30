package com.company.itsm.identity.web;

import com.company.itsm.common.api.ApiResponse;
import com.company.itsm.common.api.PageResponse;
import com.company.itsm.identity.dto.UserSummary;
import com.company.itsm.identity.service.UserService;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/admin/users")
public class UserController {

    private final UserService userService;

    public UserController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping
    public ApiResponse<PageResponse<UserSummary>> listUsers() {
        return ApiResponse.success(userService.listUsers());
    }
}
