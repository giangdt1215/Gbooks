package com.dtg.controller.admin;

import java.io.File;
import java.io.IOException;
import java.time.LocalDateTime;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.dtg.constants.IConstants;
import com.dtg.entities.Author;
import com.dtg.entities.Product;
import com.dtg.entities.ProductImages;
import com.dtg.entities.ProductsAuthor;
import com.dtg.repositories.AuthorRepo;
import com.dtg.repositories.ProductRepo;
import com.dtg.repositories.ProductsAuthorRepo;
import com.dtg.services.AuthorService;
import com.dtg.services.CategoryService;

@Controller
@RequestMapping(value = "/admin")
public class AdminProductController implements IConstants{

	@Autowired
	private ProductRepo productRepo;

	@Autowired
	private CategoryService categoryService;

	@Autowired
	private AuthorService authorService;

	@Autowired
	private AuthorRepo authorRepo;
	
	@Autowired
	private ProductsAuthorRepo paRepo;

	@RequestMapping(value = { "/book-mgr" }, method = RequestMethod.GET)
	public String bookManagement(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute("navAdminActive", "nav_admin_book");
		
		model.addAttribute("products", productRepo.findAll());
		return "admin/product/book-manager";
	}

	@RequestMapping(value = { "/add-book" }, method = RequestMethod.GET)
	public String addBook(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		model.addAttribute("categories", categoryService.findAllCategoryByStatus(Boolean.TRUE));
		model.addAttribute("product", new Product());
		return "admin/product/add-book";
	}

	@RequestMapping(value = { "/edit-book/{productId}" }, method = RequestMethod.GET)
	public String editBook(@PathVariable("productId") int productId, ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		model.addAttribute("categories", categoryService.findAllCategoryByStatus(Boolean.TRUE));
		Product product = productRepo.findById(productId).get();
		List<ProductsAuthor> productsAuthors = product.getProductsAuthors();
		StringBuilder sb = new StringBuilder();
		for (ProductsAuthor productsAuthor : productsAuthors) {
			if(productsAuthor.getStatus() == Boolean.TRUE) {
				sb.append(productsAuthor.getAuthor().getName());
				sb.append(";");
			}
		}
		sb.deleteCharAt(sb.length()-1);
		
		model.addAttribute("product", product);
		model.addAttribute("authorsStr", sb.toString());
		return "admin/product/edit-book";
	}

	@RequestMapping(value = { "/save-book" }, method = RequestMethod.POST)
	public String saveBook(@RequestParam(name = "productAvatar") MultipartFile productAvatar,
			@RequestParam(name = "productImages") MultipartFile[] productImages,
			@RequestParam(name = "productAuthor") String productAuthors, @ModelAttribute("product") Product product,
			ModelMap model, HttpServletRequest request, HttpServletResponse response) throws IOException {

		// check insert or update
		boolean actionUpdate = false;
		if (product.getId() != null) {
			// update
			Product productInDatabase = productRepo.findById(product.getId()).get();
		
			List<ProductsAuthor> paList = productInDatabase.getProductsAuthors();
			for (ProductsAuthor pa : paList) {
				pa.setStatus(Boolean.FALSE);
				pa.setUpdatedDate(LocalDateTime.now());
			}
			product.setProductsAuthors(paList);

			product.setAvatar(productInDatabase.getAvatar());
			product.setUpdatedDate(LocalDateTime.now());
			product.setCreatedDate(productInDatabase.getCreatedDate());
			product.setImages(productInDatabase.getImages());
			
			actionUpdate = true;
		} else {
			// insert
			product.setCreatedDate(LocalDateTime.now());
		}

		// check file ảnh avatar
		if (!productAvatar.isEmpty()) {
			// check upload dir
			File productsDir = new File(UPLOAD_DIR + "\\products");
			if (!productsDir.exists())
				productsDir.mkdirs();

			// get product avatar
			File proAvatarFile = new File(UPLOAD_DIR + "\\products\\" + productAvatar.getOriginalFilename());
			productAvatar.transferTo(proAvatarFile);
			product.setAvatar("products/" + productAvatar.getOriginalFilename());
		}

		// check file ảnh sản phẩm
		if (productImages != null && productImages.length > 0) {
			// check upload dir
			File productsDir = new File(UPLOAD_DIR + "\\products");
			if (!productsDir.exists())
				productsDir.mkdirs();

			// neu action update san pham thi delete cac anh cu cua san pham
			if (product.getId() != null && !productImages[0].isEmpty()) {
				List<ProductImages> listImage = product.getImages();
				for (ProductImages productImg : listImage) {
					productImg.setStatus(Boolean.FALSE);
					productImg.setUpdatedDate(LocalDateTime.now());
				}
			}

			for (MultipartFile imageFile : productImages) {
				if (!imageFile.isEmpty()) {
					File file = new File(UPLOAD_DIR + "\\products\\" + imageFile.getOriginalFilename());
					imageFile.transferTo(file);

					ProductImages image = new ProductImages();
					image.setCreatedDate(LocalDateTime.now());
					image.setPath("products/" + imageFile.getOriginalFilename());
					image.setStatus(Boolean.TRUE);
					product.addProductImage(image);
				}
			}
		}

		product.setStatus(Boolean.TRUE);
		product = productRepo.save(product);

		// them tac gia
		if (productAuthors != null && !productAuthors.isEmpty()) {
			
			productAuthors = productAuthors.trim();
			String[] authors = productAuthors.split(";");
			for (String authorName : authors) {
				authorName = authorName.trim();
				if (authorName.isEmpty())
					continue;
				
				Author author = authorService.findAuthorByName(authorName);
				if (author == null) {
					System.out.println("testtttttttttttttttttttttttttttttttt " + authorName);
					author = new Author();
					System.out.println("testtttttttttttttttttttttttttttttttt " + author.getId());
					author.setCreatedDate(LocalDateTime.now());
					author.setName(authorName);
					author.setStatus(Boolean.TRUE);
					author = authorRepo.saveAndFlush(author);
					
					ProductsAuthor productsAuthor = new ProductsAuthor();
					productsAuthor.setAuthor(author);
					productsAuthor.setProduct(product);
					productsAuthor.setCreatedDate(LocalDateTime.now());
					productsAuthor.setStatus(Boolean.TRUE);
					paRepo.save(productsAuthor);
				} else {
					if(actionUpdate) {
						boolean isExist = false;
						List<ProductsAuthor> paList = product.getProductsAuthors();
						for (ProductsAuthor pa : paList) {
							String authorInList = pa.getAuthor().getName();
							if(authorInList.toLowerCase().equals(authorName.toLowerCase())) {
								System.out.println("____________ Check name_________________");
								pa.setStatus(Boolean.TRUE);
								paRepo.save(pa);
								isExist = true;
								break;
							}
						}
						if(!isExist) {
							ProductsAuthor productsAuthor = new ProductsAuthor();
							productsAuthor.setAuthor(author);
							productsAuthor.setProduct(product);
							productsAuthor.setCreatedDate(LocalDateTime.now());
							productsAuthor.setStatus(Boolean.TRUE);
							paRepo.save(productsAuthor);
						}
					} else {
						ProductsAuthor productsAuthor = new ProductsAuthor();
						productsAuthor.setAuthor(author);
						productsAuthor.setProduct(product);
						productsAuthor.setCreatedDate(LocalDateTime.now());
						productsAuthor.setStatus(Boolean.TRUE);
						paRepo.save(productsAuthor);
					}
				}	
			}
		}
		
		return "redirect:/admin/book-mgr?save_book_success";
	}

	@RequestMapping(value = { "/delete-book/{productId}" }, method = RequestMethod.POST)
	public String deleteBook(@PathVariable("productId") int productId, ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		Product product = productRepo.findById(productId).get();
		product.setStatus(Boolean.FALSE);
		product.setUpdatedDate(LocalDateTime.now());

		productRepo.save(product);
		return "redirect:/admin/book-mgr?save_book_success";
	}
}
