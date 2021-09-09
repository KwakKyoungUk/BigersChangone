package com.axisj.axboot.admin.parameter;

import com.axisj.axboot.core.dto.PageableTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.wordnik.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

import java.util.List;

public class PageableResponseParams {

    @Data
    @NoArgsConstructor
    @RequiredArgsConstructor(staticName = "of")
    public static class PageResponse {
        @NonNull
        @ApiModelProperty(value  = "목록", required = true)
        @JsonProperty("list")
        private List<?> list;

        @NonNull
        @ApiModelProperty(value = "페이징 정보", required = true)
        private PageableTO page;
    }
}
