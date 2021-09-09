package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.admin.parameter.PageableResponseParams;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.domain.sample.child.ChildSample;
import com.axisj.axboot.core.domain.sample.child.ChildSampleService;
import com.axisj.axboot.core.domain.sample.parent.ParentSample;
import com.axisj.axboot.core.domain.sample.parent.ParentSampleService;
import com.axisj.axboot.core.dto.PageableTO;
import com.axisj.axboot.core.util.DozerBeanMapperUtils;
import com.axisj.axboot.core.vto.ChildSampleVTO;
import com.axisj.axboot.core.vto.ParentSampleVTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import javax.inject.Inject;
import java.util.List;

@Controller
@RequestMapping(value = "/api/v1/samples")
public class SampleController extends BaseController {

    @Inject
    private ParentSampleService parentService;

    @Inject
    private ChildSampleService childService;

    @RequestMapping(value = "/parent", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public PageableResponseParams.PageResponse parentList(Pageable pageable) {
        Page<ParentSample> pages = parentService.findAll(pageable);
        return PageableResponseParams.PageResponse.of(ParentSampleVTO.of(pages.getContent()), PageableTO.of(pages));
    }

    @RequestMapping(value = "/parent", method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public ApiResponse parentSave(@RequestBody List<ParentSampleVTO> list) {
        List<ParentSample> parentSampleList = DozerBeanMapperUtils.mapList(list, ParentSample.class);
        parentService.save(parentSampleList);
        return ok();
    }

    @RequestMapping(value = "/parent", method = {RequestMethod.DELETE}, produces = APPLICATION_JSON)
    public ApiResponse parentDelete(@RequestParam(value = "key") List<String> keys) {
        parentService.deleteByKeys(keys);
        return ok();
    }

    @RequestMapping(value = "/child", method = RequestMethod.GET, produces = APPLICATION_JSON)
    public PageableResponseParams.PageResponse childList(@RequestParam(required = true, defaultValue = "") String parentKey, Pageable pageable) {
        Page<ChildSample> pages = childService.findByParentKeyWithPaging(parentKey, pageable);
        return PageableResponseParams.PageResponse.of(ChildSampleVTO.of(pages.getContent()), PageableTO.of(pages));
    }

    @RequestMapping(value = "/child", method = {RequestMethod.POST, RequestMethod.PUT}, produces = APPLICATION_JSON)
    public ApiResponse childSave(@RequestBody List<ChildSampleVTO> list) {
        List<ChildSample> childSampleList = DozerBeanMapperUtils.mapList(list, ChildSample.class);
        childService.save(childSampleList);
        return ok();
    }

    @RequestMapping(value = "/child", method = {RequestMethod.DELETE}, produces = APPLICATION_JSON)
    public ApiResponse childDelete(@RequestParam(value = "key") List<String> keys) {
        childService.deleteByKeys(keys);
        return ok();
    }
}
