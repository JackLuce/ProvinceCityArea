package com.entity;

/**
 * 市
 */
public class City {

    /**
     * id
     */
    private Integer id;

    /**
     * 市id
     */
    private String cityId;

    /**
     * 市名
     */
    private String city;

    /**
     * 上级id
     */
    private String fatherId;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getCityId() {
        return cityId;
    }

    public void setCityId(String cityId) {
        this.cityId = cityId;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getfatherId() {
        return fatherId;
    }

    public void setfatherId(String father) {
        this.fatherId = father;
    }

    @Override
    public String toString() {
        return "City{" +
                "id=" + id +
                ", cityId='" + cityId + '\'' +
                ", city='" + city + '\'' +
                ", fatherId='" + fatherId + '\'' +
                '}';
    }
}
