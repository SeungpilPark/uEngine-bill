package org.uengine.garuda.util;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;
import com.cloudant.client.api.Database;
import com.cloudant.client.api.model.*;
import com.cloudant.client.api.views.Key;
import com.cloudant.client.api.views.ViewRequestBuilder;
import com.cloudant.client.api.views.ViewResponse;

import java.net.URL;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2016. 12. 31..
 */
public class RelTest {
    public static void main(String[] args) throws Exception {

        CloudantClient client = ClientBuilder.url(new URL("http://52.79.164.208:5984")).username("admin").password("admin").build();
        Database db = client.database("forcs_iam", true);

        String carId = "9647c65e55622a97a4295c220a002d3f";
        ViewRequestBuilder builder = db.getViewRequestBuilder("car-persons-test", "select");
        Key.ComplexKey startKey = new Key().complex(carId);
        Key.ComplexKey endKey = new Key().complex(carId).add("{}");
//        Key.ComplexKey complex2 = new Key().complex(carId);
//        Key.ComplexKey complex3 = new Key().complex(carId);


        ViewResponse<Key.ComplexKey, Map> response = builder.newRequest(Key.Type.COMPLEX, Map.class)
                .startKey(startKey).endKey(endKey)
                .includeDocs(true)
                .build().getResponse();

        List<ViewResponse.Row<Key.ComplexKey, Map>> rows = response.getRows();
        for (ViewResponse.Row<Key.ComplexKey, Map> row : rows) {
            Map value = row.getValue();
            Map doc = row.getDocumentAsType(Map.class);
            List list = JsonUtils.unmarshalToList(row.getKey().toJson());
            System.out.println(JsonUtils.marshal(value));
            System.out.println(JsonUtils.marshal(doc));
            System.out.println(JsonUtils.marshal(list));
        }
        System.out.println("end");
//        List<ViewResponse.Row<Key.ComplexKey, OauthClient>> rows = builder.newRequest(Key.Type.COMPLEX, OauthClient.class).
//                keys(complex).limit(limit).skip(skip).
//                build().getResponse().getRows();
    }
}
