package vn.id.nvlfilm.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor

public class MovieModel {
	private Long movieId;
	private String moviename;
	private String genres;
	private String actor;
	private String director;
	private String country;
	private float score;
	private int released;
	private String images;
	private String runtime;
	private String description;
	private MultipartFile imageFile;//lưu hình
	
	private Boolean isEdit = false;



	
	
	
	
}
