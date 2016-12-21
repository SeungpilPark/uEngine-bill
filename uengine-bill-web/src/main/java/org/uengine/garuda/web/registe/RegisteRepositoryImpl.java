package org.uengine.garuda.web.registe;

import com.cloudant.client.api.model.Response;
import com.cloudant.client.api.views.Key;
import com.cloudant.client.api.views.ViewRequestBuilder;
import org.uengine.garuda.couchdb.CouchServiceFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.Date;

@Repository
public class RegisteRepositoryImpl implements RegisteRepository {

    private String NAMESPACE = "registe";

    @Autowired
    CouchServiceFactory serviceFactory;

    @Override
    public Registe insert(Registe registe) {
        long time = new Date().getTime();
        registe.setDocType(NAMESPACE);
        registe.setRegDate(time);
        registe.setUpdDate(time);

        Response response = serviceFactory.getDb().save(registe);
        registe.set_id(response.getId());
        registe.set_rev(response.getRev());
        return registe;
    }


    @Override
    public Registe selectByUserIdAndToken(Registe registe) {
        try {
            ViewRequestBuilder builder = serviceFactory.getDb().getViewRequestBuilder(NAMESPACE, "selectByUserIdAndToken");
            Key.ComplexKey complex = new Key().complex(registe.getUserId()).add(registe.getToken());
            return builder.newRequest(Key.Type.COMPLEX, Registe.class).
                    keys(complex).
                    build().getResponse().getRows().get(0).getValue();
        } catch (Exception ex) {
            return null;
        }
    }
}
