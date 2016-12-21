package org.uengine.garuda.util;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;
import com.cloudant.client.api.Database;
import com.cloudant.client.api.model.DesignDocument;
import com.cloudant.client.api.views.AllDocsResponse;
import com.cloudant.client.api.views.Key;
import com.cloudant.client.api.views.ViewRequestBuilder;
import com.cloudant.client.api.views.ViewResponse;
import org.uengine.garuda.util.JsonUtils;

import java.io.IOException;
import java.net.URL;
import java.util.Date;
import java.util.List;
import java.util.Map;


public class Couchdb {
    static Database db = null;

    public static void main(String[] args) throws IOException {

        // 접속
        CloudantClient client = ClientBuilder.url(new URL("http://52.79.164.208:5984")).username("admin").password("admin").build(); //id,pw있는 경우
        //CloudantClient client = ClientBuilder.url(new URL("http://52.79.164.208:5984")).build();

        System.out.println("Server Version: " + client.serverVersion());
        db = client.database("forcs_iam", true);
        System.out.println(db.getDBUri());

        client.shutdown();
//        ArrayList<Map> list = new ArrayList<Map>();
//
//        for (int i = 0; i < 1; i++) {
//            Sample sample = new Sample();
//            sample.setTest("bbb");
//            sample.put("type", "sample");
//            sample.put("name", "name1");
//            sample.put("redDate", new Date().getTime());
//
//            list.add(sample);
//        }
//        List<com.cloudant.client.api.model.Response> responses = db.bulk(list);
//        System.out.println(responses);


        // 문서 삭제
//        Sample sample = new Sample();
//        sample.put("_id","a373e47fc75fea89d8536cf4e30696b2");
//        sample.put("_rev","1-27b8394c9c38c9a7a6a4513b8d9ffde6");
//        db.remove(sample);

        //////////////////////
        // JsonObject joJSON = new JsonObject();
        // JsonArray jaResult = new JsonArray();
        // ViewResponse<String, JsonObject> vrb =
        // db.getViewRequestBuilder("account", "id_name_by_company_id")
        // .newRequest(Key.Type.STRING, JsonObject.class)
        // .keys("B회사")
        // .build()
        // .getResponse();
        //
        // List<Row<String, JsonObject>> result = vrb.getRows();
        // for (Row<String, JsonObject> row : result) {
        // jaResult.add(row.getValue());
        // joJSON.addProperty("status", "200");
        // joJSON.addProperty("code", "-1");
        // joJSON.addProperty("message", "test");
        //
        // JsonObject joResult = new JsonObject();
        // joResult.addProperty("company_id", "B회사");
        // joResult.add("members", jaResult);
        // joJSON.add("result", joResult);
        // }
        //
        // System.out.println(joJSON);


        // 데이터베이스 목록
        // List<String> databases = client.getAllDbs();
        // System.out.println("All my databases : ");
        // for (String db : databases) {
        // System.out.println(db);
        // }

        //디자인 생성 - 뷰
//        DesignDocument designedoc = new DesignDocument();
//        designedoc.setId("_design/sample");
//        designedoc.setLanguage("javascript");
//
//        DesignDocument.MapReduce mapReduce = new DesignDocument.MapReduce();
//        mapReduce.setMap("function(doc) {if(doc.type == \"sample\"){emit(doc.name,doc);}}");
//        HashMap<String, DesignDocument.MapReduce> map = new HashMap<String, DesignDocument.MapReduce>();
//        map.put("selectById", mapReduce);
//        designedoc.setViews(map);
//        db.post(designedoc);

        // 뷰를 통한 문서 반환
//        ViewRequestBuilder selectById = db.getViewRequestBuilder("sample", "selectById");
//        ViewResponse<String, Map> response = selectById.newRequest(Key.Type.STRING, Map.class).keys("name1").build().getResponse();
//        List<ViewResponse.Row<String, Map>> rows = response.getRows();
//        for (ViewResponse.Row<String, Map> row : rows) {
//            System.out.println(JsonUtils.marshal(row));
//        }


        //뷰 찾기
        AllDocsResponse viewResponse = db.getAllDocsRequestBuilder().keys("_design/sample").includeDocs(true).build().getResponse();
        List<DesignDocument> docsAs = viewResponse.getDocsAs(DesignDocument.class);
        if (!docsAs.isEmpty()) {
            DesignDocument designDocument = docsAs.get(0);
            Map<String, DesignDocument.MapReduce> views = designDocument.getViews();
            DesignDocument.MapReduce selectById = views.get("selectById");
            String map = selectById.getMap();
            String reduce = selectById.getReduce();
            System.out.println(map);
            System.out.println(reduce);
        }

        // 멀티 키 뷰
        ViewRequestBuilder selectById = db.getViewRequestBuilder("sample", "selectById");
        Key key = new Key();
        Key.ComplexKey complex = key.complex("name1").add("uengine");
        System.out.println(complex.toJson());

        ViewResponse<Key.ComplexKey, Sample> response = selectById.newRequest(Key.Type.COMPLEX, Sample.class).
                keys(complex).
                build().getResponse();
        List<ViewResponse.Row<Key.ComplexKey, Sample>> rows = response.getRows();
        for (ViewResponse.Row<Key.ComplexKey, Sample> row : rows) {
            Sample value = row.getValue();
            Long regDate = value.getRegDate();
            System.out.println(new Date(regDate));
            System.out.println(JsonUtils.marshal(value));
        }


        //스타트 키, 엔드키
//        ViewRequestBuilder selectById = db.getViewRequestBuilder("sample", "selectById");
//        Key key = new Key();
//        Key.ComplexKey startkey = key.complex("name1").add("");
//        Key.ComplexKey endkey = key.complex("name1").add("zzzzzzzzzz");
//
//        ViewResponse<Key.ComplexKey, Map> response = selectById.newRequest(Key.Type.COMPLEX, Map.class).
//                //keys(complex).
//                startKey(startkey).
//                endKey(endkey).
//                build().getResponse();
//        List<ViewResponse.Row<Key.ComplexKey, Map>> rows = response.getRows();
//        for (ViewResponse.Row<Key.ComplexKey, Map> row : rows) {
//            Map value = row.getValue();
//            System.out.println(JsonUtils.marshal(value));
//        }


        //조인 쿼리



        // ViewResponse<String, String> vrb = db.getViewRequestBuilder("rest",
        // "GP_001").newRequest(Key.Type.STRING, String.class)
        // .build()
        // .getResponse();
        // List<Row<String, String>> result = vrb.getRows();
        // System.out.println(result.get(0).getValue());

        // // 문서 하나 존재 확인
        // AllDocsResponse response =
        // db.getAllDocsRequestBuilder().keys("_design/test").build().getResponse();
        // System.out.println(response.getIdsAndRevs().get("_design/test"));

        // 전체에서 id값으로 문서 하나 반환
        // List<ServiceSubscription> list =
        // db.getAllDocsRequestBuilder().keys("SS1").includeDocs(true).build().getResponse().getDocsAs(ServiceSubscription.class);
        // ServiceSubscription s = list.get(0);
        // System.out.println(s.get_id());
        // System.out.println(s.getCompany_id());
        // s.setCompany_id("C회사");
        // db.update(s);

        // //문서 저장
        // Campaign c = new Campaign();
        // c.setStart_date(new Date(100, 1, 1));
        // db.save(c);


        // //디자인 생성 - full text index
        // DesignDocument designedoc = new DesignDocument();
        // designedoc.setId("_design/java");
        // designedoc.setLanguage("javascript");
        //
        // JsonObject joIndex = new JsonObject();
        // joIndex.addProperty("index", "function(doc) { var ret=new Document();
        // ret.add(doc.name); log.info('doc has name: ' + '[' + doc.name +']');
        // return ret; }");
        // JsonObject joByName = new JsonObject();
        // joByName.add("by_name", joIndex.getAsJsonObject());
        // designedoc.setFulltext(joByName);
        //
        // db.post(designedoc);

        // //디자인 생성 - 뷰, 리스트
        // DesignDocument designedoc = new DesignDocument();
        // designedoc.setId("_design/test");
        // designedoc.setLanguage("javascript");
        //
        // MapReduce mapReduce = new MapReduce();
        // mapReduce.setMap("function(doc)
        // {if(doc.type=='account'){emit(doc._id, doc.name);}}");
        //
        // HashMap<String, MapReduce> map = new HashMap<String, MapReduce>();
        // map.put("MM_001", mapReduce);
        //
        // mapReduce = new MapReduce();
        // mapReduce.setMap("function(doc)
        // {if(doc.type=='company'){emit(doc._id, doc.group);}}");
        // map.put("GP_001", mapReduce);
        //
        // mapReduce = new MapReduce();
        // mapReduce.setMap("function(doc)
        // {if(doc.type=='serviceSubs'){emit(doc._id, {id : doc.campaign.id,
        // campaignGroup : doc.campaign.campaignGroup, campaignAdmin :
        // doc.campaign.campaignAdmin});}}");
        // map.put("CM_001", mapReduce);
        //
        // mapReduce = null;
        // designedoc.setViews(map);
        //
        // HashMap<String, String> list = new HashMap<String, String>();
        // list.put("MM_001", "function(head, req){}");
        // list.put("GP_001", "function(head, req){}");
        // list.put("CM_001_Group", "function(head, req){}");
        // list.put("CM_001_User", "function(head, req){}");
        // designedoc.setLists(list);
        // db.post(designedoc);

        // //문서 수정
        // ViewResponse<String, Company> vrb = db.getViewRequestBuilder("java",
        // "group")
        // .newRequest(Key.Type.STRING, Company.class).build().getResponse();
        // List<Row<String, Company>> result = vrb.getRows();
        // for (Row<String, Company> row : result) {
        // Company c = row.getValue();
        // c.name = "change";
        // db.update(c);
        // }
    }
}