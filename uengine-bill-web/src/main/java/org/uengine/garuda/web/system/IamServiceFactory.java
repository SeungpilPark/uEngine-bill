package org.uengine.garuda.web.system;

import org.opencloudengine.garuda.client.IamClient;
import org.opencloudengine.garuda.common.exception.ServiceException;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import java.util.Properties;

/**
 * Created by uengine on 2016. 6. 16..
 */
@Component
public class IamServiceFactory {

    @Autowired
    @Qualifier("config")
    private Properties config;

    @Value("#{config['iam.trust.client.key']}")
    private String trustKey;

    @Value("#{config['iam.trust.client.secret']}")
    private String trustSecret;

    @Value("#{config['iam.host']}")
    private String host;

    @Value("#{config['iam.port']}")
    private int port;

    /**
     * SLF4J Logging
     */
    private Logger logger = LoggerFactory.getLogger(IamServiceFactory.class);

    public IamClient trustClient() {
        return new IamClient(host, port, trustKey, trustSecret);
    }

    public IamClient thirdPartyClient(String clientKey, String clientSecret) {
        return new IamClient(host, port, clientKey, clientSecret);
    }
}
