package com.axisj.axboot.admin.controllers;

import com.axisj.axboot.core.api.ApiException;
import com.axisj.axboot.core.api.response.ApiResponse;
import com.axisj.axboot.core.code.ApiStatus;
import org.hibernate.HibernateException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.TypeMismatchException;
import org.springframework.http.HttpStatus;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.transaction.TransactionException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.mvc.multiaction.NoSuchRequestHandlingMethodException;

import java.sql.SQLException;

public class BaseController extends WebMvcConfigurerAdapter{

    protected static final String APPLICATION_JSON = "application/json";

    protected static final String TEXT_PLAIN = "text/plain";

    private static final Logger logger = LoggerFactory.getLogger(BaseController.class);
    
    protected final Logger log = LoggerFactory.getLogger(getClass());

    public ApiResponse ok() {
        return ApiResponse.of(ApiStatus.SUCCESS, "SUCCESS");
    }

    @ResponseStatus(HttpStatus.METHOD_NOT_ALLOWED)
    public ApiResponse handleNotSupportes(Exception e) {
        errorLogging(e);
        return ApiResponse.error(ApiStatus.METHOD_NOT_ALLOWED, "method not allowed");
    }

    @ExceptionHandler(AccessDeniedException.class)
    public ApiResponse handleForbidden(Exception e) {
        errorLogging(e);
        return ApiResponse.error(ApiStatus.FORBIDDEN, e.getMessage());
    }

    @ExceptionHandler(NoSuchRequestHandlingMethodException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    //@ResponseStatus 통해서 사용자가 지정한 responscode를 NOT_FOUND코드로 바꿔서 출력한다.
    public ApiResponse handleNotFoundException(Exception e) {
        errorLogging(e);
        return ApiResponse.error(ApiStatus.NOT_FOUND, "NOT_FOUND");
    }

    @ExceptionHandler(TypeMismatchException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiResponse handleBadRequestException(Exception e) {
        errorLogging(e);
        return ApiResponse.error(ApiStatus.BAD_REQUEST, "BAD_REQUEST");
    }

    @ExceptionHandler(MissingServletRequestParameterException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public ApiResponse handleRequestParameterException(MissingServletRequestParameterException e) {
        errorLogging(e);
        return ApiResponse.error(ApiStatus.BAD_REQUEST, e.getMessage());
    }

    @ExceptionHandler(ApiException.class)
    //@controller, @restController가 적영된 Bean 내에서 발생하는 
    //에외를 잡아서 하나의 메소드에서 처리햐주는 기능을 한다. APiExcetion 클래스를 캐치하겠다는 의미(예외클래스 등록)
    public ApiResponse handleApiException(ApiException apiException) {
        errorLogging(apiException);
        return ApiResponse.error(ApiStatus.getApiStatus(apiException.getCode()), apiException.getMessage());
    }

    @ExceptionHandler(SQLException.class)
    public ApiResponse handleException(SQLException sqlException) {
        errorLogging(sqlException);
        return ApiResponse.error(ApiStatus.SYSTEM_ERROR, sqlException.getMessage());
    }

    @ExceptionHandler(HibernateException.class)
    public ApiResponse handleException(HibernateException hibernateException) {
        errorLogging(hibernateException);
        return ApiResponse.error(ApiStatus.SYSTEM_ERROR, hibernateException.getMessage());
    }

    @ExceptionHandler(Throwable.class)
    public ApiResponse handleException(Throwable throwable) {
        errorLogging(throwable);
        if(throwable.getClass().getSuperclass() == TransactionException.class) {
            TransactionException transactionException = (TransactionException) throwable;
            return ApiResponse.error(ApiStatus.SYSTEM_ERROR, (transactionException.getRootCause().getMessage()));
        }

        return ApiResponse.error(ApiStatus.SYSTEM_ERROR, throwable.getMessage());
    }

    protected void errorLogging(Throwable throwable) {
        if (logger.isErrorEnabled()) {
            if (throwable.getMessage() != null) {
                logger.error(throwable.getMessage(), throwable);
            } else {
                logger.error("ERROR", throwable);
            }
        }
    }
    
    public String redirect(String url) {
		return "redirect:" + url;
	}
}
