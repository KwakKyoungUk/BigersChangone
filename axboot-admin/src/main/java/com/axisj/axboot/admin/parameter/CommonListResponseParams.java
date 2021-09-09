package com.axisj.axboot.admin.parameter;

import com.axisj.axboot.core.dto.PageableTO;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.wordnik.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.NonNull;
import lombok.RequiredArgsConstructor;

import java.util.List;
import java.util.Map;

public class CommonListResponseParams {

    @Data
    @NoArgsConstructor
    @RequiredArgsConstructor(staticName = "of")
    public static class ListResponse {

        @JsonProperty("list")
        @NonNull
        @ApiModelProperty(value  = "목록", required = true)
        List<?> list;

        @NonNull
        @ApiModelProperty(value = "페이징 정보", required = true)
        private PageableTO page = PageableTO.of(0, 0L, 0, 0);
    }

    @Data
    @NoArgsConstructor
    @RequiredArgsConstructor(staticName = "of")
    public static class MapResponse {

        @NonNull
        @ApiModelProperty(value  = "Map", required = true)
        @JsonProperty("map")
        private Map<String, Object> map;
    }

    @Data
    @NoArgsConstructor
    @RequiredArgsConstructor(staticName = "of")
    public static class FileResponse {

    	@NonNull
    	@ApiModelProperty(value  = "name", required = true)
    	@JsonProperty("name")
        private String name;
    	@NonNull
    	@ApiModelProperty(value  = "type", required = true)
    	@JsonProperty("type")
        private String type;
    	@NonNull
    	@ApiModelProperty(value  = "saveName", required = true)
    	@JsonProperty("saveName")
        private String saveName;
    	@NonNull
    	@ApiModelProperty(value  = "fileSize", required = true)
    	@JsonProperty("fileSize")
        private Long fileSize;
    	@NonNull
    	@ApiModelProperty(value  = "uploadedPath", required = true)
    	@JsonProperty("uploadedPath")
        private String uploadedPath;
    	@NonNull
    	@ApiModelProperty(value  = "thumbPath", required = true)
    	@JsonProperty("thumbPath")
        private String thumbPath;
    }
}
