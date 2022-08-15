package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.CartVO;
import com.spring.javagreenS_ljs.vo.ItemImageVO;
import com.spring.javagreenS_ljs.vo.ItemOptionVO;
import com.spring.javagreenS_ljs.vo.ItemVO;

public interface ItemAdminDAO {

	public ItemVO getItemMaxIdx();

	public void setItemOption(@Param("maxIdx") int maxIdx, @Param("option_name") String option_name, @Param("option_price") String option_price, @Param("option_stock") String option_stock, @Param("option_sold_out") String option_sold_out);

	public void setItemImage(@Param("maxIdx") int maxIdx, @Param("sFileName") String sFileName);

	public void setItemInsert(@Param("itemVO") ItemVO itemVO);

	public void setItemImageChange(@Param("itemImage") String itemImage, @Param("maxIdx") int maxIdx);

	public void setItemNotice(@Param("maxIdx") int maxIdx, @Param("itemVO") ItemVO itemVO);

	public ArrayList<ItemVO> getItemSearch(@Param("searchString") String searchString,@Param("item_name") String item_name);

	public ArrayList<ItemVO> getItemAllInforOnlyDisplay();

	public ArrayList<ItemVO> getItemList();

	public ItemVO getItemSameSearch(@Param("searchString") String searchString, @Param("searchValue") String searchValue);

	public ArrayList<ItemOptionVO> getItemOptionInfor(@Param("item_idx") int item_idx);

	public ArrayList<ItemImageVO> getItemImageInfor(@Param("item_idx") int item_idx);

	public void setItemImageDelete(@Param("item_image_idx") int item_image_idx);

	public ItemVO getItemContent(@Param("item_idx") int item_idx);

	public void setItemUpdate(@Param("itemVO") ItemVO itemVO);

	public void setItemOptionDelete(@Param("item_idx") int item_idx);

	public void setItemImageDeleteName(@Param("item_image") String item_image);

	public void setItemNoticeUpdate(@Param("item_idx") int item_idx, @Param("itemVO") ItemVO itemVO);

	public void setItemDelete(@Param("item_code") String item_code);
	
	public void setItemDisplayUpdate(@Param("item_idx") int item_idx, @Param("flag") String flag);

	public void setdeleteOption(@Param("item_option_idx") int item_option_idx);

	public void setItemOptionUpdate(@Param("vo") ItemOptionVO vo);

	public ArrayList<ItemVO> getBestItemAllInforOnlyDisplay();

	public ArrayList<ItemVO> getItemListSearch(ItemVO itemVO);
	
	public int totRecCnt(ItemVO itemVO);

	public ArrayList<ItemVO> getItemPopularitySort();

	public ArrayList<ItemVO> getItemSaleSort();

	public ArrayList<ItemVO> getItemLowPriceSort();

	public ArrayList<ItemVO> getItemNewSort();

	public ArrayList<ItemVO> getItemLotsReviewsSort();

	public ArrayList<ItemVO> getItemRatingSort();

	public int getItemIdx(@Param("item_code") String item_code);

}
