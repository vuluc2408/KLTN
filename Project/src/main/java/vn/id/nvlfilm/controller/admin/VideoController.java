package vn.id.nvlfilm.controller.admin;


import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


import vn.id.nvlfilm.entity.Video;
import vn.id.nvlfilm.entity.Movie;
import vn.id.nvlfilm.model.MovieModel;
import vn.id.nvlfilm.model.VideoModel;
import vn.id.nvlfilm.service.IMovieService;
import vn.id.nvlfilm.service.IStorageService;
import vn.id.nvlfilm.service.IVideoService;

@Controller
@RequestMapping("admin/videos")
public class VideoController {
	@Autowired
	IVideoService videoService;
	
	@Autowired
	IMovieService movieService;
	
	@Autowired
	IStorageService storageService;
	
	//hien thi hinh anh
	@GetMapping("/images/{filename:.+}")
	@ResponseBody
	public ResponseEntity<Resource> serverFile(@PathVariable String filename){
		Resource file = storageService.loadAsResource(filename);
		return ResponseEntity.ok().header(HttpHeaders.CONTENT_DISPOSITION,
				"attachment;filename=\"" + file.getFilename()+ "\"").body(file);
	}
	
	//lay danh sach movie trong bang movie
	@ModelAttribute("movies")
	public List<MovieModel> getMovies(){
		return movieService.findAll().stream().map(item->{
			MovieModel mo = new MovieModel();
			BeanUtils.copyProperties(item, mo);
			return mo;
		}).toList();
				}
	
	@RequestMapping("")
	public String listvideos(ModelMap model) {
		List<Video> list = videoService.findAll();
		model.addAttribute("videos", list);
		return "admin/videos/list";
	}
	
	@GetMapping("add")
	public String Add(ModelMap model) {
		VideoModel video = new VideoModel();
		video.setIsEdit(false);
		model.addAttribute("video",video);
		return "admin/videos/addOrEdit";
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, 
			@Valid @ModelAttribute("video") VideoModel mo, BindingResult result) {
		if(result.hasErrors()) {
			return new ModelAndView("admin/videos/addOrEdit");
		}
		
		Video entity = new Video();
		//copy tu model sang entity
		BeanUtils.copyProperties(mo, entity);
		//xu ly movie
		Movie movieEntity = new Movie();
		movieEntity.setMovieId(mo.getMovieId());
		entity.setMovie(movieEntity);
		
		//xu ly hinh anh
		if(!mo.getImageFile().isEmpty()) {
			
			UUID uuid =  UUID.randomUUID();
			String uuString = uuid.toString();
			//luu file vao truong poster
			entity.setPoster(storageService.getStorageFilename(mo.getImageFile(), uuString));
			storageService.store(mo.getImageFile(), entity.getPoster());
		}
		
		
		
		videoService.save(entity);
		String	message = "";
		if (mo.getIsEdit()==true) {
			message = "Video da dc cap nhat thanh cong";
		}else {
			message = "Video da dc them thanh cong";
		}
		model.addAttribute("message",message);
		return new ModelAndView("forward:/admin/videos",model);
	}
	
	@GetMapping("edit/{videoId}")
	public ModelAndView edit(ModelMap model, 
			@PathVariable("videoId") String videoId) {
		
		Optional<Video> opt = videoService.findById(videoId);
		VideoModel mo =  new VideoModel();
		if(opt.isPresent()) {
			Video entity = opt.get();
			BeanUtils.copyProperties(entity, mo); //copy tu entity sang model
			mo.setIsEdit(true);
			model.addAttribute("video",mo);	
			return new ModelAndView("admin/videos/addOrEdit",model);
		}
		model.addAttribute("message","Video khong ton tai");
		return new ModelAndView("forward:/admin/videos",model);
	}
	
	@GetMapping("delete/{videoId}")
	public ModelAndView delete(ModelMap model, 
			@PathVariable("videoId") String videoId) {
		videoService.deleteById(videoId);
		model.addAttribute("message","Video da duoc xoa");
		return new ModelAndView("forward:/admin/videos/searchpagenated",model);
	}
	
	@GetMapping("search")
	public String search(ModelMap model, @RequestParam(name="name",required = false) String name) {
		List<Video> list =	null;
		if(StringUtils.hasText(name)) {
			list = videoService.findByTitleContaining(name);
		}else {
			list = videoService.findAll();
		}
		model.addAttribute("videos",list);
		return "admin/videos/search";	
	}
	
	@RequestMapping("searchpagenated")
	public String search(ModelMap model, 
			@RequestParam(name="name", required = false) String name,
			@RequestParam("page")Optional<Integer> page,
			@RequestParam("size") Optional<Integer> size) {
		
		int count = (int) videoService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		
		Pageable pageable = PageRequest.of(currentPage-1, pageSize, Sort.by("videoId"));
		
		Page<Video> resultPage = null;
				
		if(StringUtils.hasText(name)) {
			resultPage = videoService.findByTitleContaining(name, pageable);
			model.addAttribute("name");
		}else {
			resultPage = videoService.findAll(pageable);
		}
		
		int totalsPages = resultPage.getTotalPages();
		if(totalsPages>0) {
			int start = Math.max(1, currentPage-2);
			int end = Math.min(currentPage+2, totalsPages);
			if(totalsPages> count) {
				if(end==totalsPages) start = end - count;
				else if(start==1) end = start + count;
			}
			List<Integer> pageNumbers = IntStream.rangeClosed(start,end)
					.boxed()
					.collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
			
		}
		model.addAttribute("videoPage", resultPage);
		return "admin/videos/searchpagenated";
	
	}
}
