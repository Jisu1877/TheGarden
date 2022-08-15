package com.spring.javagreenS_ljs.service;

import java.io.FileOutputStream;
import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.dao.PointDAO;
import com.spring.javagreenS_ljs.dao.UserDAO;
import com.spring.javagreenS_ljs.vo.CouponVO;
import com.spring.javagreenS_ljs.vo.OrderListVO;
import com.spring.javagreenS_ljs.vo.PointVO;
import com.spring.javagreenS_ljs.vo.RecentViewsVO;
import com.spring.javagreenS_ljs.vo.UserVO;
import com.spring.javagreenS_ljs.vo.WishlistVO;

@Service
public class UserServiceImpl implements UserService {

	@Autowired
	UserDAO userDAO;
	
	@Autowired
	OrderService orderService;
	
	@Autowired
	UserAdminService userAdminService;

	@Override
	public UserVO getUserInfor(String user_id) {
		return userDAO.getUserInfor(user_id);
	}

	@Override
	public void setUserJoin(UserVO vo) {
		userDAO.setUserJoin(vo);
	}

	@Override
	public void setUserLoginUpdate(String user_id) {
		userDAO.setUserLoginUpdate(user_id);
	}

	@Override
	public void setUserLog(int user_idx, String host_ip) {
		userDAO.setUserLog(user_idx, host_ip);
	}

	@Override
	public void setUserImageChange(MultipartHttpServletRequest multipart, int user_idx) {
		// 서버에 파일 올리기 & DB업로드
		setItemImage(multipart, user_idx);

	}

	// 저장되는 파일명의 중복을 방지하기 위해 새로 파일명을 만들어준다.
	private String saveFileName(String oFileName) {
		String fileName = "";

		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyMMddHHmmss");

		fileName += sdf.format(date) + "_" + oFileName;

		return fileName;
	}

	// 서버에 파일 저장하기
	private void writeFile(MultipartFile file, String sFileName) throws IOException {
		byte[] data = file.getBytes(); // 넘어온 객체를 byte 단위로 변경시켜줌.

		// request 객체 꺼내오기.
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes())
				.getRequest();
		// 실제로 업로드되는 경로를 찾아오기
		String realPath = request.getSession().getServletContext().getRealPath("/resources/data/user/");
		// 이 경로에 이 파일이름으로 저장할 껍데기 만들기
		FileOutputStream fos = new FileOutputStream(realPath + sFileName);
		fos.write(data); // 내용물 채우기
		fos.close();
	}

	public void setItemImage(MultipartHttpServletRequest multipart, int user_idx) {
		try {
			List<MultipartFile> fileList = multipart.getFiles("user_image");

			for (MultipartFile file : fileList) {
				if (file.getSize() == 0) {
					continue;
				}
				String oFileName = file.getOriginalFilename();
				String sFileName = saveFileName(oFileName); // 서버에 저장될 파일명을 결정해준다.
				// 서버에 파일 저장처리하기
				writeFile(file, sFileName);

				// item_image DB저장
				if (!oFileName.equals("")) {
					userDAO.setUserImageChange(sFileName, user_idx);
				}
			}

		} catch (IOException e) {
			e.printStackTrace();
		}

	}

	@Override
	public void setUserNameUpdate(int user_idx, String name) {
		userDAO.setUserNameUpdate(user_idx, name);
	}

	@Override
	public void setUserEmailUpdate(int user_idx, String email) {
		userDAO.setUserEmailUpdate(user_idx, email);
	}

	@Override
	public void setUserTelUpdate(int user_idx, String tel) {
		userDAO.setUserTelUpdate(user_idx, tel);
	}

	@Override
	public void setUserGenderUpdate(int user_idx, String gender) {
		userDAO.setUserGenderUpdate(user_idx, gender);
	}

	@Override
	public void setUserPwdUpdate(int user_idx, String encPwd) {
		userDAO.setUserPwdUpdate(user_idx, encPwd);
	}

	@Override
	public UserVO getUserInforIdx(int user_idx) {
		return userDAO.getUserInforIdx(user_idx);
	}

	@Override
	public void setCouponInsertFirstBuy(int user_idx, int coupon_idx) {
		// 쿠폰 고유번호로 쿠폰 정보 가져오기
		CouponVO vo = userDAO.getCouponInfor(coupon_idx);

		vo.setUser_idx(user_idx);
		vo.setReason(vo.getCoupon_explan());

		// 만료일 계산
		Calendar cal = Calendar.getInstance();
		cal.setTime(new Date());
		DateFormat df = new SimpleDateFormat("yyyy-MM-dd");

		cal.add(Calendar.DATE, vo.getCoupon_period());
		String date = df.format(cal.getTime());
		vo.setExpiry_date(date);

		// 회원에게 쿠폰 발급
		userDAO.setCouponInsert(vo);
	}

	@Override
	public ArrayList<CouponVO> getUserCouponList(int user_idx) {
		return userDAO.getUserCouponList(user_idx);
	}

	@Override
	public ArrayList<CouponVO> getUserCouponListOnlyUseOk(int user_idx) {
		return userDAO.getUserCouponListOnlyUseOk(user_idx);
	}

	@Override
	public void setUserGivePoint(int user_idx, int point) {
		userDAO.setUserGivePoint(user_idx, point);
	}

	@Override
	public void setMyPage(UserVO userVO, Model model) {
		// 주문 + 주문 목록 정보 가져오기(결제 완료 건만)
		ArrayList<OrderListVO> orderListOnlyOrder = orderService.getorderListOnlyOrder(userVO.getUser_idx());
		int orderListOnlyOrderCnt = orderListOnlyOrder.size();

		// 주문 + 주문 목록 정보 가져오기(배송중인 건만)
		ArrayList<OrderListVO> orderListOnlyDelivery = orderService.getOrderListOnlyChoice(userVO.getUser_idx(), "4");
		int orderListOnlyDeliveryCnt = orderListOnlyDelivery.size();

		// 주문 + 주문 목록 정보 가져오기(배송완료인 건만)
		ArrayList<OrderListVO> orderListOnlyDeliveryOk = orderService.getOrderListOnlyDeliveryOk(userVO.getUser_idx());
		int orderListOnlyDeliveryOkCnt = orderListOnlyDeliveryOk.size();

		// 주문 + 주문 목록 정보 가져오기(취소/반품/교환 관련 건만)
		ArrayList<OrderListVO> orderListOnlyReturn = orderService.getOrderListOnlyReturn(userVO.getUser_idx());
		int orderListOnlyReturnCnt = orderListOnlyReturn.size();

		// 보유 쿠폰 리스트 가져오기
		ArrayList<CouponVO> couponList = this.getUserCouponList(userVO.getUser_idx());
		int couponCnt = couponList.size();
		
		SimpleDateFormat sdf1 = new SimpleDateFormat("yyyy-MM");        
        Date now = new Date();
        String nowDate = sdf1.format(now);
		
		model.addAttribute("nowDate", nowDate);
		model.addAttribute("couponCnt", couponCnt);
		model.addAttribute("orderListOnlyOrderCnt", orderListOnlyOrderCnt);
		model.addAttribute("orderListOnlyDeliveryCnt", orderListOnlyDeliveryCnt);
		model.addAttribute("orderListOnlyDeliveryOkCnt", orderListOnlyDeliveryOkCnt);
		model.addAttribute("orderListOnlyReturnCnt", orderListOnlyReturnCnt);
	}

	@Override
	public int getUserLevel(int user_idx) {
		return userDAO.getUserLevel(user_idx);
	}

	@Override
	public void setWishlistInsert(int user_idx, int item_idx) {
		userDAO.setWishlistInsert(user_idx,item_idx);
	}

	@Override
	public ArrayList<WishlistVO> getUserWishList(int user_idx) {
		return userDAO.getUserWishList(user_idx);
	}

	@Override
	public void setWishlistDelete(int user_idx, int item_idx) {
		userDAO.setWishlistDelete(user_idx,item_idx);
	}

	@Override
	public ArrayList<WishlistVO> getUserWishListJoinItem(int user_idx) {
		return userDAO.getUserWishListJoinItem(user_idx);
	}

	@Override
	public ArrayList<CouponVO> getUserCouponListAll(int user_idx) {
		return userDAO.getUserCouponListAll(user_idx);
	}

	@Override
	public void setRecentViewsInsert(int user_idx, int item_idx) {
		userDAO.setRecentViewsInsert(user_idx,item_idx);
	}

	@Override
	public ArrayList<RecentViewsVO> getRecentViews(int user_idx, int limit) {
		return userDAO.getRecentViews(user_idx, limit);
	}

	@Override
	public void setRecentViewsDelete(int user_idx, int item_idx) {
		userDAO.setRecentViewsDelete(user_idx, item_idx);
	}

	@Override
	public int getUserInforCountByTel(UserVO userVO) {
		return userDAO.getUserInforCountByTel(userVO);
	}

	@Override
	public UserVO getUserInforFind(UserVO vo) {
		return userDAO.getUserInforFind(vo);
	}

	@Override
	public UserVO getUserInforPwdFind(UserVO vo) {
		return userDAO.getUserInforPwdFind(vo);
	}

	@Override
	public void userLevelUp(UserVO userVO) {
		UserVO user = new UserVO();
		if (userVO.getUser_idx() != null) {
			user = userDAO.getUserInforIdx(userVO.getUser_idx());
		} else if (userVO.getUser_id() != null && !userVO.getUser_id().equals("")) {
			user = userDAO.getUserInfor(userVO.getUser_id());
		} else {
			return;
		}
		
		if (user.getLevel() == 2 
				&& (user.getLogin_count() >= 50 && user.getBuy_count() >= 10 && user.getBuy_price() >= 300000)) {
			user.setLevel(user.getLevel() - 1);
			userAdminService.updateUser(user);
		}
	}

	@Override
	public UserVO getUserJoinCheck(String user_id) {
		return userDAO.getUserJoinCheck(user_id);
	}

	@Override
	public void setKakaoUserJoinOk(UserVO userVO) {
		userDAO.setKakaoUserJoinOk(userVO);
	}

}
