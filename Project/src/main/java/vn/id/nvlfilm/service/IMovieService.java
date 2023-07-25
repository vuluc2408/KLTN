package vn.id.nvlfilm.service;

import java.util.List;
import java.util.Optional;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;

import vn.id.nvlfilm.entity.Movie;

public interface IMovieService {

	void deleteAll();

	void delete(Movie entity);

	void deleteById(Long id);

	long count();

	Optional<Movie> findById(Long id);

	List<Movie> findAllById(Iterable<Long> ids);

	List<Movie> findAll();

	Page<Movie> findAll(Pageable pageable);

	List<Movie> findAll(Sort sort);

	<S extends Movie> S save(S entity);
	
	List<Movie> findByMovienameContaining(String name);
	
	Page<Movie> findByMovienameContaining(String name, Pageable pageable);


}
