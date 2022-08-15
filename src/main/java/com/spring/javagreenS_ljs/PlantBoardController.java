package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javagreenS_ljs.pagination.PageVO;
import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.pagination.SearchVO;
import com.spring.javagreenS_ljs.service.PlantBoardService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.PlantBoardReplyVO;
import com.spring.javagreenS_ljs.vo.PlantBoardVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/plant")
public class PlantBoardController {
	
	@Autowired
	UserService userService;
	
	@Autowired
	PlantBoardService plantBoardService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	// 반려식물 클리닉 게시판 리스트	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String boardOpenGet(PlantBoardVO searchVO, Model model, HttpSession session) {
		String uesr_id = (String) session.getAttribute("sUser_id");
		if(uesr_id != null) {
			int level = (int) session.getAttribute("sLevel");
			model.addAttribute("level", level);
		}
		
		//페이징
		int totCnt = plantBoardService.getBoardTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		ArrayList<PlantBoardVO> boardList = plantBoardService.getBoardList(searchVO);
		model.addAttribute("boardList", boardList);
		model.addAttribute("searchVO", searchVO);
		return "plantBoard/boardList";
	}
	
	//글쓰기 창으로 호출
	@RequestMapping(value = "/boardInsert", method = RequestMethod.GET)
	public String boardInsertGet(HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		
		model.addAttribute("userVO", userVO);
		return "plantBoard/boardInsert";
	}
	
	//글 등록
	@RequestMapping(value = "/boardInsert", method = RequestMethod.POST)
	public String boardInsertPost(PlantBoardVO vo) {
		
		//content에 이미지가 저장되어있다면, 저장된 이미지만을 /resources/data/ckeditor/plantBoard/ 폴더에 저장시켜준다.
		plantBoardService.imgCheck(vo.getContent());
		
		//이미지 복사작업이 끝나면, itemContent폴더에 실제로 저장될 파일명을 DB에 저장시켜준다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/plantBoard/"));
		
		//글 등록 처리
		plantBoardService.setBoardInsert(vo);
		
		return "redirect:/msg/plantBoardInsert";
	}
	
	//글 조회
	@RequestMapping(value = "/showcontent", method = RequestMethod.GET)
	public String showcontentGet(@RequestParam int idx, Model model, PlantBoardVO searchVO, HttpSession session) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		String user_id = (String) session.getAttribute("sUser_id");
		int sLevel = (int) session.getAttribute("sLevel");
		
		//글 정보 가져오기
		PlantBoardVO vo = plantBoardService.getBoardContent(idx);
		
		//댓글 정보 가져오기
		ArrayList<PlantBoardReplyVO> boardReplyList = plantBoardService.getBoardReplyList(idx);
		
		//이전 글, 다음 글 정보 가져오기
		PlantBoardVO preVO = plantBoardService.getPreBoardContent(idx);
		PlantBoardVO nextVO = plantBoardService.getNextBoardContent(idx);
		
		//조회수 up처리
		plantBoardService.setBoardViewsUp(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("preVO", preVO);
		model.addAttribute("nextVO", nextVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("user_idx", user_idx);
		model.addAttribute("user_id", user_id);
		model.addAttribute("sLevel", sLevel);
		model.addAttribute("boardReplyList", boardReplyList);
		return "plantBoard/content";
	}
	
	
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx) {
		//해당 글 삭제(업데이트) 처리
		plantBoardService.setBoardDelete(idx);
		
		return "redirect:/msg/plantBoardDeleteOk2";
	}
	
	//글 수정 창 호출(회원글)
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.GET)
	public String boardUpdateGet(int idx, Model model) {
		//글 정보 가져오기
		PlantBoardVO vo = plantBoardService.getBoardContent(idx);
		
		model.addAttribute("vo", vo);
		return "plantBoard/boardUpdate";
	}
	
	//글 수정 처리(회원글)
	@RequestMapping(value = "/boardUpdate", method = RequestMethod.POST)
	public String boardUpdatePost(PlantBoardVO searchVO, int plant_board_idx, Model model) {
		//수정전 content 알아오기
		PlantBoardVO oriVO =  plantBoardService.getBoardContent(plant_board_idx);
		
		if(!oriVO.getContent().equals(searchVO.getContent())) {
			//plantBoard 폴더에 복사되어있는 이미지들 중 해당 idx 의 Admin_content 이미지인 경우 삭제처리한다.
			//먼저 삭제를 싹 해주고 다시 복사저장해줄 계획.
			if(oriVO.getContent().indexOf("src=\"/") != -1) { //이미지 파일이 1개라도 content에 있을 시!
				plantBoardService.imgDelete(oriVO.getContent());
			}
			//파일 복사 전에 원본파일의 위치가 'ckeditor/plantBoard'폴더였던 것을 'ckeditor'폴더로 변경시켜두어야 한다.
			searchVO.setContent(searchVO.getContent().replace("/data/ckeditor/plantBoard/", "/data/ckeditor/"));
			
			//앞의 준비작업이 완료되면, 수정된 그림(복사된그림)을 다시 plantBoard폴더에 복사처리한다.(/data/ckeditor/ -> /data/ckeditor/plantBoard/)
			//이 작업은 처음 게시글을 올릴 때의 파일복사 작업과 동일한 작업이다.
			plantBoardService.imgCheck(searchVO.getContent());
			
			//복사가 완료되었기에 다시 content의 경로를 바꿔준다.
			searchVO.setContent(searchVO.getContent().replace("/data/ckeditor/", "/data/ckeditor/plantBoard/"));
		}
		
		searchVO.setPlant_board_idx(plant_board_idx);
		//수정 내용 DB 저장 작업
		plantBoardService.setBoardUpdate(searchVO);
		
		model.addAttribute("msg", "수정이 완료되었습니다.");
		model.addAttribute("url", "plant/showcontent?idx=" + plant_board_idx);
		
		return "redirect:/msg";
	}
	
	//관리자 공지 등록 창 호출
	@RequestMapping(value = "/boardAdminInsert", method = RequestMethod.GET)
	public String boardAdminInsertGet(HttpSession session, Model model) {
		int user_idx = (int) session.getAttribute("sUser_idx");
		//회원정보 가져오기
		UserVO userVO = userService.getUserInforIdx(user_idx);
		
		model.addAttribute("userVO", userVO);
		return "plantBoard/boardAdminInsert";
	}
	
	//글 등록
	@RequestMapping(value = "/boardAdminInsert", method = RequestMethod.POST)
	public String boardAdminInsertPost(PlantBoardVO vo) {
		//content에 이미지가 저장되어있다면, 저장된 이미지만을 /resources/data/ckeditor/plantBoard/ 폴더에 저장시켜준다.
		plantBoardService.imgCheck(vo.getContent());
		
		//이미지 복사작업이 끝나면, itemContent폴더에 실제로 저장될 파일명을 DB에 저장시켜준다.
		vo.setContent(vo.getContent().replace("/data/ckeditor/", "/data/ckeditor/plantBoard/"));
		
		//글 등록 처리
		plantBoardService.setBoardAdminInsert(vo);
		
		return "redirect:/msg/plantBoardAdminInsert";
	}
	
	
	//공지글 조회
	@RequestMapping(value = "/showNoticeContent", method = RequestMethod.GET)
	public String showNoticeContentGet(@RequestParam int idx, Model model, PlantBoardVO searchVO, HttpSession session) {
		int level = (int) session.getAttribute("sLevel");
		
		//글 정보 가져오기
		PlantBoardVO vo = plantBoardService.getBoardContent(idx);
		
		//이전 글, 다음 글 정보 가져오기
		PlantBoardVO preVO = plantBoardService.getPreBoardContent(idx);
		PlantBoardVO nextVO = plantBoardService.getNextBoardContent(idx);
		
		//조회수 up처리
		plantBoardService.setBoardViewsUp(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("preVO", preVO);
		model.addAttribute("nextVO", nextVO);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("level", level);
		return "plantBoard/noticeContent";
	}
	
	//글 수정 창 호출(공지글)
	@RequestMapping(value = "/boardNoticeUpdate", method = RequestMethod.GET)
	public String boardNoticeUpdateGet(int idx, Model model) {
		//글 정보 가져오기
		PlantBoardVO vo = plantBoardService.getBoardContent(idx);
		
		model.addAttribute("vo", vo);
		return "plantBoard/boardNoticeUpdate";
	}
	
	//글 수정 처리(공지글)
	@RequestMapping(value = "/boardNoticeUpdate", method = RequestMethod.POST)
	public String boardNoticeUpdatePost(PlantBoardVO searchVO, int plant_board_idx, Model model) {
		//수정전 content 알아오기
		PlantBoardVO oriVO =  plantBoardService.getBoardContent(plant_board_idx);
		
		if(!oriVO.getContent().equals(searchVO.getContent())) {
			//plantBoard 폴더에 복사되어있는 이미지들 중 해당 idx 의 Admin_content 이미지인 경우 삭제처리한다.
			//먼저 삭제를 싹 해주고 다시 복사저장해줄 계획.
			if(oriVO.getContent().indexOf("src=\"/") != -1) { //이미지 파일이 1개라도 content에 있을 시!
				plantBoardService.imgDelete(oriVO.getContent());
			}
			//파일 복사 전에 원본파일의 위치가 'ckeditor/plantBoard'폴더였던 것을 'ckeditor'폴더로 변경시켜두어야 한다.
			searchVO.setContent(searchVO.getContent().replace("/data/ckeditor/plantBoard/", "/data/ckeditor/"));
			
			//앞의 준비작업이 완료되면, 수정된 그림(복사된그림)을 다시 plantBoard폴더에 복사처리한다.(/data/ckeditor/ -> /data/ckeditor/plantBoard/)
			//이 작업은 처음 게시글을 올릴 때의 파일복사 작업과 동일한 작업이다.
			plantBoardService.imgCheck(searchVO.getContent());
			
			//복사가 완료되었기에 다시 content의 경로를 바꿔준다.
			searchVO.setContent(searchVO.getContent().replace("/data/ckeditor/", "/data/ckeditor/plantBoard/"));
		}
		
		searchVO.setPlant_board_idx(plant_board_idx);
		
		//수정 내용 DB 저장 작업
		plantBoardService.setBoardNoticeUpdate(searchVO);
		
		model.addAttribute("msg", "수정이 완료되었습니다.");
		model.addAttribute("url", "plant/showNoticeContent?idx=" + plant_board_idx);
		
		return "redirect:/msg";
	}
	
	//댓글 등록
	@ResponseBody
	@RequestMapping(value = "/boardReplyInsert", method = RequestMethod.POST)
	public String boardReplyInsertPost(PlantBoardReplyVO vo) {
		String maxLevelOrder = plantBoardService.getMaxLevelOrder(vo);
		int levelOrder = 0;
		
		if(maxLevelOrder != null) {
			levelOrder = Integer.parseInt(maxLevelOrder) + 1;
		}
		vo.setLevelOrder(levelOrder);
		vo.setLevel(0);
		vo.setParents(0);
		
		plantBoardService.setBoardReplyInsert(vo);
		
		return "1";
	}
	
	//대댓글 등록
	@ResponseBody
	@RequestMapping(value = "/boardReplyAnswerInsert", method = RequestMethod.POST)
	public String boardReplyAnswerInsertPost(PlantBoardReplyVO vo) {
		//부모댓글의 levelOrder 값보다 큰 모든 댓글의 levelOrder 값을 +1 시켜준다.
		plantBoardService.setLevelOrderPlusUpdate(vo);
		
		vo.setLevel(vo.getLevel() + 1); //대댓글의 level은 부모 level보다 +1
		vo.setLevelOrder(vo.getLevelOrder() + 1); //대댓글의 levelOrder는 부모 levelOrder보다 +1
		//vo.setParents()
		
		//대댓글 등록처리
		plantBoardService.setBoardReplyInsert(vo);
		return "1";
	}
	
	
	//댓글 삭제
	@ResponseBody
	@RequestMapping(value = "/replyDelete", method = RequestMethod.POST)
	public String replyDeletePost(PlantBoardReplyVO vo) {
		//자식 댓글이 있는지 확인하기
		ArrayList<PlantBoardReplyVO> childReplyList = plantBoardService.getChildReplyList(vo);
		
		if(childReplyList.isEmpty()) {
			//진짜 삭제 처리
			plantBoardService.setReplyDeleteReal(vo);
		}
		else {
			//삭제 플래그 처리
			plantBoardService.setReplyDelete(vo);
		}
		
		return "1";
	}
}
