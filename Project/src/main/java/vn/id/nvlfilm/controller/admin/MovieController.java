package vn.id.nvlfilm.controller.admin;


import java.util.List;
import java.util.Optional;

import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.validation.Valid;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
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
import org.springframework.web.servlet.ModelAndView;


import vn.id.nvlfilm.entity.Movie;
import vn.id.nvlfilm.model.MovieModel;
import vn.id.nvlfilm.service.IMovieService;

@Controller
@RequestMapping("admin/movies")
public class MovieController {
	@Autowired
	IMovieService movieService;
	
	@RequestMapping("")
	public String listmovies(ModelMap model) {
		List<Movie> list = movieService.findAll();
		model.addAttribute("movies", list);
		return "admin/movies/list";
	}
	
	@GetMapping("add")
	public String Add(ModelMap model) {
		MovieModel movie = new MovieModel();
		movie.setIsEdit(false);
		model.addAttribute("movie",movie);
		return "admin/movies/addOrEdit";
	}
	
	@PostMapping("saveOrUpdate")
	public ModelAndView saveOrUpdate(ModelMap model, 
			@Valid @ModelAttribute("movie") MovieModel mo, BindingResult result) {
		if(result.hasErrors()) {
			return new ModelAndView("admin/movies/addOrEdit");
		}
		Movie entity = new Movie();
		//copy tu model sang entity
		BeanUtils.copyProperties(mo, entity);
		
		movieService.save(entity);
		String	message = "";
		if (mo.getIsEdit()==true) {
			message = "Movie da dc cap nhat thanh cong";
		}else {
			message = "Movie da dc them thanh cong";
		}
		model.addAttribute("message",message);
		return new ModelAndView("forward:/admin/movies",model);
	}
	
	@GetMapping("edit/{movieId}")
	public ModelAndView edit(ModelMap model, 
			@PathVariable("movieId") Long movieId) {
		
		Optional<Movie> opt = movieService.findById(movieId);
		MovieModel mo =  new MovieModel();
		if(opt.isPresent()) {
			Movie entity = opt.get();
			BeanUtils.copyProperties(entity, mo); //copy tu entity sang model
			mo.setIsEdit(true);
			model.addAttribute("movie",mo);	
			return new ModelAndView("admin/movies/addOrEdit",model);
		}
		model.addAttribute("message","Movie khong ton tai");
		return new ModelAndView("forward:/admin/movies",model);
	}
	
	@GetMapping("delete/{movieId}")
	public ModelAndView delete(ModelMap model, 
			@PathVariable("movieId") Long movieId) {
		movieService.deleteById(movieId);
		model.addAttribute("message","Movie da duoc xoa");
		return new ModelAndView("forward:/admin/movies/searchpagenated",model);
	}
	
	@GetMapping("search")
	public String search(ModelMap model, @RequestParam(name="name",required = false) String name) {
		List<Movie> list =	null;
		if(StringUtils.hasText(name)) {
			list = movieService.findByMovienameContaining(name);
		}else {
			list = movieService.findAll();
		}
		model.addAttribute("movies",list);
		return "admin/movies/search";	
	}
	
	@RequestMapping("searchpagenated")
	public String search(ModelMap model, 
			@RequestParam(name="name", required = false) String name,
			@RequestParam("page")Optional<Integer> page,
			@RequestParam("size") Optional<Integer> size) {
		
		int count = (int) movieService.count();
		int currentPage = page.orElse(1);
		int pageSize = size.orElse(3);
		
		Pageable pageable = PageRequest.of(currentPage-1, pageSize, Sort.by("movieId"));
		
		Page<Movie> resultPage = null;
				
		if(StringUtils.hasText(name)) {
			resultPage = movieService.findByMovienameContaining(name, pageable);
			model.addAttribute("name");
		}else {
			resultPage = movieService.findAll(pageable);
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
		model.addAttribute("moviePage", resultPage);
		return "admin/movies/searchpagenated";
		
		
	}
}
