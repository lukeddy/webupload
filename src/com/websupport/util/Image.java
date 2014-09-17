package com.websupport.util;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

/**
 * Created by Administrator on 2014/9/17.
 */
public class Image {
    private String imageType;
    private CommonsMultipartFile thumbFile;

    public String getImageType() {
        return imageType;
    }

    public void setImageType(String imageType) {
        this.imageType = imageType;
    }

    public CommonsMultipartFile getThumbFile() {
        return thumbFile;
    }

    public void setThumbFile(CommonsMultipartFile thumbFile) {
        this.thumbFile = thumbFile;
    }
}
