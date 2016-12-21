package org.uengine.garuda.util;

import com.cloudant.client.api.views.Key;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;

/**
 * Created by uengine on 2016. 4. 28..
 */
public class KeyExtent extends Key{

    public static KeyExtent.ComplexKey complex() {
        return (new KeyExtent.ComplexKey(null));
    }

    public static KeyExtent.ComplexKey complex(Object... objects) {
        return (new KeyExtent.ComplexKey(null)).add(objects);
    }

    public static final class ComplexKey {
        private static final Gson gson = (new GsonBuilder()).create();
        private JsonArray json;

        private ComplexKey() {
            this.json = new JsonArray();
        }

        private ComplexKey(JsonArray json) {
            this.json = new JsonArray();
            this.json = json;
        }

        private <T> KeyExtent.ComplexKey addObjects(T... keys) {
            Object[] var2 = keys;
            int var3 = keys.length;

            for(int var4 = 0; var4 < var3; ++var4) {
                Object key = var2[var4];
                this.json.add(gson.toJsonTree(key));
            }

            return this;
        }

        public KeyExtent.ComplexKey add(String... stringKeys) {
            return this.addObjects(stringKeys);
        }

        public KeyExtent.ComplexKey add(Object... objects) {
            return this.addObjects(objects);
        }

        public KeyExtent.ComplexKey add(Boolean... booleanKeys) {
            return this.addObjects(booleanKeys);
        }

        public KeyExtent.ComplexKey add(Number... numberKeys) {
            return this.addObjects(numberKeys);
        }

        public String toJson() {
            return this.json.toString();
        }

        public boolean equals(Object o) {
            if(this == o) {
                return true;
            } else if(o != null && this.getClass() == o.getClass()) {
                KeyExtent.ComplexKey that = (KeyExtent.ComplexKey)o;
                return this.json.equals(that.json);
            } else {
                return false;
            }
        }

        public int hashCode() {
            return this.json.hashCode();
        }
    }
}
