package org.uengine.garuda.couchdb;

import com.cloudant.client.api.ClientBuilder;
import com.cloudant.client.api.CloudantClient;
import com.cloudant.client.api.Database;
import org.uengine.garuda.common.exception.ServiceException;
import org.uengine.garuda.util.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.net.URL;

/**
 * Created by uengine on 2016. 4. 28..
 */
@Component
public class CouchServiceFactory {

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(CouchServiceFactory.class);

    @Value("#{config['couch.db.url']}")
    private String url;

    @Value("#{config['couch.db.username']}")
    private String username;

    @Value("#{config['couch.db.password']}")
    private String password;

    @Value("#{config['couch.db.database']}")
    private String database;

    public Database getDb() {
        try {
            if (StringUtils.isEmpty(username) || StringUtils.isEmpty(password)) {
                CloudantClient client = ClientBuilder.url(new URL(url)).build();
                return client.database(database, true);

            } else {
                CloudantClient client = ClientBuilder.url(new URL(url)).username(username).password(password).build();
                return client.database(database, true);
            }
        } catch (Exception ex) {
            logger.error("Unable connect CouchDatabase {}", url);
            throw new ServiceException(ex);
        }
    }
}
