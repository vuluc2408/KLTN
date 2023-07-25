package vn.id.nvlfilm.repository;

import java.util.List;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import vn.id.nvlfilm.entity.Video;

public interface VideoRepository extends JpaRepository<Video, String>{
	//tim kiem theo noi dung
	List<Video> findByTitleContaining(String name);
	//tim kiem va phan trang
	Page<Video> findByTitleContaining(String name, Pageable pageable);
}
