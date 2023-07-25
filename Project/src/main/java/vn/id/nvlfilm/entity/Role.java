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
@Table(name="Role")
public class Role implements Serializable{
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	@Column(name="RoleId")
	private Long roleId;
	
	@Column(name="RoleName")
	@NotNull
	private String roleName;
	
	@Column(name="RoleCode", columnDefinition = "nvarchar(255)")
	@NotNull
	private String roleCode;
	
	//kết nối many to one với user
	@OneToMany(mappedBy = "role", cascade = CascadeType.ALL)
	private Set<User> user;

	
}
