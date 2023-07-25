package vn.id.nvlfilm.service.impl;

import java.util.List;
import java.util.Optional;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;

import vn.id.nvlfilm.entity.Movie;
import vn.id.nvlfilm.repository.MovieRepository;
import vn.id.nvlfilm.service.IMovieService;

@Service
@Transactional
public class MovieServiceImpl implements IMovieService {

	@Autowired
	MovieRepository movieRepository;
;

	public MovieServiceImpl(MovieRepository movieRepository) {
		this.movieRepository = movieRepository;
	}

	@Override
	public <S extends Movie> S save(S entity) {
		return movieRepository.save(entity);
	}

	@Override
	public List<Movie> findAll(Sort sort) {
		return movieRepository.findAll(sort);
	}

	@Override
	public Page<Movie> findAll(Pageable pageable) {
		return movieRepository.findAll(pageable);
	}

	@Override
	public List<Movie> findAll() {
		return movieRepository.findAll();
	}

	@Override
	public List<Movie> findAllById(Iterable<Long> ids) {
		return movieRepository.findAllById(ids);
	}

	@Override
	public Optional<Movie> findById(Long id) {
		return movieRepository.findById(id);
	}

	@Override
	public long count() {
		return movieRepository.count();
	}

	@Override
	public void deleteById(Long id) {
		movieRepository.deleteById(id);
	}

	@Override
	public void delete(Movie entity) {
		movieRepository.delete(entity);
	}

	@Override
	public void deleteAll() {
		movieRepository.deleteAll();
	}

	@Override
	public List<Movie> findByMovienameContaining(String name) {
		
		return movieRepository.findByMovienameContaining(name);
	}

	@Override
	public Page<Movie> findByMovienameContaining(String name, Pageable pageable) {
		// TODO Auto-generated method stub
		return movieRepository.findByMovienameContaining(name, pageable);
	}


}
