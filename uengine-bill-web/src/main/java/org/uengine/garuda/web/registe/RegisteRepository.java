package org.uengine.garuda.web.registe;

public interface RegisteRepository {

    Registe selectByUserIdAndToken(Registe registe);

    Registe insert(Registe registe);

}
