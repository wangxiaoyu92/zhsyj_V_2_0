package com.zzhdsoft.utils;

import java.beans.PropertyDescriptor;
import java.lang.reflect.InvocationTargetException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

import org.apache.commons.beanutils.BeanUtilsBean;
import org.apache.commons.beanutils.DynaBean;
import org.apache.commons.beanutils.DynaProperty;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class BeanCopyUtil extends BeanUtilsBean{

    private static final Logger log=LoggerFactory.getLogger(BeanCopyUtil.class);

    public static final int ALL= 0 ;
    public static final int IGNORE_NULL= 1 ;
    public static final int ONLY_CHANGE= 2 ;

    /**
    *
    * @param dest 目标对象
    * @param orig 源对象
    * @param flag 是否忽略null值
    * @throws IllegalAccessException
    * @throws InvocationTargetException
    */
     public void copyProperties( Object orig,Object dest,int flag)
           throws IllegalAccessException, InvocationTargetException {


           // Validate existence of the specified beans
           if (dest == null) {
               throw new IllegalArgumentException
                       ("No destination bean specified");
           }
           if (orig == null) {
               throw new IllegalArgumentException("No origin bean specified");
           }
           if (log.isDebugEnabled()) {
               log.debug("BeanUtils.copyProperties(" + dest + ", " +
                         orig + "," + flag + ")");
           }


           // Copy the properties, converting as necessary
           if (orig instanceof DynaBean) {
               DynaProperty[] origDescriptors =
                   ((DynaBean) orig).getDynaClass().getDynaProperties();
               for (int i = 0; i < origDescriptors.length; i++) {
                   String name = origDescriptors[i].getName();
                   // Need to check isReadable() for WrapDynaBean
                   // (see Jira issue# BEANUTILS-61)
                   if (getPropertyUtils().isReadable(orig, name) &&
                       getPropertyUtils().isWriteable(dest, name)) {
                       Object orgValue = ((DynaBean) orig).get(name);
                       Object destValue = ((DynaBean) dest).get(name);
                       doCopyValue(dest,orgValue,destValue,flag,name);
                   }
               }
           } else if (orig instanceof Map) {
               @SuppressWarnings("unchecked")
               // Map properties are always of type <String, Object>
               Map<String, Object> propMap = (Map<String, Object>) orig;
               for (Map.Entry<String, Object> entry : propMap.entrySet()) {
                   String name = entry.getKey();
                   Object orgValue=entry.getValue();
                   Object destValue=((DynaBean) dest).get(name);
                   if (getPropertyUtils().isWriteable(dest, name)) {
                       doCopyValue(dest,orgValue,destValue,flag,name);
                   }
               }
           } else /* if (orig is a standard JavaBean) */ {
               PropertyDescriptor[] origDescriptors =
                   getPropertyUtils().getPropertyDescriptors(orig);
               for (int i = 0; i < origDescriptors.length; i++) {
                   String name = origDescriptors[i].getName();
                   if ("class".equals(name)) {
                       continue; // No point in trying to set an object's class
                   }
                   if (getPropertyUtils().isReadable(orig, name) &&
                       getPropertyUtils().isWriteable(dest, name)) {
                       try {
                           Object orgValue =
                               getPropertyUtils().getSimpleProperty(orig, name);
                           Object destValue =
                                   getPropertyUtils().getSimpleProperty(dest, name);
                           doCopyValue(dest,orgValue,destValue,flag,name);
                       //gu20171216 } catch (NoSuchMethodException e) {
                           } catch (Exception e) {    
                           // Should not happen
                        	   e.printStackTrace();
                       }
                   }
               }
           }
     }

    private void doCopyValue(Object dest,Object orgValue, Object destValue,int flag,String name)
        throws IllegalAccessException, InvocationTargetException {
        switch (flag){
            case IGNORE_NULL:
                if(orgValue!=null){
                    copyProperty(dest, name, orgValue);
                }
                break;
            case ONLY_CHANGE:
                if(orgValue==null||"".equals(orgValue)||"null".equals(orgValue)){
                    if(!(destValue==null||"null".equals(destValue)||"".equals(destValue))){
                        copyProperty(dest, name, orgValue);
                        log.debug("==name=" + name + " value changed from '" + destValue + "' to '" + orgValue+"'.");
                    }
                }else {
                    if(!orgValue.equals(destValue)) {
                        copyProperty(dest, name, orgValue);
                        log.debug("name=" + name + " value changed from '" + destValue + "' to '" + orgValue+"'.");
                    }
                }
                break;
            default:
                copyProperty(dest, name, orgValue);
                break;
        }
    }

}
