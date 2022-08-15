package com.spring.javagreenS_ljs.pagination;

import lombok.Data;

@Data
public class PageVO {
	private Integer pageSize;
	private Integer totRecCnt;
	private Integer totPage;
	private Integer startIndexNo;
	private Integer curScrStartNo;
	private Integer blockSize;
	private Integer curBlock;
	private Integer lastBlock;
	private Integer pag;
	private Integer curBlockStartPage;
	private Integer curBlockEndPage;

	private String part; // 검색 조건
}
