package com.socialnet.service.impl;



import java.io.File;
import java.io.IOException;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;

import com.socialnet.model.Image;
import com.socialnet.service.ImageService;
import com.socialnet.util.ImageUtil;


/** 
 *	Implementation of ImageService
 *	that adds caching for images 
 *  and delegates image manipulation to ImageUtil
 *  @see ImageService
 *  @see  ImageUtil
 *
 */
public class ImageServiceImpl implements ImageService {
	

    private static final Logger logger = Logger.getLogger(ImageServiceImpl.class);
    
	private String placeholderFilename;
	private ImageUtil imageUtil;
	
	@Autowired
	public ImageServiceImpl(ImageUtil imageUtil,String placeholderFilename){
		super();
		this.imageUtil = imageUtil;
		this.placeholderFilename = placeholderFilename;
	}
	
	/**
	 * Uses image util to return an image converted as a b64 string.<br/>
	 * Tries to resolve missing files by returning a placeholder
	 * image
	 */
	@Override
	@Cacheable(value="b64", key="#path")
	public String getB64(String path){
		try{
			return imageUtil.encodeToB64String(path);
        }catch(IOException missingFile){
            logger.error("Cant open file "+ path);
            try{
                return imageUtil.encodeToB64String(placeholderFilename);
            }catch(IOException ignore){
                logger.error("Cant open file "+ placeholderFilename );
                throw new IllegalArgumentException("Can't open placeholder file ");
            }
        }
	}

	/**
	 * Uses image util to return an image loaded in a byte[].<br/>
	 * Tries to resolve missing files by returning a placeholder
	 * image
	 */
	@Override
	@Cacheable(value="image", key="#path")
	public byte[] loadImage(String path){
		try{
			return imageUtil.loadImage(path);
		}catch(IOException missingFile){
            logger.error("Cant open file "+ path);
            try{
                return imageUtil.loadImage(placeholderFilename);
            }catch(IOException ignore){
                logger.error("Cant open file "+ placeholderFilename );
                throw new IllegalArgumentException("Can't open placeholder file ");
            }
        }
	}



	@Override
	@CacheEvict(value="image",key="#path")
	public void removeImage(String path) throws IOException {
		File file = new File(path);
		if(file.exists()){
		    file.delete();
		}
	}

	@Override
	public void removeImages(List<Image> userImages) throws IOException {
		for(Image i : userImages){
			removeImage(i.getImagePath());
		}
	}
	
	@Override
	public String saveImage(File file, String contentType, String fileName) throws IOException{
		return imageUtil.saveImage(file, contentType, fileName);
	}

	
}
