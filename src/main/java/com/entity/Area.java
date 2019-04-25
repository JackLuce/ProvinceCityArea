package com.entity;

/**
 * 区县
 */
public class Area {

    /**
     * id
     */
    private Integer id;

    /**
     * 区县id
     */
    private String areaId;

    /**
     * 区、县
     */
    private String area;

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

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    public String getArea() {
        return area;
    }

    public void setArea(String area) {
        this.area = area;
    }

    public String getfatherId() {
        return fatherId;
    }

    public void setfatherId(String fatherId) {
        this.fatherId = fatherId;
    }

    @Override
    public String toString() {
        return "Province{" +
                "id=" + id +
                ", areaId='" + areaId + '\'' +
                ", area='" + area + '\'' +
                ", fatherId='" + fatherId + '\'' +
                '}';
    }
}
