package com.star.seat.store.dto;

import org.springframework.web.multipart.MultipartFile;

public class StoreDto {
	private int num;
	private String owner;
	private String storeName;
	private String storeAddr;
	private String storePhone;
	private String storeTag;
	private String openingTime;
	private String image_logo;
	private String image_1;
	private String image_2;
	private String image_3;
	private String image_4;
	private String storeOpen;
	private String imageCheck;
	private String category;
	private String regdate;
	private String area;
	private String group;
	private String keyword;
	private MultipartFile imageFile;
	private float avgStar;
	private int reviewCount;
	private int startRowNum;
	private int endRowNum;
	
	public StoreDto() {
	
	}

	public StoreDto(int num, String owner, String storeName, String storeAddr, String storePhone, String storeTag,
			String openingTime, String image_logo, String image_1, String image_2, String image_3, String image_4,
			String storeOpen, String imageCheck, String category, String regdate, String area, String group,
			String keyword, MultipartFile imageFile, float avgStar, int reviewCount, int startRowNum, int endRowNum) {
		super();
		this.num = num;
		this.owner = owner;
		this.storeName = storeName;
		this.storeAddr = storeAddr;
		this.storePhone = storePhone;
		this.storeTag = storeTag;
		this.openingTime = openingTime;
		this.image_logo = image_logo;
		this.image_1 = image_1;
		this.image_2 = image_2;
		this.image_3 = image_3;
		this.image_4 = image_4;
		this.storeOpen = storeOpen;
		this.imageCheck = imageCheck;
		this.category = category;
		this.regdate = regdate;
		this.area = area;
		this.group = group;
		this.keyword = keyword;
		this.imageFile = imageFile;
		this.avgStar = avgStar;
		this.reviewCount = reviewCount;
		this.startRowNum = startRowNum;
		this.endRowNum = endRowNum;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getStoreAddr() {
		return storeAddr;
	}

	public void setStoreAddr(String storeAddr) {
		this.storeAddr = storeAddr;
	}

	public String getStorePhone() {
		return storePhone;
	}

	public void setStorePhone(String storePhone) {
		this.storePhone = storePhone;
	}

	public String getStoreTag() {
		return storeTag;
	}

	public void setStoreTag(String storeTag) {
		this.storeTag = storeTag;
	}

	public String getOpeningTime() {
		return openingTime;
	}

	public void setOpeningTime(String openingTime) {
		this.openingTime = openingTime;
	}

	public String getImage_logo() {
		return image_logo;
	}

	public void setImage_logo(String image_logo) {
		this.image_logo = image_logo;
	}

	public String getImage_1() {
		return image_1;
	}

	public void setImage_1(String image_1) {
		this.image_1 = image_1;
	}

	public String getImage_2() {
		return image_2;
	}

	public void setImage_2(String image_2) {
		this.image_2 = image_2;
	}

	public String getImage_3() {
		return image_3;
	}

	public void setImage_3(String image_3) {
		this.image_3 = image_3;
	}

	public String getImage_4() {
		return image_4;
	}

	public void setImage_4(String image_4) {
		this.image_4 = image_4;
	}

	public String getStoreOpen() {
		return storeOpen;
	}

	public void setStoreOpen(String storeOpen) {
		this.storeOpen = storeOpen;
	}

	public String getImageCheck() {
		return imageCheck;
	}

	public void setImageCheck(String imageCheck) {
		this.imageCheck = imageCheck;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getRegdate() {
		return regdate;
	}

	public void setRegdate(String regdate) {
		this.regdate = regdate;
	}

	public String getArea() {
		return area;
	}

	public void setArea(String area) {
		this.area = area;
	}

	public String getGroup() {
		return group;
	}

	public void setGroup(String group) {
		this.group = group;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	public MultipartFile getImageFile() {
		return imageFile;
	}

	public void setImageFile(MultipartFile imageFile) {
		this.imageFile = imageFile;
	}

	public float getAvgStar() {
		return avgStar;
	}

	public void setAvgStar(float avgStar) {
		this.avgStar = avgStar;
	}

	public int getReviewCount() {
		return reviewCount;
	}

	public void setReviewCount(int reviewCount) {
		this.reviewCount = reviewCount;
	}

	public int getStartRowNum() {
		return startRowNum;
	}

	public void setStartRowNum(int startRowNum) {
		this.startRowNum = startRowNum;
	}

	public int getEndRowNum() {
		return endRowNum;
	}

	public void setEndRowNum(int endRowNum) {
		this.endRowNum = endRowNum;
	}
	
}
