package com.spring.javagreenS_ljs;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javagreenS_ljs.pagination.PagingProcess;
import com.spring.javagreenS_ljs.service.PlantBoardService;
import com.spring.javagreenS_ljs.service.UserService;
import com.spring.javagreenS_ljs.vo.ItemVO;
import com.spring.javagreenS_ljs.vo.PlantBoardVO;
import com.spring.javagreenS_ljs.vo.UserVO;

@Controller
@RequestMapping("/admin/plant")
public class AdminPlantBoardController {
	
	@Autowired
	PlantBoardService plantBoardService;
	
	@Autowired
	PagingProcess pagingProcess;
	
	@Autowired
	UserService userService;
	
	
	@RequestMapping(value = "/boardList", method = RequestMethod.GET)
	public String adminPlantBoardListGet(PlantBoardVO searchVO, Model model, HttpSession session) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		//페이징
		int totCnt = plantBoardService.getBoardTotalCnt(searchVO);
		pagingProcess.pageProcess3(searchVO, totCnt);
		
		ArrayList<PlantBoardVO> boardList = plantBoardService.getBoardList(searchVO);
		model.addAttribute("boardList", boardList);
		model.addAttribute("searchVO", searchVO);
		model.addAttribute("userVO", userVO);
		return "admin/plantBoard/boardList";
	}
	
	@RequestMapping(value = "/adminAnswer", method = RequestMethod.GET)
	public String adminAnswerGet(PlantBoardVO searchVO, Model model, HttpSession session, int idx) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		//게시글 내용 가져오기
		PlantBoardVO vo = plantBoardService.getBoardContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		return "admin/plantBoard/adminAnswer";
	}
	
	@RequestMapping(value = "/adminAnswer", method = RequestMethod.POST)
	public String adminAnswerPost(PlantBoardVO searchVO, Model model, HttpSession session, int idx) {
		//content에 이미지가 저장되어있다면, 저장된 이미지만을 /resources/data/ckeditor/plantBoard/ 폴더에 저장시켜준다.
		plantBoardService.imgCheck(searchVO.getAdmin_content());
		
		//이미지 복사작업이 끝나면, itemContent폴더에 실제로 저장될 파일명을 DB에 저장시켜준다.
		searchVO.setAdmin_content(searchVO.getAdmin_content().replace("/data/ckeditor/", "/data/ckeditor/plantBoard/"));
		
		//답변 등록
		plantBoardService.setBoardAdminAnswer(searchVO);
		
		model.addAttribute("searchVO", searchVO);
		return "redirect:/msg/plantAdminAnswerOk";
	}
	
	@RequestMapping(value = "/boardDelete", method = RequestMethod.GET)
	public String boardDeleteGet(int idx) {
		
		//해당 글 삭제(업데이트) 처리
		plantBoardService.setBoardDelete(idx);
		
		return "redirect:/msg/plantBoardDeleteOk";
	}
	
	//관리자 답변 수정 창 호출
	@RequestMapping(value = "/adminAnswerUpdate", method = RequestMethod.GET)
	public String adminAnswerUpdateGet(PlantBoardVO searchVO, HttpSession session, int idx, Model model) {
		String user_id = (String) session.getAttribute("sUser_id");
		UserVO userVO = userService.getUserInfor(user_id);
		
		//게시글 내용 가져오기
		PlantBoardVO vo = plantBoardService.getBoardContent(idx);
		
		model.addAttribute("vo", vo);
		model.addAttribute("userVO", userVO);
		model.addAttribute("searchVO", searchVO);
		return "admin/plantBoard/adminUpdate";
	}
	
	//관리자 답변 수정 처리
	@RequestMapping(value = "/adminAnswerUpdate", method = RequestMethod.POST)
	public String adminAnswerUpdatePost(PlantBoardVO searchVO, HttpSession session, int idx, Model model) {
		//수정전 content 알아오기
		PlantBoardVO oriVO =  plantBoardService.getBoardContent(idx);
		if(!oriVO.getAdmin_content().equals(searchVO.getAdmin_content())) {
			//plantBoard 폴더에 복사되어있는 이미지들 중 해당 idx 의 Admin_content 이미지인 경우 삭제처리한다.
			//먼저 삭제를 싹 해주고 다시 복사저장해줄 계획.
			if(oriVO.getAdmin_content().indexOf("src=\"/") != -1) { //이미지 파일이 1개라도 content에 있을 시!
				plantBoardService.imgDelete(oriVO.getAdmin_content());
			}
			//파일 복사 전에 원본파일의 위치가 'ckeditor/plantBoard'폴더였던 것을 'ckeditor'폴더로 변경시켜두어야 한다.
			searchVO.setAdmin_content(searchVO.getAdmin_content().replace("/data/ckeditor/plantBoard/", "/data/ckeditor/"));
			
			//앞의 준비작업이 완료되면, 수정된 그림(복사된그림)을 다시 plantBoard폴더에 복사처리한다.(/data/ckeditor/ -> /data/ckeditor/plantBoard/)
			//이 작업은 처음 게시글을 올릴 때의 파일복사 작업과 동일한 작업이다.
			plantBoardService.imgCheck(searchVO.getAdmin_content());
			
			//복사가 완료되었기에 다시 content의 경로를 바꿔준다.
			searchVO.setAdmin_content(searchVO.getAdmin_content().replace("/data/ckeditor/", "/data/ckeditor/plantBoard/"));
		}
		
		//DB저장 작업
		plantBoardService.setBoardUpdateAdmin(searchVO, idx);
		
		return "redirect:/msg/plantBoardUpdateOk";
	}
}
