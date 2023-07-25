package vn.id.nvlfilm.entity;

import java.io.Serializable;


import javax.persistence.*;
import lombok.*;
@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name="Rating")
public class Rating implements Serializable {
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="RatingId")
	private Long ratingId;
	
	
	@Column(name="Rating")
	private Double rating;
	
	@Column(name="Timestamp")
	private Long timestamp;
	
	
	@ManyToOne
	@JoinColumn(name="UserId", nullable= false, referencedColumnName = "UserId")
	private User user_rating;

	@ManyToOne
    @JoinColumn(name = "MovieId", nullable = false, referencedColumnName = "MovieId")
    private Movie movieRating;
	

}
