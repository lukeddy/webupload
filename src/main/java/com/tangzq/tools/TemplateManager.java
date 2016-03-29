package com.tangzq.tools;

import org.apache.velocity.app.VelocityEngine;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.velocity.VelocityEngineUtils;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;


/**
 * 模版渲染封装类
 */
public class TemplateManager {

    public static final Logger logger = LoggerFactory.getLogger(TemplateManager.class);
    @Autowired
    @Qualifier("velocityEngine")
    private VelocityEngine velocityEngine;

    /**
     * 将内容填充到模版中
     * @param content
     * @return
     */
    public String parseTemplate(String content){
        Map<String,Object> data=new HashMap<String,Object>();
        data.put("content", content);
        logger.info("要填充的内容为:"+content);
        String newContent=VelocityEngineUtils.mergeTemplateIntoString(velocityEngine, "templates/email_tpl.vm", "utf-8", data);
        logger.info("填充后的内容为"+newContent);
        return newContent;
    }
}
