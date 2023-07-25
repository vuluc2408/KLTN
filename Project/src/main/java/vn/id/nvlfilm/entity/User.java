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
@Table(name="User")
public class User implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="UserId")
	private Long userId;
	
	@Column(name="UserName")
	@NotNull
	private String username;
	
	@Column(name="Password")
	@NotNull
	private String password;
	
	@Column(name="Gmail")
	@NotNull
	private String gmail;
	
	@Column(name="FirstName",columnDefinition = "nvarchar(255)", nullable=true)
	private String firstname;
	
	@Column(name="LastName",columnDefinition = "nvarchar(255)",nullable=true)
	private String lastname;
	
	
	//kết nối many to many với role
	@ManyToOne
	@JoinColumn(name="Role",nullable=false, referencedColumnName = "RoleId")
	private Role role;
	
	//kết nối one to many tới comment
	@OneToMany(mappedBy = "user", cascade = CascadeType.ALL)
	private Set<Comment> comment;
	
	@OneToMany(mappedBy = "user_rating", cascade = CascadeType.ALL)
	private Set<Rating> rating;
	
}
