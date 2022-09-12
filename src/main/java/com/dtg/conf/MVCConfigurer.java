package com.dtg.conf;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;
import org.springframework.web.servlet.ViewResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.view.InternalResourceViewResolver;
import org.springframework.web.servlet.view.JstlView;

import com.dtg.constants.IConstants;

@Configuration
@ControllerAdvice
@EnableWebMvc
@ComponentScan(basePackages = {"com.dtg"})
public class MVCConfigurer implements WebMvcConfigurer, IConstants{

	@Bean
	public ViewResolver viewResolver() {
		InternalResourceViewResolver viewResolver = new InternalResourceViewResolver();
		viewResolver.setViewClass(JstlView.class);
		viewResolver.setPrefix("/WEB-INF/views/");
		viewResolver.setSuffix(".jsp");
		return viewResolver;
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/css/**").addResourceLocations("classpath:/META-INF/css/");
		registry.addResourceHandler("/js/**").addResourceLocations("classpath:/META-INF/js/");
		registry.addResourceHandler("/images/**").addResourceLocations("classpath:/META-INF/images/");
		registry.addResourceHandler("/webfonts/**").addResourceLocations("classpath:/META-INF/webfonts/");
		registry.addResourceHandler("/summernote/**").addResourceLocations("classpath:/META-INF/summernote/");
		
		//Admin configures
		registry.addResourceHandler("/admin/css/**").addResourceLocations("classpath:/META-INF/admin/css/");
		registry.addResourceHandler("/admin/js/**").addResourceLocations("classpath:/META-INF/admin/js/");
		registry.addResourceHandler("/admin/fonts/**").addResourceLocations("classpath:/META-INF/admin/fonts/");
		
		//Upload directory configuration
		registry.addResourceHandler("/upload/**").addResourceLocations("file:" + UPLOAD_DIR_CONF);
	}
	
	@ExceptionHandler(Exception.class)
	public ModelAndView defaultErrorHandler(HttpServletRequest request, Exception e) throws Exception {

		if (e instanceof NoHandlerFoundException) { 
			// 404 error 
			ModelAndView mv = new ModelAndView();
			mv.addObject("exception", e);
			mv.addObject("url", request.getRequestURL());
			mv.setViewName("errors/404");
			return mv;
		} else {
			ModelAndView mv = new ModelAndView();
			mv.addObject("errorMsg", "Hệ thống gặp sự cố, xin hãy quay lại sau!");
			mv.addObject("exception", e);
			mv.addObject("url", request.getRequestURL());
			mv.setViewName("errors/common");
			return mv;
		}
	}

}
