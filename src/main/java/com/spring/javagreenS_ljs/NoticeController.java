package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.NoticeService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.NoticeVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/notice")
public class NoticeController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	NoticeService noticeService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	//공지사항 관리 창 호출
	@RequestMapping(value = "/noticeList", method = RequestMethod.GET)
	public String noticeListGet(NoticeVO searchVO, HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		model.addAttribute("userVO", userVO);
		
		//페이징
		int totCnt = noticeService.getNoticeTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		ArrayList<NoticeVO> noticeList = noticeService.getNoticeList(searchVO);
		
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("noticeList", noticeList);
		return "admin/notice/noticeList";
	}
	
	//공지 등록 창 호출
	@RequestMapping(value = "/noticeInsert", method = RequestMethod.GET)
	public String noticeInsertGet(HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		
		model.addAttribute("userVO", userVO);
		return "admin/notice/noticeInsert";
	}
	
	//공지 등록 처리
	@RequestMapping(value = "/noticeInsert", method = RequestMethod.POST)
	public String noticeInsertPost(MultipartHttpServletRequest file, NoticeVO vo) {
		//content에 이미지가 저장되어있다면, 저장된 이미지만을 /resources/data/ckeditor/plantBoard/ 폴더에 저장시켜준다.
		noticeService.imgCheck(vo.getNotice_content());
		
		//이미지 복사작업이 끝나면, itemContent폴더에 실제로 저장될 파일명을 DB에 저장시켜준다.
		vo.setNotice_content(vo.getNotice_content().replace("/data/ckeditor/", "/data/ckeditor/notice/"));
		
		//글 등록 처리
		noticeService.setNoticeInsert(file, vo);
		
		return "redirect:/msg/noticeInsertOk";
	}
	
	// 공지사항 팝업을 호출하는 메소드
	@RequestMapping(value="/popup", method=RequestMethod.GET)
	public String popupGet(int notice_idx, Model model) {
		NoticeVO vo = noticeService.getNoticeInfor(notice_idx);  // idx로 검색된 공지사항의 정보를 가져온다.(가져온 정보는 무조건 popupSw가 'Y'로 되어 있다)
		model.addAttribute("vo", vo);
		return "notice/popup";
	}
	
	//공지사항 창 호출
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String noticeList(NoticeVO searchVO, Model model) {
		// 페이징
		int totCnt = noticeService.getNoticeTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);

		ArrayList<NoticeVO> noticeList = noticeService.getNoticeList(searchVO);

		model.addAttribute("searchVO", searchVO);
		model.addAttribute("noticeList", noticeList);
		return "notice/list";
	}
	
	@RequestMapping(value = "/showcontent", method = RequestMethod.GET)
	public String noticeView(@ModelAttribute("searchVO") NoticeVO searchVO, Model model) {
		//공지 내용 가져오기
		NoticeVO noticeVO = noticeService.getNoticeInfor(searchVO.getNotice_idx());
		
		//조회수 Up처리
		noticeService.setViewsUp(searchVO.getNotice_idx());
		
		model.addAttribute("vo", noticeVO);
		return "notice/content";
	}
	
	//공지사항 수정 창 호출
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.GET)
	public String noticeUpdateGet(NoticeVO noticeVO, Model model, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		model.addAttribute("userVO", userVO);
		
		NoticeVO vo = noticeService.getNoticeInfor(noticeVO.getNotice_idx());
		model.addAttribute("vo", vo);
		return "admin/notice/noticeUpdate";
	}
	
	//공지사항 수정 처리
	@RequestMapping(value = "/noticeUpdate", method = RequestMethod.POST)
	public String noticeUpdatePost(MultipartHttpServletRequest file, NoticeVO noticeVO, Model model) {
		//수정 전 content 알아오기
		NoticeVO oriVO = noticeService.getNoticeInfor(noticeVO.getNotice_idx());
		
		if(!oriVO.getNotice_content().equals(noticeVO.getNotice_content())) {
			//notice 폴더에 복사되어있는 이미지들 중 해당 idx 의 Admin_content 이미지인 경우 삭제처리한다.
			//먼저 삭제를 싹 해주고 다시 복사저장해줄 계획.
			if(oriVO.getNotice_content().indexOf("src=\"/") != -1) { //이미지 파일이 1개라도 content에 있을 시!
				noticeService.imgDelete(oriVO.getNotice_content());
			}
			//파일 복사 전에 원본파일의 위치가 'ckeditor/notice'폴더였던 것을 'ckeditor'폴더로 변경시켜두어야 한다.
			noticeVO.setNotice_content(noticeVO.getNotice_content().replace("/data/ckeditor/notice/", "/data/ckeditor/"));
			
			//앞의 준비작업이 완료되면, 수정된 그림(복사된그림)을 다시 plantBoard폴더에 복사처리한다.(/data/ckeditor/ -> /data/ckeditor/notice/)
			//이 작업은 처음 게시글을 올릴 때의 파일복사 작업과 동일한 작업이다.
			noticeService.imgCheck(noticeVO.getNotice_content());
			
			//복사가 완료되었기에 다시 content의 경로를 바꿔준다.
			noticeVO.setNotice_content(noticeVO.getNotice_content().replace("/data/ckeditor/", "/data/ckeditor/notice/"));
		}
		
		//DB저장 작업
		noticeService.noticeUpdate(file, noticeVO, oriVO);
		
		return "redirect:/msg/noticeUpdateOk";
	}
	
	
	//공지사항 삭제
	@RequestMapping(value = "/noticeDelete", method = RequestMethod.GET)
	public String noticeDeleteGet(NoticeVO vo) {
		//삭제처리
		noticeService.setNoticeDelete(vo);
		
		return "redirect:/msg/noticeDeleteOk";
	}
}
