package org.uengine.garuda.web.rest;

import org.uengine.garuda.web.management.Management;

import javax.servlet.http.HttpServletRequest;

public interface RestAuthService {
    Management managementParser(HttpServletRequest request);
}
