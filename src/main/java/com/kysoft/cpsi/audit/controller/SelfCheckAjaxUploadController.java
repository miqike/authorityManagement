/**
 * Copyright (c) 2005-2012 https://github.com/zhangkaitao
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 */
package com.kysoft.cpsi.audit.controller;

import java.io.*;
import java.net.URLDecoder;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.collections.map.HashedMap;
import org.apache.commons.io.IOUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kysoft.cpsi.audit.service.SelfCheckService;

import net.sf.husky.attachment.utils.FileUploadUtils;
import net.sf.husky.exception.ExceptionUtils;
import net.sf.husky.log.MongoLogger;
import net.sf.husky.log.service.LogService;
import net.sf.husky.utils.HuskyConstants;

@Controller
public class SelfCheckAjaxUploadController {

    @Resource
    SelfCheckService selfCheckService;

    @Resource
    LogService logService;
    //最大上传大小 字节为单位
//    private long maxSize = FileUploadUtils.DEFAULT_MAX_SIZE;
    //允许的文件内容类型
//    private String[] allowedExtension = FileUploadUtils.DEFAULT_ALLOWED_EXTENSION;

    /**
     * @param request
     * @param files
     * @return
     */
    @RequestMapping(value = "selfCheckUpload", method = RequestMethod.POST)
    @ResponseBody
    public Map<String,Object> ajaxUpload(HttpServletRequest request, HttpServletResponse response, String owner, String col, String ownerKey,
                                         String hcrwId,String hcclName,String hcsxmc) {

        Map<String,Object> result=new HashedMap();

        InputStream is = null;

        String filename = request.getHeader("X-File-Name");
        try {
            is = request.getInputStream();
            String mongoId=null;

            Map<String,Object> dxn=selfCheckService.getDXNHccl();
            if(hcclName.equals(dxn.get("NAME").toString()) && hcsxmc.equals(dxn.get("HCSXMC").toString())) {
                ByteArrayOutputStream baos = new ByteArrayOutputStream();

                byte[] buffer = new byte[1024];
                int len;
                while ((len = is.read(buffer)) > -1) {
                    baos.write(buffer, 0, len);
                }
                baos.flush();

                // 打开一个新的输入流
                InputStream is1 = new ByteArrayInputStream(baos.toByteArray());
                InputStream is2 = new ByteArrayInputStream(baos.toByteArray());

                //处理文件内容
                selfCheckService.uploadSelfCheckData(is2, hcrwId, filename);

                //将文件保存到MONGODB中
                mongoId = FileUploadUtils.mongoUpload(is1, filename, owner, ownerKey);
            }else{
                mongoId = FileUploadUtils.mongoUpload(is, filename, owner, ownerKey);
            }

            FileUploadUtils.updateOwner(owner, col, ownerKey, mongoId);

            response.setStatus(HttpServletResponse.SC_OK);
            result.put("status",1);
            result.put("mongoId",mongoId);
            result.put("message","文件保存成功");

        }catch (Exception ex) {
            response.setStatus(HttpServletResponse.SC_OK);
            ex.printStackTrace();
            result.put("status",-1);
            result.put("mongoId","");
            result.put("message", ex.getMessage());
            MongoLogger.warn("企业自查表数据上传",ExceptionUtils.getStackTrace(ex),hcrwId);
        } finally {
            try {
                is.close();
            } catch (IOException ignored) {
            }
        }
        return result;
    }

    @RequestMapping(value = "selfCheckUpload/delete", method = RequestMethod.POST)
    @ResponseBody
    public String ajaxUploadDelete(
            HttpServletRequest request,
            @RequestParam(value = "filename") String filename) throws Exception {

        if (StringUtils.isEmpty(filename) || filename.contains("\\.\\.")) {
            return HuskyConstants.BLANK;
        }
        filename = URLDecoder.decode(filename, HuskyConstants.ENCODING_UTF8);

        String filePath = FileUploadUtils.extractUploadDir(request) + "/" + filename;

        File file = new File(filePath);
        file.deleteOnExit();

        return HuskyConstants.BLANK;
    }

    public enum State {
        OK(200, "上传成功"),
        ERROR(500, "上传失败"),
        OVER_FILE_LIMIT(501, "超过上传大小限制"),
        NO_SUPPORT_EXTENSION(502, "不支持的扩展名");

        private int code;
        private String message;
        private State(int code, String message) {
            this.code = code;
            this.message = message;
        }

        public int getCode() {
            return code;
        }
        public String getMessage() {
            return message;
        }

    }

    /**
     * 返回结果函数
     * @param response
     * @param state
     */
    @SuppressWarnings("unused")
    private void responseMessage(HttpServletResponse response, State state) {
        response.setCharacterEncoding(HuskyConstants.ENCODING_UTF8);
        response.setContentType("text/html; charset=UTF-8");
        Writer writer = null;
        try {
            writer = response.getWriter();
            writer.write("{\"code\":" + state.getCode() +",\"message\":\"" + state.getMessage()+ "\"}");
            writer.flush();
            writer.close();
        } catch(Exception e) {
        } finally {
            IOUtils.closeQuietly(writer);
        }
    }
}
