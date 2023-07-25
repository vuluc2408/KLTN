package vn.id.nvlfilm.service;

import java.nio.file.Path;

import org.springframework.core.io.Resource;
import org.springframework.web.multipart.MultipartFile;



public interface IStorageService {

	String getStorageFilename(MultipartFile file, String id);

	void store(MultipartFile file, String storeFilename);

	Resource loadAsResource(String filename);

	Path load(String filename);

	void delete(String storeFilenam) throws Exception;

	void init();

}
