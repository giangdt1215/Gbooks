package com.dtg.controller;

import java.math.BigDecimal;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.dtg.constants.IConstants;
import com.dtg.dto.AjaxResponse;
import com.dtg.dto.Cart;
import com.dtg.dto.CartAjaxReponse;
import com.dtg.dto.CartItem;
import com.dtg.entities.Order;
import com.dtg.entities.OrderDetails;
import com.dtg.entities.Product;
import com.dtg.entities.User;
import com.dtg.repositories.OrderRepo;
import com.dtg.services.ProductService;
import com.dtg.services.UserService;

@Controller
public class CartController extends BaseController implements IConstants {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;

	@Autowired
	private OrderRepo orderRepo;

	@RequestMapping(value = { "/cart" }, method = RequestMethod.GET)
	public String cart(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_CART_ACTIVE);
		
		model.addAttribute("maxBuyAmount", MAX_BUY_AMOUNT);

		return "cart";
	}

	@PostMapping(value = { "/add-to-cart" })
	public ResponseEntity<AjaxResponse> addToCart(@RequestBody CartItem data, ModelMap model,
			HttpServletRequest request, HttpServletResponse response) {

		// get Session
		HttpSession session = request.getSession();

		// check attribute GIO_HANG in session
		Cart cart = null;
		if (session.getAttribute(CART_ATT) != null) {
			cart = (Cart) session.getAttribute(CART_ATT);
		} else {
			cart = new Cart();
		}

		// get attributes from request item
		Product product = productService.findProductById(data.getProductId());
		data.setProductAvatar(product.getAvatar());
		data.setProductName(product.getName());
		data.setProductPrice(product.getPrice());

		// check product item in GIO_HANG
		List<CartItem> cartItems = cart.getCartItems();
		boolean isExist = false;
		for (CartItem cartItem : cartItems) {
			if (cartItem.getProductId() == data.getProductId()) {
				isExist = true;
				cartItem.setQuantity(cartItem.getQuantity() + data.getQuantity());
			}
		}

		if (!isExist) {
			cart.getCartItems().add(data);
		}

		session.setAttribute(CART_ATT, cart);

		return ResponseEntity.ok(new AjaxResponse(String.valueOf(cart.getTotalCartItemQuantity()), SUCCESS_STATUS_CODE));
	}

	@PostMapping(value = { "/processProductInCart" })
	public ResponseEntity<AjaxResponse> plusProductInCart(@RequestBody final Map<String, Object> data,
			final ModelMap model, final HttpServletRequest request, final HttpServletResponse response) {
		
		int productId = (int) data.get("productId");
		// check cart in session
		HttpSession session = request.getSession();
		Cart cart = null;
		if (session.getAttribute(CART_ATT) == null) {
			return ResponseEntity.ok(new AjaxResponse(ERROR_MSG, 500));
		}

		cart = (Cart) session.getAttribute(CART_ATT);

		List<CartItem> cartItems = cart.getCartItems();
		String processType = (String)data.get("processType");
		
		BigDecimal itemCost = new BigDecimal(0);
		if(processType.equals("add")) {
			for (CartItem item : cartItems) {
				if (item.getProductId() == productId) {
					item.setQuantity(Integer.parseInt((String) data.get("quantity")));
					itemCost = item.getProductPrice().multiply(BigDecimal.valueOf(item.getQuantity()));
					break;
				}
			}
		} else {
			for (CartItem item : cartItems) {
				if (item.getProductId() == productId) {
					cartItems.remove(item);
					break;
				}
			}
		}

		session.setAttribute(CART_ATT, cart);

		CartAjaxReponse ajaxResponse = new CartAjaxReponse();
		DecimalFormat df = new DecimalFormat(NUMBER_FORMAT_PATTERN);
		if (cart.getCost().compareTo(SHIP_CONDITION) >= 0) {
			ajaxResponse.setShipFee("Miễn phí");
		} else {
			ajaxResponse.setShipFee(df.format(Cart.SHIP_FEE));
		}
		ajaxResponse.setItemCost(df.format(itemCost));
		ajaxResponse.setCost(df.format((cart.getCost())));
		ajaxResponse.setQuantity(cart.getTotalCartItemQuantity());
		ajaxResponse.setTotalCost(df.format(cart.getTotalCost()));
		
		if(cartItems.size() <= 0) {
			ajaxResponse.setEmpty(true);
		}
		
		ajaxResponse.setMessage("Đã xử lý hàng trong giỏ");
		ajaxResponse.setStatusCode(SUCCESS_STATUS_CODE);

		return ResponseEntity.ok(ajaxResponse);
	}
	
	@RequestMapping(value = { "/checkout" }, method = RequestMethod.GET)
	public String checkOut(ModelMap model, HttpServletRequest request, HttpServletResponse response) {
		HttpSession session = request.getSession();
		session.setAttribute(NAV_ACTIVE_ATT, NAV_CHECKOUT_ACTIVE);
		
		User user = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)) {
			if(authentication.getPrincipal() instanceof UserDetails) {
				user = (User) authentication.getPrincipal();
			}
		}
		
		Order order = new Order();
		if(user != null) {
			//set user attributes to jsp
			user = userService.findUserById(user.getId());
			
			order.setCustomerEmail(user.getEmail());
			order.setCustomerAddress(user.getAddress());
			order.setCustomerName(user.getFullName());
			model.addAttribute("phoneNumber1", user.getPhone());
		}
		model.addAttribute("order", order);
		
		return "checkout";
	}

	@RequestMapping(value = { "/save-order" }, method = RequestMethod.POST)
	public String saveOrder(@ModelAttribute("order") Order order,
			@RequestParam(name = "phoneNumber1") String phoneNumber1,
			@RequestParam(name = "phoneNumber2") String phoneNumber2, ModelMap model, HttpServletRequest request,
			HttpServletResponse response) {
		HttpSession session = request.getSession();
		Cart cart = (Cart) session.getAttribute(CART_ATT);
		
		User user = null;
		Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
		if(!(authentication instanceof AnonymousAuthenticationToken)) {
			if(authentication.getPrincipal() instanceof UserDetails) {
				user = (User) authentication.getPrincipal();
			}
		}

		if (cart != null) {
			user = userService.findUserById(user.getId());
			StringBuilder sb = new StringBuilder(phoneNumber1);
			if (phoneNumber2 != null && phoneNumber2.length() > 0) {
				sb.append("| ");
				sb.append(phoneNumber2);
			}
			order.setCustomerPhone(sb.toString());
			order.setOrderStatus("Chưa xử lý");
			order.setCreatedDate(LocalDateTime.now());
			order.setStatus(Boolean.TRUE);
			order.setOrderTotalCost(cart.getTotalCost());
			order.setUser(user);
			order = orderRepo.save(order);

			List<CartItem> cartItems = cart.getCartItems();
			for (CartItem cartItem : cartItems) {
				OrderDetails orderDetails = new OrderDetails();
				orderDetails.setOrder(order);
				orderDetails.setProduct(productService.findProductById(cartItem.getProductId()));
				orderDetails.setCreatedDate(LocalDateTime.now());
				orderDetails.setStatus(Boolean.TRUE);
				orderDetails.setProductPrice(cartItem.getProductPrice());
				orderDetails.setProductQuantity(cartItem.getQuantity());
				orderDetails.setCost(cartItem.getProductPrice().multiply(BigDecimal.valueOf(cartItem.getQuantity())));

				order.getOrderDetails().add(orderDetails);
			}

			orderRepo.save(order);
		}
		return "redirect:/success?order_success=ok";
	}
}
