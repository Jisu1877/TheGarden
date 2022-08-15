package com.spring.javagreenS_ljs.dao;

import java.util.ArrayList;

import org.apache.ibatis.annotations.Param;

import com.spring.javagreenS_ljs.vo.CategoryGroupVO;
import com.spring.javagreenS_ljs.vo.CategoryVO;

public interface CategoryDAO {
	
	public CategoryGroupVO getCategoryGroupInfor(@Param("category_group_code") String category_group_code);

	public void setCategoryGroup(@Param("vo") CategoryGroupVO vo);

	public ArrayList<CategoryGroupVO> getCategoryGroupInfor2();

	public void setCategoryUseNot(@Param("category_group_idx") int category_group_idx);

	public void setCategoryLevelSort(@Param("changeLevel") int changeLevel, @Param("changeValue") int changeValue);

	public int getCategoryMaxLevel();

	public void setCategoryUse(@Param("vo") CategoryGroupVO vo);

	public CategoryGroupVO getCategoryGroupInfor3(@Param("category_group_level") int category_group_level);

	public void setCategoryUpate(@Param("vo") CategoryGroupVO vo);

	public void setCategoryGroupDelete(@Param("category_group_idx") int category_group_idx);

	public void setCategory(@Param("vo") CategoryVO vo);

	public ArrayList<CategoryVO> getCategoryInfor(@Param("idx") int idx);

	public ArrayList<CategoryGroupVO> getCategoryGroupInforOnlyUse();

	public String getCategoryGroupCode(@Param("category_group_idx") int category_group_idx);

	public ArrayList<CategoryVO> getCategoryOnlyUseInfor(@Param("idx") int idx);

	public void setCategoryDelete(@Param("category_idx") int category_idx);

	public CategoryVO getCategoryInfor2(@Param("category_idx") int category_idx);

	public Object setCategoryUseNot2(@Param("category_idx") int category_idx);

	public void setCategoryUpate2(@Param("category_idx") int category_idx,@Param("category_name") String category_name);

	public void setCategoryUse2(@Param("category_idx") int category_idx);


}
