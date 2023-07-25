package vn.id.nvlfilm.entity;

import java.io.Serializable;
import java.util.Set;

import javax.persistence.*;
import javax.validation.constraints.NotNull;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name="Movie")
public class Movie implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="MovieId")
	private Long movieId;
	
	@Column(name="MovieName", columnDefinition = "nvarchar(255)")
	@NotNull
	private String moviename;
	
	@Column(name="Genres", columnDefinition = "nvarchar(255)")
	private String genres;
	
	@Column(name="Actor")
	private String actor;
	
	@Column(name="Director")
	private String director;
	
	@Column(name="Country", columnDefinition = "nvarchar(255)")
	@NotNull
	private String country;
	
	@Column(name="Score")
	private float score;
	
	@Column(name="Released")
	private int released;
	
	@Column(name="Images")
	private String images;
	
	@Column(name="Runtime")
	private String runtime;
	
	@Column(name="Description")
	private String description;

	@OneToMany(mappedBy = "movieRating")
    private Set<Rating> ratings;
	
	@OneToMany(mappedBy = "movie")
    private Set<Video> videos;


}
