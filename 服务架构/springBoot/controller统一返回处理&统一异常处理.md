# Controller统一返回处理&统一异常处理

## 统一返回处理

### 背景

* 在项目开发中，为了使得前后端对接时的接口返回值类型定义更加规范，我们通常可以采取统一返回值类型的处理
* 主要思想是，定义一个规范的返回值类型，在调用后端Controller层方法后，将原Controller方法的返回值统一包装成已定义好的指定类型
  
### 代码实现
1. 定义返回值统一格式的Bean
~~~java

/**
 * ResponseResultBean
 * 统一返回值
 * @param <T>
 */
public class ResponseResultBean<T> {

    public static int SUCCESS_CODE = 200;

    public static String SUCCESS_CODE_MSG = "success";

    public static int ERROR_CODE = 500;

    public static String ERROR_CODE_MSG = "error";

    /**
     * 返回码
     */
    int code;

    /**
     * 返回码描述
     */
    String code_msg;

    /**
     * 业务信息
     */
    String msg;

    /**
     * 数据
     */
    T data;

    public static <T> ResponseResultBean<T>  success(T  data){
        return success(SUCCESS_CODE_MSG, data);
    }

    public static <T>  ResponseResultBean<T>  success(String msg, T  data){
        return new ResponseResultBean<> (SUCCESS_CODE, SUCCESS_CODE_MSG, msg, data);
    }

    public static <T> ResponseResultBean<T> error(){
        return error(ERROR_CODE_MSG);
    }

    public static <T>  ResponseResultBean<T>  error(String msg){
        return new ResponseResultBean<T> (ERROR_CODE, ERROR_CODE_MSG, msg,null);
    }

    public ResponseResultBean(int code, String code_msg, String msg, T  data) {
        this.code = code;
        this.code_msg = code_msg;
        this.msg = msg;
        this.data = data;
    }

    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public String getCode_msg() {
        return code_msg;
    }

    public void setCode_msg(String code_msg) {
        this.code_msg = code_msg;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public T getData() {
        return data;
    }

    public void setData(T  data) {
        this.data = data;
    }
}

~~~

2. 定义注解
~~~java

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * 目标：支持方法和类
 */
@Target({ElementType.METHOD,ElementType.TYPE})
@Retention(RetentionPolicy.RUNTIME)
public @interface ResponseResult {
}

~~~

1. 定义注解的解析处理程序

~~~java 

import org.joddon.abandon.common.utils.controller.annotation.ResponseResult;
import org.joddon.abandon.common.utils.controller.bean.ResponseResultBean;
import org.springframework.core.MethodParameter;
import org.springframework.http.MediaType;
import org.springframework.http.converter.HttpMessageConverter;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.servlet.mvc.method.annotation.ResponseBodyAdvice;

/**
 *
 */
@ControllerAdvice
public class ResponseResultAdvice implements ResponseBodyAdvice<Object> {

    /**
     * 支持
     * @param returnType
     * @param converterType
     * @return
     */
    @Override
    public boolean supports(MethodParameter returnType, Class<? extends HttpMessageConverter<?>> converterType) {
        // 方法上有ResponseResult注解或者类上有注解
        return returnType.getMethod().getDeclaringClass().getAnnotation(ResponseResult.class) != null
                || returnType.getMethodAnnotation(ResponseResult.class) != null;
    }

    @Override
    public Object beforeBodyWrite(Object body, MethodParameter returnType, MediaType selectedContentType, Class<? extends HttpMessageConverter<?>> selectedConverterType, ServerHttpRequest request, ServerHttpResponse response) {
        // 如果返回值已经是ResponseResultBean类型了，就直接返回
        if(body instanceof ResponseResultBean){
            return body;
        }else {
            // 直接包装
            ResponseResultBean<Object> success = ResponseResultBean.success(body);
            return success;
        }
    }
}


~~~

4. 在controller层类和方法使用该注解
~~~java 
package com.joddon.abandon.mybatisdemo.controller;

import com.joddon.abandon.mybatisdemo.service.TestService;
import org.joddon.abandon.common.utils.controller.annotation.ResponseResult;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/test")
@ResponseResult
public class TestController {


    @Autowired
    TestService testService;

    @RequestMapping("/getData")
    @ResponseResult
    public List<Map> getData() {
        List<Map> data = testService.getData();
        return data;
    }

    @RequestMapping("/getData2")
    public List<Map> getData2() {
        List<Map> data = testService.getData();
        return data;
    }
}

~~~