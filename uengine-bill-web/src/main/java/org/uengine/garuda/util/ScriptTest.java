package org.uengine.garuda.util;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.ScriptableObject;
import org.mozilla.javascript.tools.shell.Global;
import org.mozilla.javascript.tools.shell.Main;
import org.uengine.garuda.util.ResourceUtils;
import org.uengine.garuda.web.console.oauthuser.OauthUser;

import java.io.File;
import java.nio.file.Files;
import java.util.List;
import java.util.Map;

/**
 * Created by uengine on 2016. 5. 9..
 */
public class ScriptTest {

    public static void main(String[] args) throws Exception {


        File file = ResourceUtils.getFile("classpath:rhino");
        String path = file.getAbsolutePath();

        try {
            OauthUser user = new OauthUser();
            user.setUserPassword("aaaa");

            //Context cx = org.mozilla.javascript.ContextFactory.getGlobal().enterContext();
            Context cx = Context.enter();
            Global global = new Global(cx);
            cx.setOptimizationLevel(-1);
            cx.setLanguageVersion(Context.VERSION_1_5);
            //Global global = Main.getGlobal();
            //global.init(cx);

            Main.processFile(cx, global, path + "/env.rhino.1.2.js");
            //Main.processSource(cx, path + "/jquery.min.js");

            Object wrappedUser = Context.javaToJS(user, global);
            ScriptableObject.putProperty(global, "user", wrappedUser);


            String engineJs = new String(Files.readAllBytes(new File(path + "/engine.js").toPath()));
            cx.evaluateString(global, engineJs, "script", 1, null);
            org.mozilla.javascript.Function run = (org.mozilla.javascript.Function) global.get("run", global);
            Object result = run.call(cx, global, global, new Object[]{});
            //Object result = cx.evaluateString(global, engineJs, "<cmd>", 1, null);
            //System.out.println(cx.toString(result));
            Map map = (Map) Context.jsToJava(result, Map.class);
            List list = (List) map.get("log");

            for (int i = 0; i < list.size(); i++) {
                Object o = list.get(i);
                System.out.println(o.toString());
            }


        } finally {
            Context.exit();
        }
    }
}
