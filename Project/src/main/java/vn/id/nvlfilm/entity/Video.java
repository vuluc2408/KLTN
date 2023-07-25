package vn.id.nvlfilm.entity;

import java.io.Serializable;

import javax.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name="Video")
public class Video implements Serializable { 
	private static final long serialVersionUID = 1L;
	
	@Id
	@Column(name="VideoId", length= 100)
	private String videoId;
	
	@Column(name="Active")
	private boolean active;
	
	@Column(name="Title")
	private String title;
	
	@Column(name="Description")
	private String description;
	
	@Column(name="Poster")
	private String poster; 
	
	@Column(name="Views")
	private int views;
	
	//kết nối one to one tới movie
	@ManyToOne 
	@JoinColumn(name="MovieId")
	private Movie movie; 
	

}
