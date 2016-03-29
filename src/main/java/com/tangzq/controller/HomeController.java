package com.tangzq.controller;

import com.tangzq.response.JsonObject;
import com.tangzq.service.ContentService;
import com.tangzq.utils.Constant;
import org.apache.commons.io.FileUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ContextLoader;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

/**
 * 首页控制器
 */
@Controller
public class HomeController {
    public static final Logger logger = LoggerFactory.getLogger(HomeController.class);

    @Autowired
    private ContentService contentService;

    private List<String> uploadedImgList=new ArrayList<String>(); //用于存储上传文件路径
    /**
     * 跳转到首页
     * @return
     */
    @RequestMapping(value="/home")
    public String index(){
        return "index";
    }

    /**
     * 处理上传图片
     * @param photoFile
     * @return
     */
    @RequestMapping(value="/doUploadPhoto",method = RequestMethod.POST)
    @ResponseBody
    public JsonObject doUploadPhoto(
            @RequestParam(value = "photoFile",required =true)MultipartFile photoFile,
            HttpServletRequest request,
            HttpSession session
            ){
        JsonObject json=new JsonObject();
        try {
            if(null!=photoFile){
                String filename=savePhoto(photoFile,true);
                String imgURL=getHostAddr(request)+Constant.UPLOAD_FOLDER+"/"+filename;
                logger.info("保存图片成功，路径为："+imgURL);
                json.setStatus(Boolean.TRUE);
                json.setMsg("保存图片成功");
                logger.info(getHostAddr(request));
                json.setData(imgURL);
                uploadedImgList.add(imgURL);
                //将会话期内的图片保存到session中，方便下次重复利用
                session.setAttribute("uploadedImgList",uploadedImgList);
            }else{
                json.setStatus(Boolean.FALSE);
                json.setMsg("图片不能为空");
            }
        } catch (Exception e) {
            logger.error("上传图片失败！", e);
            json.setStatus(Boolean.FALSE);
            json.setMsg("保存图片失败！");
        }
        return json;
    }

    /**
     * 保存图片封装方法
     * @param photoFile
     * @param isReturnSavedFilename
     * @return
     * @throws IOException
     */
    private String savePhoto(MultipartFile photoFile,Boolean isReturnSavedFilename) throws IOException {
        String uploadPath =getUploadFolderPath();
        FileUtils.forceMkdir(new File(uploadPath));
        String savedFilename = UUID.randomUUID().toString().replaceAll("-","")+"."+ FilenameUtils.getExtension(photoFile.getOriginalFilename());
        String savedFilePath = uploadPath + File.separator + savedFilename;
        FileCopyUtils.copy(photoFile.getInputStream(), new FileOutputStream(savedFilePath));
        if(isReturnSavedFilename){
            return savedFilename;
        }else{
            return savedFilePath;
        }

    }

    /**
     * 取得保存文件的全路径
     * @param filename
     * @return
     * @throws IOException
     */
    private String getFullPath4Upload(String filename) throws IOException {
        String uploadPath=getUploadFolderPath();
        File folder=new File(uploadPath);
        if(!folder.exists()){
            FileUtils.forceMkdir(new File(uploadPath));
        }
        return uploadPath+File.separator+filename;
    }

    /**
     * 取得上传目录全路径
     * @return
     * @throws FileNotFoundException
     */
    private String getUploadFolderPath() throws FileNotFoundException {
        WebApplicationContext webApplicationContext = ContextLoader.getCurrentWebApplicationContext();
        ServletContext servletContext = webApplicationContext.getServletContext();
        String uploadFolderPath = WebUtils.getRealPath(servletContext, Constant.UPLOAD_FOLDER);
        return uploadFolderPath;
    }

    /**
     * 取得主机域名以及端口号地址，如：http://www.example.com:8080
     * @param request
     * @return
     */
    private String getHostAddr(HttpServletRequest request){
        return request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+"/"+(StringUtils.length(request.getContextPath())>0?"/":"");
    }
}
