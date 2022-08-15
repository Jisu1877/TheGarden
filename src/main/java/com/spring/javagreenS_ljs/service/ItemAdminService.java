package com.spring.javagreenS_ljs.service;

import java.util.ArrayList;

import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemOptionVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

public interface ItemAdminService {

	public void imgCheck(String detail_content);

	public void setItemInsert(ItemVO itemVO, MultipartHttpServletRequest multipart);

	public ArrayList<ItemVO> getItemSearch(String string, String item_name);

	public ArrayList<ItemVO> getItemAllInforOnlyDisplay();

	public ArrayList<ItemVO> getItemList();

	public ItemVO getItemSameSearch(String searchString, String searchValue);

	public ArrayList<ItemOptionVO> getItemOptionInfor(int item_idx);

	public ArrayList<ItemImageVO> getItemImageInfor(int item_idx);

	public void setItemImageDelete(int item_image_idx, String image_name);

	public void imgCheckUpdate(String detail_content);

	public ItemVO getItemContent(int item_idx);

	public void imgDelete(String detail_content);

	public void setItemUpdate(ItemVO itemVO, MultipartHttpServletRequest multipart, String item_image);

	public void setItemDelete(String item_code);

	public void setItemDisplayUpdate(int item_idx, String flag);

	public void setdeleteOption(int item_option_idx);

	public ArrayList<ItemVO> getBestItemAllInforOnlyDisplay();

	public ArrayList<ItemVO> getItemListSearch(ItemVO itemVO);

	public int totRecCnt(ItemVO itemVO);

	public ArrayList<ItemVO> getItemPopularitySort();

	public ArrayList<ItemVO> getItemSaleSort();

	public ArrayList<ItemVO> getItemLowPriceSort();

	public ArrayList<ItemVO> getItemNewSort();

	public ArrayList<ItemVO> getItemLotsReviewsSort();

	public ArrayList<ItemVO> getItemRatingSort();

	public int getItemIdx(String item_code);
}
