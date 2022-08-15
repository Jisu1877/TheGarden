package com.spring.javagreenS_ljs.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javagreenS_ljs.dao.ItemAdminDAO;
import com.spring.javagreenS_ljs.dao.OrderAdminDAO;

@Service
public class PagingProcess {
	
	@Autowired
	ItemAdminDAO itemAdminDAO;
	
	@Autowired
	OrderAdminDAO orderAdminDAO;
	
	public PageVO pageProcess(String flag, int pag) {
		PageVO pageVO = new PageVO();
		//페이징처리를 위한 준비...
		int totRecCnt = 0;
//		if(flag.equals("member")) {
//			totRecCnt = memberDAO.totRecCnt();
//			pageVO.setTotRecCnt(totRecCnt);
//		}
//		else if(flag.equals("guest")) {
//			totRecCnt = guestDAO.totRecCnt();
//			pageVO.setTotRecCnt(totRecCnt);
//		}
		
		pageVO.setPageSize(5);
		pageVO.setTotPage((totRecCnt % pageVO.getPageSize()) == 0 ? totRecCnt / pageVO.getPageSize() : (totRecCnt / pageVO.getPageSize()) + 1);
		int startIndexNo = (pag - 1) * pageVO.getPageSize();
		int curScrStartNo = pageVO.getTotRecCnt() - startIndexNo;
		
		int blockSize = 3;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (pageVO.getTotPage() % blockSize) == 0 ? (pageVO.getTotPage() / blockSize) - 1 : (pageVO.getTotPage() / blockSize);
		
		pageVO.setPag(pag);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		
		return pageVO;
	}
	
	// 인자 : 1.pag 번호 2. page크기 3.소속(예:게시판-board) 4.분류 5.검색어
	public PageVO pageProcess2(int pag, int pageSize, String section, String part, String search, String searchValue, String start, String end) {
		PageVO pageVO = new PageVO();
		
		int totRecCnt = 0;
		int blockSize = 3;

		if(section.equals("adminOrder")) {
			if(!part.equals("0") && search.equals("") && start.equals("")){
				//part를 골랐는데 상세검색은 안했을 때
				String code = part;
				totRecCnt = orderAdminDAO.totCodeRecCnt(code);
			}
			else if(part.equals("0") && !search.equals("") && start.equals("")) {
				//part를 안골랐는데 상세검색 중 상세 조건만 검색일 때
				totRecCnt = orderAdminDAO.totSearchRecCnt1(search,searchValue);
			}
			else if(part.equals("0") && search.equals("") && !start.equals("")) {
				//part를 안골랐는데 상세검색 중 조회 기간 검색일 때
				totRecCnt = orderAdminDAO.totTermRecCnt1(start,end);
			}
			else if(part.equals("0") && !search.equals("") && !start.equals("")) {
				//part를 안골랐는데 상세검색 중 조회 기간, 상세 조건 모두 검색일 때
				totRecCnt = orderAdminDAO.totALLRecCnt1(search, searchValue, start, end);
			}
			else if(!part.equals("0") && !search.equals("") && start.equals("")) {
				//part를 골랐는데 상세검색 중 상세 조건만 검색일 때
				String code = part;
				totRecCnt = orderAdminDAO.totSearchRecCnt2(search,searchValue,code);
			}
			else if(!part.equals("0") && search.equals("") && !start.equals("")) {
				//part를 골랐는데 상세검색 중 조회 기간 검색일 때
				String code = part;
				totRecCnt = orderAdminDAO.totTermRecCnt2(start,end,code);
			}
			else if(!part.equals("0") && !search.equals("") && !start.equals("")) {
				//part를 골랐는데 상세검색 중 조회 기간, 상세 조건 모두 검색일 때
				String code = part;
				totRecCnt = orderAdminDAO.totALLRecCnt2(search, searchValue, start, end, code);
			}
			else {
				totRecCnt = orderAdminDAO.totRecCnt();
			}
		}
		else if(section.equals("orderDelivery")) {
			String code = part;
			totRecCnt = orderAdminDAO.totCodeRecCnt(code);
		}
		
		pageVO.setTotPage((totRecCnt % pageSize) == 0 ? totRecCnt / pageSize : (totRecCnt / pageSize) + 1);
		int startIndexNo = (pag - 1) * pageSize;
		int curScrStartNo = totRecCnt - startIndexNo;
		int curBlock = (pag - 1) / blockSize;
		int lastBlock = (pageVO.getTotPage() % blockSize) == 0 ? (pageVO.getTotPage() / blockSize) - 1 : (pageVO.getTotPage() / blockSize);
		int curBlockStartPage = curBlock * blockSize + 1;
		int curBlockEndPage = curBlockStartPage + blockSize - 1;
		if (curBlockEndPage > totRecCnt) {
			curBlockEndPage = totRecCnt;
		}
		
		pageVO.setPageSize(pageSize);
		pageVO.setPag(pag);
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(blockSize);
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(part);
		pageVO.setCurBlockStartPage(curBlockStartPage);
		pageVO.setCurBlockEndPage(curBlockEndPage);
		
		return pageVO;
	}
	
	public void pageProcess3(PageVO pageVO, int totRecCnt) {
		if (pageVO != null) {
			if (pageVO.getPageSize() == null || pageVO.getPageSize() == 0) {
				pageVO.setPageSize(10);
			}
			if (pageVO.getBlockSize() == null || pageVO.getBlockSize() == 0) {
				pageVO.setBlockSize(3);
			}
			if (pageVO.getPag() == null || pageVO.getPag() == 0) {
				pageVO.setPag(1);
			}
		}
		
		pageVO.setTotPage((totRecCnt % pageVO.getPageSize()) == 0 ? totRecCnt / pageVO.getPageSize() : (totRecCnt / pageVO.getPageSize()) + 1);
		int startIndexNo = (pageVO.getPag() - 1) * pageVO.getPageSize();
		int curScrStartNo = totRecCnt - startIndexNo;
		int curBlock = (pageVO.getPag() - 1) / pageVO.getBlockSize();
		int lastBlock = (pageVO.getTotPage() % pageVO.getBlockSize()) == 0 ? (pageVO.getTotPage() / pageVO.getBlockSize()) - 1 : (pageVO.getTotPage() / pageVO.getBlockSize());
		int curBlockStartPage = curBlock * pageVO.getBlockSize() + 1;
		int curBlockEndPage = curBlockStartPage + pageVO.getBlockSize() - 1;
		if (curBlockEndPage > pageVO.getTotPage()) {
			curBlockEndPage = pageVO.getTotPage();
		}
		
		pageVO.setTotRecCnt(totRecCnt);
		pageVO.setPageSize(pageVO.getPageSize());
		pageVO.setPag(pageVO.getPag());
		pageVO.setStartIndexNo(startIndexNo);
		pageVO.setCurScrStartNo(curScrStartNo);
		pageVO.setBlockSize(pageVO.getBlockSize());
		pageVO.setCurBlock(curBlock);
		pageVO.setLastBlock(lastBlock);
		pageVO.setPart(pageVO.getPart());
		pageVO.setCurBlockStartPage(curBlockStartPage);
		pageVO.setCurBlockEndPage(curBlockEndPage);
	}
	
}
