package vn.id.nvlfilm.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import vn.id.nvlfilm.entity.Movie;

@Repository
public interface MovieRepository extends JpaRepository<Movie, Long>{
	List<Movie> findByMovienameContaining(String name);
	Page<Movie> findByMovienameContaining(String name, Pageable pageable);
}
