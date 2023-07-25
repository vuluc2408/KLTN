package vn.id.nvlfilm.model;

import org.springframework.web.multipart.MultipartFile;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class VideoModel {
	
	private String videoId;
	private String description;
	private int views;
	private String poster;
	private MultipartFile imageFile;
	private boolean active;
	private String title;
	private Long movieId;
	
	private Boolean isEdit= false;
}
