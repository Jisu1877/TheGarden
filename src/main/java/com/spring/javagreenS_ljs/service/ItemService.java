package com.spring.javagreenS_ljs.service;

import com.spring.javagreenS_ljs.vo.ItemVO;

public interface ItemService {

	public int getStockquantity(int item_idx);

	public int getOptionStockquantity(int option_idx);

	public void setStockQuantityUpdate(int item_idx, int order_quantity);

	public ItemVO getItemInfor(int item_idx);

	public void setWishPlus(int item_idx);

	public void setWishMinus(int item_idx);

	public void setOptionStockQuantityUpdate(int option_idx, int quantity);
	
	public void setOptionSoldOutUpdate(int option_idx, String sold_out);

	public void setSoldOutUpdate(int item_idx, String sold_out);
	
	public void setOrderUpdate(int item_idx, int quantity);
}
