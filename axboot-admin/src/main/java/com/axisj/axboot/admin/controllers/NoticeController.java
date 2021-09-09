package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.converter.BaseConverter;
import com.axisj.axboot.core.domain.notice.Notice;
import com.axisj.axboot.core.domain.notice.NoticeService;
import com.axisj.axboot.core.domain.notice.file.NoticeFile;
import com.axisj.axboot.core.domain.notice.file.NoticeFileService;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.vto.NoticeVTO;
import com.wordnik.swagger.annotations.Api;
import com.wordnik.swagger.annotations.ApiOperation;
import com.wordnik.swagger.annotations.ApiParam;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.inject.Inject;
import java.io.IOException;
import java.net.URLEncoder;


@Controller
@RequestMapping(value = "/api/v1/notices")
@Api(value = "Notice", description = "Notice API")
public class NoticeController extends BaseController {

    @Inject
    private NoticeService noticeService;

    @Inject
    private NoticeFileService noticeFileService;

    @Inject
    private BaseConverter baseConverter;

    @ApiOperation(value = "공지사항 목록", notes = "등록된 공지사항 목록을 모두 보여준다.")
    @RequestMapping(method = RequestMethod.GET, produces = APPLICATION_JSON)
    public PageableResponseParams.PageResponse list(Pageable pageable) {
        Page<Notice> notices = noticeService.findAllByOrderByInsDtDesc(pageable);
        return PageableResponseParams.PageResponse.of(NoticeVTO.of(notices.getContent()), PageableTO.of(notices));
    }

    @ApiOperation(value = "공지사항 정보", notes = "등록된 공지사항 정보를 보여준다.")
    @RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public NoticeVTO notice(@PathVariable("id") int noticeId) {
        Notice notice = noticeService.findOne(noticeId);
        return NoticeVTO.of(notice);
    }

    @ApiOperation(value = "공지사항 파일 업로드", notes = "공지사항 파일업로드 한다.")
    @RequestMapping(value = "/file", method = RequestMethod.POST, produces = APPLICATION_JSON)
    public ApiResponse fileUpload(
            @ApiParam(value = "공지사항 ID", required = false, defaultValue = "0") @RequestParam(required = true, defaultValue = "0") int noticeId,
            @RequestParam(required = false) MultipartFile file1,
            @RequestParam(required = false) MultipartFile file2) throws IOException {

        noticeFileService.saveFiles(noticeId, file1, file2);

        return ok();
    }

    @ApiOperation(value = "공지사항 파일 삭제", notes = "공지사항 파일업로드 삭제")
    @RequestMapping(value = "/file/{id}", method = RequestMethod.DELETE, produces = APPLICATION_JSON)
    public ApiResponse fileUpload(@PathVariable("id") int fileId) {
        noticeFileService.delete(fileId);
        return ok();
    }

    @ApiOperation(value = "공지사항 파일 다운로드", notes = "공지사항 파일을 다운로드 한다.")
    @RequestMapping(value = "/file/{id}", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public ResponseEntity<byte[]> fileDownload(@PathVariable("id") int noticeFileId) throws IOException {

        NoticeFile noticeFile = noticeFileService.findOne(noticeFileId);

        String encodedFileName = URLEncoder.encode(noticeFile.getFileName(), "UTF-8").replace("+", "%20");

        HttpHeaders respHeaders = new HttpHeaders();
        respHeaders.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        respHeaders.setContentLength(noticeFile.getFileBlob().length);
        respHeaders.set("Content-Disposition", "attachment;filename=\"" + encodedFileName + "\";");
        respHeaders.set("Content-Transfer-Encoding", "binary");

        return new ResponseEntity<>(noticeFile.getFileBlob(), respHeaders, HttpStatus.OK);
    }

    @ApiOperation(value = "공지사항 등록/수정", notes = "공지사항 등록/수정 한다.")
    @RequestMapping(value = "/", method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public Notice save(@RequestBody NoticeVTO request) {
        Notice notice = baseConverter.convert(request, Notice.class);
        noticeService.saveNotice(notice);
        return notice;
    }
}
