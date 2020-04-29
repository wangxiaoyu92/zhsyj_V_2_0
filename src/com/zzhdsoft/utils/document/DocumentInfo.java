package com.zzhdsoft.utils.document;

import java.lang.annotation.*;

/**
 * Created by Elfy Suen on 2017/10/17.
 */
@Retention(RetentionPolicy.RUNTIME)
@Target({ElementType.TYPE, ElementType.METHOD})
@Documented
public @interface DocumentInfo {
    String name();
    String desc();
    String functiondesc();
    String author();
    String params();
    String returndesc();
    String date();
    String version() default "v1.0.0";
    int sort() default 0;
}
