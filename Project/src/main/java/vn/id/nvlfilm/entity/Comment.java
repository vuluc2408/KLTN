package vn.id.nvlfilm.entity;

import java.io.Serializable;

import javax.persistence.*;
import lombok.*;

@Data
@NoArgsConstructor
@AllArgsConstructor

@Entity
@Table(name="Comment")
public class Comment implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="CommentId")
	private Long commentId;
	
	@Column(name="MovieId")
	private String movieId;
	
	@Column(name="Comment", columnDefinition = "nvarchar(255)")
	private String comment;
	
	//kết nối many to one tới user
	@ManyToOne
	@JoinColumn(name="UserId", nullable= true, referencedColumnName = "UserId")
	private User user;
}
