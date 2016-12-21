package org.uengine.garuda.util;

import java.util.ArrayList;
import java.util.Map;

/**
 * Created by uengine on 2016. 4. 27..
 */
public class Document {

    private String _id;
    private String type;
    private String service_id;
    private String creater_id;
    private Long create_date;
    private Long update_date;
    private String last_writer_id;
    private boolean is_delete;
    private ArrayList<Map<String, Object>> files;
    private ArrayList<Object> form_datas;
    private Map<String, Object> column_datas;

    public String get_id() {
        return _id;
    }

    public void set_id(String _id) {
        this._id = _id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getService_id() {
        return service_id;
    }

    public void setService_id(String service_id) {
        this.service_id = service_id;
    }

    public String getCreater_id() {
        return creater_id;
    }

    public void setCreater_id(String creater_id) {
        this.creater_id = creater_id;
    }

    public Long getCreate_date() {
        return create_date;
    }

    public void setCreate_date(Long create_date) {
        this.create_date = create_date;
    }

    public Long getUpdate_date() {
        return update_date;
    }

    public void setUpdate_date(Long update_date) {
        this.update_date = update_date;
    }

    public String getLast_writer_id() {
        return last_writer_id;
    }

    public void setLast_writer_id(String last_writer_id) {
        this.last_writer_id = last_writer_id;
    }

    public boolean is_delete() {
        return is_delete;
    }

    public void setIs_delete(boolean is_delete) {
        this.is_delete = is_delete;
    }

    public ArrayList<Map<String, Object>> getFiles() {
        return files;
    }

    public void setFiles(ArrayList<Map<String, Object>> files) {
        this.files = files;
    }

    public ArrayList<Object> getForm_datas() {
        return form_datas;
    }

    public void setForm_datas(ArrayList<Object> form_datas) {
        this.form_datas = form_datas;
    }

    public Map<String, Object> getColumn_datas() {
        return column_datas;
    }

    public void setColumn_datas(Map<String, Object> column_datas) {
        this.column_datas = column_datas;
    }
}
