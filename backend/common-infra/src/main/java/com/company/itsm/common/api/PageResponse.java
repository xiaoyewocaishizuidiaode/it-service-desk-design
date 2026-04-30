package com.company.itsm.common.api;

import java.util.List;

public record PageResponse<T>(List<T> records, long total) {
}
