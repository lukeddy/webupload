package com.websupport.controller;

import com.websupport.util.AjaxObject;
import org.apache.commons.io.FileUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

/**
 * Created by Administrator on 2014/8/22.
 */
@Controller
public class HomeController {

    static Log logger = LogFactory.getLog(HomeController.class);


    @RequestMapping(value="/main")
    public String template(){
        return "dashboard";
    }

    @RequestMapping(value="/index")
    public String index(){
        return "index";
    }



    @RequestMapping(value="/doupload")
    @ResponseBody
    public AjaxObject  doUpload(MultipartFile myfile,HttpServletRequest request){
        AjaxObject ajaxObject=new AjaxObject();
        try {
            String uploadPath=WebUtils.getRealPath(request.getServletContext(),"upload");
            FileUtils.forceMkdir(new File(uploadPath));
            FileOutputStream fos=new FileOutputStream(uploadPath+ File.separator+myfile.getOriginalFilename());
            FileCopyUtils.copy(myfile.getInputStream(),fos);
            ajaxObject.setStatus(Boolean.TRUE);
            ajaxObject.setMsg("Successfully uploaded file:"+ myfile.getOriginalFilename());
        } catch (Exception e) {
            ajaxObject.setStatus(Boolean.FALSE);
            ajaxObject.setMsg("Failed to uploaded file:"+ myfile.getOriginalFilename());
            logger.error("upload file error:" + e);
            //e.printStackTrace();
        }

        return ajaxObject;
    }
}
