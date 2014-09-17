package com.websupport.controller;

import com.websupport.util.AjaxObject;
import com.websupport.util.Image;
import com.websupport.util.PreviewImg;
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
    @RequestMapping(value="/main2")
    public String template2(){
        return "dashboard2";
    }

    @RequestMapping(value="/index")
    public String index(){
        return "index";
    }



    @RequestMapping(value="/doupload")
    @ResponseBody
    public AjaxObject  doUpload(Image image,HttpServletRequest request){
        AjaxObject ajaxObject=new AjaxObject();
        PreviewImg previewImg = new PreviewImg();
        try {
            //TODO:下面这行代码在jboss5.1中会报错（java.lang.NoSuchMethodError: javax.servlet.http.HttpServletRequest.getServletContext()Ljavax/s），所以这里需要替换掉
            String uploadPath=WebUtils.getRealPath(request.getServletContext(),"upload");

            FileUtils.forceMkdir(new File(uploadPath));
            FileOutputStream fos=new FileOutputStream(uploadPath+ File.separator+image.getThumbFile().getOriginalFilename());
            FileCopyUtils.copy(image.getThumbFile().getInputStream(),fos);
            previewImg.setImagePath(image.getThumbFile().getOriginalFilename());
            previewImg.setImage("localhost:8080/webupload/upload/"+image.getThumbFile().getOriginalFilename());
            ajaxObject.setData(previewImg);
            ajaxObject.setStatus(Boolean.TRUE);
            ajaxObject.setMsg("Successfully uploaded file:"+ image.getThumbFile().getOriginalFilename());
        } catch (Exception e) {
            ajaxObject.setStatus(Boolean.FALSE);
            ajaxObject.setMsg("Failed to uploaded file:"+ image.getThumbFile().getOriginalFilename());
            logger.error("upload file error:" + e);
            //e.printStackTrace();
        }

        return ajaxObject;
    }
}
